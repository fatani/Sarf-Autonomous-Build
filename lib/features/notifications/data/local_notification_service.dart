import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/core/utils/notification_ids.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

class LocalNotificationService {
  LocalNotificationService(
    this._scheduleRepository,
    this._settingsRepository, {
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final NotificationScheduleRepository _scheduleRepository;
  final SettingsRepository _settingsRepository;
  final FlutterLocalNotificationsPlugin _plugin;
  final _uuid = const Uuid();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    tz_data.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.notificationChannelId,
        'Commitment reminders',
        description: 'Local reminders for upcoming commitments',
        importance: Importance.defaultImportance,
      ),
    );

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    await initialize();
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final androidGranted = await androidPlugin?.requestNotificationsPermission();
    final iosPlugin =
        _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final iosGranted = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (androidGranted != null) {
      return androidGranted;
    }
    if (iosGranted != null) {
      return iosGranted;
    }
    return true;
  }

  Future<bool> permissionsGranted() async {
    await initialize();
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final androidGranted = await androidPlugin?.areNotificationsEnabled();
    if (androidGranted != null) {
      return androidGranted;
    }
    return true;
  }

  Future<void> syncCommitmentReminder({
    required CommitmentModel commitment,
    required bool notificationsEnabled,
    required String notificationTitle,
    required String Function(String name, String amount, String date) notificationBody,
  }) async {
    await initialize();
    await _cancelForCommitment(commitment.id);

    if (!notificationsEnabled ||
        commitment.isDeleted ||
        commitment.isPaused ||
        commitment.reminderDaysBefore == null) {
      return;
    }

    final reminderDate = DateUtilsSarf.startOfDay(commitment.nextDueDate)
        .subtract(Duration(days: commitment.reminderDaysBefore!));
    final scheduledAt = DateTime(
      reminderDate.year,
      reminderDate.month,
      reminderDate.day,
      9,
      0,
    );

    if (scheduledAt.isBefore(DateTime.now())) {
      return;
    }

    final existing = await _scheduleRepository.getForCommitment(commitment.id);
    final notificationId = existing.isNotEmpty
        ? existing.first.notificationId
        : NotificationIds.commitmentReminder(commitment.id);
    final scheduleId = _uuid.v4();
    final tzScheduled = tz.TZDateTime.from(scheduledAt, tz.local);

    try {
      await _plugin.zonedSchedule(
        notificationId,
        notificationTitle,
        notificationBody(
          commitment.name,
          '${commitment.amount.toStringAsFixed(2)} ${commitment.currency}',
          DateUtilsSarf.startOfDay(commitment.nextDueDate).toIso8601String().split('T').first,
        ),
        tzScheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            'Commitment reminders',
            channelDescription: 'Local reminders for upcoming commitments',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        // inexact: Android may delay up to ~15 min — acceptable for subscription reminders
        // and requires no special permission (avoids exact_alarms_not_permitted on API 31+).
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Notification scheduling failed (e.g. permission revoked). Commitment is still saved.
      // ignore: avoid_print
      print('[LocalNotificationService] syncCommitmentReminder failed: $e');
      return;
    }

    await _scheduleRepository.replaceForCommitment(
      commitmentId: commitment.id,
      schedules: [
        ScheduledNotificationRecord(
          id: scheduleId,
          commitmentId: commitment.id,
          scheduledAt: scheduledAt.toUtc(),
          notificationId: notificationId,
          status: 'scheduled',
        ),
      ],
    );
  }

  Future<void> syncTrialReminder({
    required bool notificationsEnabled,
    required String title,
    required String Function(int days) body,
  }) async {
    await initialize();
    await _plugin.cancel(NotificationIds.trialReminder);

    if (!notificationsEnabled) {
      return;
    }

    final firstLaunch = await _settingsRepository.ensureFirstLaunchAt();
    final trialEnd = firstLaunch.add(const Duration(days: AppConstants.trialPeriodDays));
    final reminderAt = DateTime(
      trialEnd.year,
      trialEnd.month,
      trialEnd.day - AppConstants.trialReminderDaysBefore,
      9,
      0,
    );

    if (reminderAt.isBefore(DateTime.now())) {
      return;
    }

    try {
      await _plugin.zonedSchedule(
        NotificationIds.trialReminder,
        title,
        body(AppConstants.trialReminderDaysBefore),
        tz.TZDateTime.from(reminderAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            'Commitment reminders',
            channelDescription: 'Local reminders for upcoming commitments',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // ignore: avoid_print
      print('[LocalNotificationService] syncTrialReminder failed: $e');
    }
  }

  Future<void> syncWeeklyDigest({
    required bool notificationsEnabled,
    required List<CommitmentModel> commitments,
    required String title,
    required String Function(int count, String amount) body,
    required String currency,
  }) async {
    await initialize();
    await _plugin.cancel(NotificationIds.weeklyDigest);

    if (!notificationsEnabled) {
      return;
    }

    final now = DateTime.now();
    final scheduledAt = DateUtilsSarf.nextWeekdayAtTime(
      now,
      weekday: DateTime.monday,
    );

    final upcoming = commitments.where((c) {
      if (!c.isActive) {
        return false;
      }
      final days = DateUtilsSarf.daysUntil(c.nextDueDate, now);
      return days >= 0 && days <= AppConstants.upcomingPaymentsWindowDays;
    }).toList();

    final total = upcoming.fold<double>(0, (sum, c) => sum + c.amount);

    try {
      await _plugin.zonedSchedule(
        NotificationIds.weeklyDigest,
        title,
        body(upcoming.length, '${total.toStringAsFixed(2)} $currency'),
        tz.TZDateTime.from(scheduledAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            'Commitment reminders',
            channelDescription: 'Local reminders for upcoming commitments',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexact,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // ignore: avoid_print
      print('[LocalNotificationService] syncWeeklyDigest failed: $e');
    }
  }

  Future<void> cancelForCommitment(String commitmentId) async {
    await _cancelForCommitment(commitmentId);
  }

  Future<void> rescheduleAll({
    required List<CommitmentModel> commitments,
    required bool notificationsEnabled,
    required String defaultCurrency,
    required String notificationTitle,
    required String Function(String name, String amount, String date) notificationBody,
    required String trialReminderTitle,
    required String Function(int days) trialReminderBody,
    required String weeklyDigestTitle,
    required String Function(int count, String amount) weeklyDigestBody,
  }) async {
    for (final commitment in commitments) {
      await syncCommitmentReminder(
        commitment: commitment,
        notificationsEnabled: notificationsEnabled,
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
      );
    }
    await syncTrialReminder(
      notificationsEnabled: notificationsEnabled,
      title: trialReminderTitle,
      body: trialReminderBody,
    );
    await syncWeeklyDigest(
      notificationsEnabled: notificationsEnabled,
      commitments: commitments,
      title: weeklyDigestTitle,
      body: weeklyDigestBody,
      currency: defaultCurrency,
    );
  }

  Future<void> _cancelForCommitment(String commitmentId) async {
    final existing = await _scheduleRepository.getForCommitment(commitmentId);
    for (final schedule in existing) {
      await _plugin.cancel(schedule.notificationId);
      await _scheduleRepository.markCancelled(schedule.id);
    }
    await _scheduleRepository.replaceForCommitment(
      commitmentId: commitmentId,
      schedules: const [],
    );
  }

}
