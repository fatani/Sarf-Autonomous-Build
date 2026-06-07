import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/locale_utils.dart';
import 'package:uuid/uuid.dart';

class CommitmentActions {
  CommitmentActions(this._ref);

  final Ref _ref;
  final _uuid = const Uuid();

  Future<void> save(CommitmentModel commitment) async {
    final repository = _ref.read(commitmentRepositoryProvider);
    await repository.upsert(commitment);
    await _syncNotification(commitment);
  }

  Future<CommitmentModel> createFromInput({
    required CommitmentModel draft,
  }) async {
    final now = DateTime.now().toUtc();
    final commitment = CommitmentModel(
      id: draft.id.isEmpty ? _uuid.v4() : draft.id,
      name: draft.name,
      amount: draft.amount,
      currency: draft.currency,
      billingCycle: draft.billingCycle,
      category: draft.category,
      nextDueDate: draft.nextDueDate,
      reminderDaysBefore: draft.reminderDaysBefore,
      notes: draft.notes,
      templateId: draft.templateId,
      isPaused: draft.isPaused,
      deletedAt: draft.deletedAt,
      createdAt: draft.createdAt == DateTime.fromMillisecondsSinceEpoch(0)
          ? now
          : draft.createdAt,
      updatedAt: now,
    );
    await save(commitment);
    return commitment;
  }

  Future<void> softDelete(String id) async {
    final repository = _ref.read(commitmentRepositoryProvider);
    await repository.softDelete(id);
    await _ref.read(localNotificationServiceProvider).cancelForCommitment(id);
  }

  Future<void> restore(String id) async {
    final repository = _ref.read(commitmentRepositoryProvider);
    await repository.restore(id);
    final commitment = await repository.getCommitment(id);
    if (commitment != null) {
      await _syncNotification(commitment);
    }
  }

  Future<void> setPaused(String id, bool paused) async {
    final repository = _ref.read(commitmentRepositoryProvider);
    await repository.setPaused(id, paused);
    final commitment = await repository.getCommitment(id);
    if (commitment != null) {
      await _syncNotification(commitment);
    }
  }

  Future<void> _syncNotification(CommitmentModel commitment) async {
    final settings = await _ref.read(settingsProvider.future);
    final l10n = LocaleUtils.notificationLocalizations(settings.localePreference);
    await _ref.read(localNotificationServiceProvider).syncCommitmentReminder(
          commitment: commitment,
          notificationsEnabled: settings.notificationsEnabled,
          notificationTitle: l10n.notificationTitle,
          notificationBody: (name, amount, date) =>
              l10n.notificationBody(name, amount, date),
        );
  }
}

final commitmentActionsProvider = Provider<CommitmentActions>((ref) {
  return CommitmentActions(ref);
});
