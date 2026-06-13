// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sarf';

  @override
  String get navCommitments => 'Commitments';

  @override
  String get navTemplates => 'Templates';

  @override
  String get navInsights => 'Insights';

  @override
  String get navSettings => 'Settings';

  @override
  String get commitmentsTitle => 'Commitments';

  @override
  String get commitmentsEmptyTitle => 'No commitments yet';

  @override
  String get commitmentsEmptyBody =>
      'Add your recurring bills and subscriptions to stay on top of what you owe.';

  @override
  String get addCommitment => 'Add commitment';

  @override
  String get editCommitment => 'Edit commitment';

  @override
  String get deleteCommitment => 'Delete commitment';

  @override
  String get deleteCommitmentConfirm =>
      'This commitment will be hidden from your list. You can restore it later from archived items.';

  @override
  String get nameLabel => 'Name';

  @override
  String get amountLabel => 'Amount';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get billingCycleLabel => 'Billing cycle';

  @override
  String get nextDueDateLabel => 'Next due date';

  @override
  String get reminderDaysLabel => 'Reminder (days before)';

  @override
  String get notesLabel => 'Notes';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get restore => 'Restore';

  @override
  String get archived => 'Archived';

  @override
  String get showArchived => 'Show archived';

  @override
  String get hideArchived => 'Hide archived';

  @override
  String get paused => 'Paused';

  @override
  String get active => 'Active';

  @override
  String get pauseCommitment => 'Pause';

  @override
  String get resumeCommitment => 'Resume';

  @override
  String get billingCycleMonthly => 'Monthly';

  @override
  String get billingCycleQuarterly => 'Quarterly';

  @override
  String get billingCycleYearly => 'Yearly';

  @override
  String get billingCycleWeekly => 'Weekly';

  @override
  String get billingCycleOneTime => 'One-time';

  @override
  String get categoryLabel => 'Category';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryTelecom => 'Telecom';

  @override
  String get categoryUtilities => 'Utilities';

  @override
  String get categoryStorage => 'Storage';

  @override
  String get categoryOther => 'Other';

  @override
  String get templatesTitle => 'Service templates';

  @override
  String get templatesSubtitle => 'Quick-start from common services';

  @override
  String get useTemplate => 'Use template';

  @override
  String get searchTemplates => 'Search templates';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get monthlyTotal => 'Monthly total';

  @override
  String get yearlyProjection => 'Yearly projection';

  @override
  String get upcomingDues => 'Upcoming dues';

  @override
  String get dueToday => 'Due today';

  @override
  String dueInDays(int days) {
    return 'Due in $days days';
  }

  @override
  String get overdue => 'Overdue';

  @override
  String get byCategory => 'By category';

  @override
  String activeCount(int count) {
    return '$count active';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get systemDefault => 'System default';

  @override
  String get notificationsLabel => 'Local reminders';

  @override
  String get notificationsEnabled => 'Enable reminders';

  @override
  String get notificationsDisabledHint => 'Reminders stay on your device only.';

  @override
  String get defaultCurrencyLabel => 'Default currency';

  @override
  String get legalSection => 'Legal';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfUse => 'Terms of use';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutBody =>
      'Sarf helps you track recurring commitments locally. Your data never leaves your device.';

  @override
  String get versionLabel => 'Version';

  @override
  String get privacyTitle => 'Privacy policy';

  @override
  String get privacyBody =>
      'Sarf is privacy-first. All commitment data is stored locally on your device in SQLite. We do not collect, transmit, or store your personal data on any server. Local notifications are scheduled on your device only. You can delete the app at any time to remove all data.';

  @override
  String get termsTitle => 'Terms of use';

  @override
  String get termsBody =>
      'Sarf is provided as-is for personal commitment tracking. It is not financial advice. You are responsible for the accuracy of amounts and dates you enter. The app works fully offline and does not connect to banks or third-party services.';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidAmount => 'Enter a valid amount';

  @override
  String get noReminder => 'No reminder';

  @override
  String reminderDaysOption(int days) {
    return '$days days before';
  }

  @override
  String get notificationChannelName => 'Commitment reminders';

  @override
  String get notificationChannelDescription =>
      'Local reminders for upcoming commitments';

  @override
  String get notificationTitle => 'Upcoming commitment';

  @override
  String notificationBody(String name, String amount, String date) {
    return '$name — $amount due on $date';
  }

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String dueDate(String date) {
    return 'Due $date';
  }

  @override
  String get commitmentDetailsTitle => 'Commitment details';

  @override
  String get edit => 'Edit';

  @override
  String get mostExpensive => 'Top expenses';

  @override
  String get viewReport => 'View report';

  @override
  String get reportsTitle => 'Spending report';

  @override
  String get reportsSubtitle => 'Monthly breakdown by category';

  @override
  String get reportPeriod => 'Report period';

  @override
  String get reportTotal => 'Total monthly';

  @override
  String get notificationPermissionDenied =>
      'Notification permission was denied. Enable it in system settings to receive reminders.';

  @override
  String get weeklyDigestTitle => 'Weekly digest';

  @override
  String weeklyDigestBody(int count, String amount) {
    return '$count payments due this week — $amount total';
  }

  @override
  String get onboardingValueTitle => 'Know what you need to pay this month.';

  @override
  String get onboardingPrivacyTitle => 'Your data stays on your device.';

  @override
  String get onboardingStartTitle =>
      'Add your first commitment and start clearly.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Start';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importBackupConfirmTitle => 'Replace all data?';

  @override
  String get importBackupConfirmBody =>
      'Importing will replace your current commitments, custom templates, settings, and notification schedules. Built-in templates are kept. This cannot be undone.';

  @override
  String get backupExportFailed => 'Could not export backup.';

  @override
  String get backupImportSuccess => 'Backup restored successfully.';

  @override
  String get backupImportInvalidApp => 'This file is not a Sarf backup.';

  @override
  String get backupImportUnsupportedVersion =>
      'This backup version is not supported.';

  @override
  String get backupImportUnsupportedSchema =>
      'This backup uses a newer schema than this app supports.';

  @override
  String get backupImportInvalidFormat =>
      'The selected file is not a valid backup.';

  @override
  String get diagnosticsSection => 'Diagnostics';

  @override
  String get exportCrashLog => 'Export crash log';

  @override
  String get exportCrashLogHint =>
      'Local error log only. Share manually if you need help.';

  @override
  String get crashLogEmpty => 'No crash log entries yet.';

  @override
  String get errorScreenTitle => 'Something went wrong';

  @override
  String get errorScreenBody =>
      'The app hit an unexpected error. Restart the app to continue.';

  @override
  String get suggestedDefaultHint => 'Suggested default only';

  @override
  String get amountSectionTitle => 'Amount';

  @override
  String get paymentSectionTitle => 'Payment';

  @override
  String get originalAmountLabel => 'Original amount';

  @override
  String get originalCurrencyLabel => 'Original currency';

  @override
  String paidAmountInReportingCurrency(String currency) {
    return 'Paid amount in $currency';
  }

  @override
  String get invalidPaidAmount => 'Enter the actual amount charged';

  @override
  String get paidAmountLabel => 'Paid in reporting currency';

  @override
  String get effectiveRateLabel => 'Effective rate';

  @override
  String effectiveRate(
    String rate,
    String reportingCurrency,
    String originalCurrency,
  ) {
    return '$rate $reportingCurrency / $originalCurrency';
  }

  @override
  String get paymentMethodLabel => 'Payment method';

  @override
  String get paymentMethodCard => 'Card';

  @override
  String get paymentMethodMada => 'Mada';

  @override
  String get paymentMethodApplePay => 'Apple Pay';

  @override
  String get paymentMethodBankTransfer => 'Bank transfer';

  @override
  String get paymentMethodCash => 'Cash';

  @override
  String get paymentMethodOther => 'Other';

  @override
  String get paymentSourceLabel => 'Payment source';

  @override
  String get paymentSourceHint => 'Optional — e.g. Al Rajhi Visa';

  @override
  String get amountPaidArrow => '→';

  @override
  String paidBy(String source) {
    return 'Paid by: $source';
  }
}
