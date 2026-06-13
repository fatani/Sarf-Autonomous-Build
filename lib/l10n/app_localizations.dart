import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Sarf'**
  String get appTitle;

  /// No description provided for @navCommitments.
  ///
  /// In en, this message translates to:
  /// **'Commitments'**
  String get navCommitments;

  /// No description provided for @navTemplates.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get navTemplates;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @commitmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Commitments'**
  String get commitmentsTitle;

  /// No description provided for @commitmentsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No commitments yet'**
  String get commitmentsEmptyTitle;

  /// No description provided for @commitmentsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your recurring bills and subscriptions to stay on top of what you owe.'**
  String get commitmentsEmptyBody;

  /// No description provided for @addCommitment.
  ///
  /// In en, this message translates to:
  /// **'Add commitment'**
  String get addCommitment;

  /// No description provided for @editCommitment.
  ///
  /// In en, this message translates to:
  /// **'Edit commitment'**
  String get editCommitment;

  /// No description provided for @deleteCommitment.
  ///
  /// In en, this message translates to:
  /// **'Delete commitment'**
  String get deleteCommitment;

  /// No description provided for @deleteCommitmentConfirm.
  ///
  /// In en, this message translates to:
  /// **'This commitment will be hidden from your list. You can restore it later from archived items.'**
  String get deleteCommitmentConfirm;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @currencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyLabel;

  /// No description provided for @billingCycleLabel.
  ///
  /// In en, this message translates to:
  /// **'Billing cycle'**
  String get billingCycleLabel;

  /// No description provided for @nextDueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Next due date'**
  String get nextDueDateLabel;

  /// No description provided for @reminderDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder (days before)'**
  String get reminderDaysLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @showArchived.
  ///
  /// In en, this message translates to:
  /// **'Show archived'**
  String get showArchived;

  /// No description provided for @hideArchived.
  ///
  /// In en, this message translates to:
  /// **'Hide archived'**
  String get hideArchived;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @pauseCommitment.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseCommitment;

  /// No description provided for @resumeCommitment.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeCommitment;

  /// No description provided for @billingCycleMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingCycleMonthly;

  /// No description provided for @billingCycleQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get billingCycleQuarterly;

  /// No description provided for @billingCycleYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billingCycleYearly;

  /// No description provided for @billingCycleWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get billingCycleWeekly;

  /// No description provided for @billingCycleOneTime.
  ///
  /// In en, this message translates to:
  /// **'One-time'**
  String get billingCycleOneTime;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @categoryEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get categoryEntertainment;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryTelecom.
  ///
  /// In en, this message translates to:
  /// **'Telecom'**
  String get categoryTelecom;

  /// No description provided for @categoryUtilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get categoryUtilities;

  /// No description provided for @categoryStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get categoryStorage;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @templatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Service templates'**
  String get templatesTitle;

  /// No description provided for @templatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick-start from common services'**
  String get templatesSubtitle;

  /// No description provided for @useTemplate.
  ///
  /// In en, this message translates to:
  /// **'Use template'**
  String get useTemplate;

  /// No description provided for @searchTemplates.
  ///
  /// In en, this message translates to:
  /// **'Search templates'**
  String get searchTemplates;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @monthlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Monthly total'**
  String get monthlyTotal;

  /// No description provided for @yearlyProjection.
  ///
  /// In en, this message translates to:
  /// **'Yearly projection'**
  String get yearlyProjection;

  /// No description provided for @upcomingDues.
  ///
  /// In en, this message translates to:
  /// **'Upcoming dues'**
  String get upcomingDues;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get dueToday;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {days} days'**
  String dueInDays(int days);

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @byCategory.
  ///
  /// In en, this message translates to:
  /// **'By category'**
  String get byCategory;

  /// No description provided for @activeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String activeCount(int count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @notificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Local reminders'**
  String get notificationsLabel;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabledHint.
  ///
  /// In en, this message translates to:
  /// **'Reminders stay on your device only.'**
  String get notificationsDisabledHint;

  /// No description provided for @defaultCurrencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Default currency'**
  String get defaultCurrencyLabel;

  /// No description provided for @legalSection.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legalSection;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'Sarf helps you track recurring commitments locally. Your data never leaves your device.'**
  String get aboutBody;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Sarf is privacy-first. All commitment data is stored locally on your device in SQLite. We do not collect, transmit, or store your personal data on any server. Local notifications are scheduled on your device only. You can delete the app at any time to remove all data.'**
  String get privacyBody;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsTitle;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'Sarf is provided as-is for personal commitment tracking. It is not financial advice. You are responsible for the accuracy of amounts and dates you enter. The app works fully offline and does not connect to banks or third-party services.'**
  String get termsBody;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get invalidAmount;

  /// No description provided for @noReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get noReminder;

  /// No description provided for @reminderDaysOption.
  ///
  /// In en, this message translates to:
  /// **'{days} days before'**
  String reminderDaysOption(int days);

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Commitment reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Local reminders for upcoming commitments'**
  String get notificationChannelDescription;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming commitment'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'{name} — {amount} due on {date}'**
  String notificationBody(String name, String amount, String date);

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueDate(String date);

  /// No description provided for @commitmentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Commitment details'**
  String get commitmentDetailsTitle;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @mostExpensive.
  ///
  /// In en, this message translates to:
  /// **'Top expenses'**
  String get mostExpensive;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get viewReport;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Spending report'**
  String get reportsTitle;

  /// No description provided for @reportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly breakdown by category'**
  String get reportsSubtitle;

  /// No description provided for @reportPeriod.
  ///
  /// In en, this message translates to:
  /// **'Report period'**
  String get reportPeriod;

  /// No description provided for @reportTotal.
  ///
  /// In en, this message translates to:
  /// **'Total monthly'**
  String get reportTotal;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was denied. Enable it in system settings to receive reminders.'**
  String get notificationPermissionDenied;

  /// No description provided for @weeklyDigestTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly digest'**
  String get weeklyDigestTitle;

  /// No description provided for @weeklyDigestBody.
  ///
  /// In en, this message translates to:
  /// **'{count} payments due this week — {amount} total'**
  String weeklyDigestBody(int count, String amount);

  /// No description provided for @onboardingValueTitle.
  ///
  /// In en, this message translates to:
  /// **'Know what you need to pay this month.'**
  String get onboardingValueTitle;

  /// No description provided for @onboardingPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your device.'**
  String get onboardingPrivacyTitle;

  /// No description provided for @onboardingStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first commitment and start clearly.'**
  String get onboardingStartTitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @backupSection.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupSection;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackup;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackup;

  /// No description provided for @importBackupConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace all data?'**
  String get importBackupConfirmTitle;

  /// No description provided for @importBackupConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Importing will replace your current commitments, custom templates, settings, and notification schedules. Built-in templates are kept. This cannot be undone.'**
  String get importBackupConfirmBody;

  /// No description provided for @backupExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not export backup.'**
  String get backupExportFailed;

  /// No description provided for @backupImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup restored successfully.'**
  String get backupImportSuccess;

  /// No description provided for @backupImportInvalidApp.
  ///
  /// In en, this message translates to:
  /// **'This file is not a Sarf backup.'**
  String get backupImportInvalidApp;

  /// No description provided for @backupImportUnsupportedVersion.
  ///
  /// In en, this message translates to:
  /// **'This backup version is not supported.'**
  String get backupImportUnsupportedVersion;

  /// No description provided for @backupImportUnsupportedSchema.
  ///
  /// In en, this message translates to:
  /// **'This backup uses a newer schema than this app supports.'**
  String get backupImportUnsupportedSchema;

  /// No description provided for @backupImportInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'The selected file is not a valid backup.'**
  String get backupImportInvalidFormat;

  /// No description provided for @diagnosticsSection.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get diagnosticsSection;

  /// No description provided for @exportCrashLog.
  ///
  /// In en, this message translates to:
  /// **'Export crash log'**
  String get exportCrashLog;

  /// No description provided for @exportCrashLogHint.
  ///
  /// In en, this message translates to:
  /// **'Local error log only. Share manually if you need help.'**
  String get exportCrashLogHint;

  /// No description provided for @crashLogEmpty.
  ///
  /// In en, this message translates to:
  /// **'No crash log entries yet.'**
  String get crashLogEmpty;

  /// No description provided for @errorScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorScreenTitle;

  /// No description provided for @errorScreenBody.
  ///
  /// In en, this message translates to:
  /// **'The app hit an unexpected error. Restart the app to continue.'**
  String get errorScreenBody;

  /// No description provided for @suggestedDefaultHint.
  ///
  /// In en, this message translates to:
  /// **'Suggested default only'**
  String get suggestedDefaultHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
