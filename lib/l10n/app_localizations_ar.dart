// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'صرف';

  @override
  String get navCommitments => 'الالتزامات';

  @override
  String get navTemplates => 'القوالب';

  @override
  String get navInsights => 'الرؤى';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get commitmentsTitle => 'الالتزامات';

  @override
  String get commitmentsEmptyTitle => 'لا توجد التزامات بعد';

  @override
  String get commitmentsEmptyBody =>
      'أضف فواتيرك واشتراكاتك المتكررة لتتبّع ما عليك دفعه.';

  @override
  String get addCommitment => 'إضافة التزام';

  @override
  String get editCommitment => 'تعديل الالتزام';

  @override
  String get deleteCommitment => 'حذف الالتزام';

  @override
  String get deleteCommitmentConfirm =>
      'سيُخفى هذا الالتزام من قائمتك. يمكنك استعادته لاحقًا من المؤرشف.';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get currencyLabel => 'العملة';

  @override
  String get billingCycleLabel => 'دورة الفوترة';

  @override
  String get nextDueDateLabel => 'تاريخ الاستحقاق التالي';

  @override
  String get reminderDaysLabel => 'التذكير (أيام قبل)';

  @override
  String get notesLabel => 'ملاحظات';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get restore => 'استعادة';

  @override
  String get archived => 'مؤرشف';

  @override
  String get showArchived => 'عرض المؤرشف';

  @override
  String get hideArchived => 'إخفاء المؤرشف';

  @override
  String get paused => 'متوقف';

  @override
  String get active => 'نشط';

  @override
  String get pauseCommitment => 'إيقاف مؤقت';

  @override
  String get resumeCommitment => 'استئناف';

  @override
  String get billingCycleMonthly => 'شهري';

  @override
  String get billingCycleQuarterly => 'ربع سنوي';

  @override
  String get billingCycleYearly => 'سنوي';

  @override
  String get billingCycleWeekly => 'أسبوعي';

  @override
  String get billingCycleOneTime => 'مرة واحدة';

  @override
  String get categoryLabel => 'الفئة';

  @override
  String get categoryEntertainment => 'ترفيه';

  @override
  String get categoryWork => 'عمل';

  @override
  String get categoryEducation => 'تعليم';

  @override
  String get categoryTelecom => 'اتصالات';

  @override
  String get categoryUtilities => 'مرافق';

  @override
  String get categoryStorage => 'تخزين';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get templatesTitle => 'قوالب الخدمات';

  @override
  String get templatesSubtitle => 'ابدأ بسرعة من خدمات شائعة';

  @override
  String get useTemplate => 'استخدام القالب';

  @override
  String get searchTemplates => 'بحث في القوالب';

  @override
  String get insightsTitle => 'الرؤى';

  @override
  String get monthlyTotal => 'الإجمالي الشهري';

  @override
  String get yearlyProjection => 'التقدير السنوي';

  @override
  String get upcomingDues => 'الاستحقاقات القادمة';

  @override
  String get dueToday => 'مستحق اليوم';

  @override
  String dueInDays(int days) {
    return 'مستحق خلال $days أيام';
  }

  @override
  String get overdue => 'متأخر';

  @override
  String get byCategory => 'حسب الفئة';

  @override
  String activeCount(int count) {
    return '$count نشط';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get notificationsLabel => 'تذكيرات محلية';

  @override
  String get notificationsEnabled => 'تفعيل التذكيرات';

  @override
  String get notificationsDisabledHint => 'التذكيرات تبقى على جهازك فقط.';

  @override
  String get defaultCurrencyLabel => 'العملة الافتراضية';

  @override
  String get legalSection => 'قانوني';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfUse => 'شروط الاستخدام';

  @override
  String get aboutSection => 'حول';

  @override
  String get aboutBody =>
      'صرف يساعدك على تتبع الالتزامات المتكررة محليًا. بياناتك لا تغادر جهازك.';

  @override
  String get versionLabel => 'الإصدار';

  @override
  String get privacyTitle => 'سياسة الخصوصية';

  @override
  String get privacyBody =>
      'صرف يضع الخصوصية أولًا. تُخزَّن جميع بيانات الالتزامات محليًا على جهازك في SQLite. لا نجمع أو ننقل أو نخزّن بياناتك الشخصية على أي خادم. تُجدول الإشعارات المحلية على جهازك فقط. يمكنك حذف التطبيق في أي وقت لإزالة جميع البيانات.';

  @override
  String get termsTitle => 'شروط الاستخدام';

  @override
  String get termsBody =>
      'يُقدَّم صرف كما هو لتتبع الالتزامات الشخصية. ليس نصيحة مالية. أنت مسؤول عن دقة المبالغ والتواريخ التي تدخلها. يعمل التطبيق بالكامل دون اتصال ولا يتصل بالبنوك أو خدمات طرف ثالث.';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidAmount => 'أدخل مبلغًا صالحًا';

  @override
  String get noReminder => 'بدون تذكير';

  @override
  String reminderDaysOption(int days) {
    return 'قبل $days أيام';
  }

  @override
  String get notificationChannelName => 'تذكيرات الالتزامات';

  @override
  String get notificationChannelDescription =>
      'تذكيرات محلية للالتزامات القادمة';

  @override
  String get notificationTitle => 'التزام قادم';

  @override
  String notificationBody(String name, String amount, String date) {
    return '$name — $amount مستحق في $date';
  }

  @override
  String get errorGeneric => 'حدث خطأ ما';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String dueDate(String date) {
    return 'مستحق $date';
  }

  @override
  String get commitmentDetailsTitle => 'تفاصيل الالتزام';

  @override
  String get edit => 'تعديل';

  @override
  String get mostExpensive => 'أعلى المصروفات';

  @override
  String get viewReport => 'عرض التقرير';

  @override
  String get reportsTitle => 'تقرير الإنفاق';

  @override
  String get reportsSubtitle => 'تفصيل شهري حسب الفئة';

  @override
  String get reportPeriod => 'فترة التقرير';

  @override
  String get reportTotal => 'الإجمالي الشهري';

  @override
  String get notificationPermissionDenied =>
      'تم رفض إذن الإشعارات. فعّله من إعدادات النظام لتلقي التذكيرات.';

  @override
  String get weeklyDigestTitle => 'ملخص أسبوعي';

  @override
  String weeklyDigestBody(int count, String amount) {
    return '$count دفعات مستحقة هذا الأسبوع — $amount إجمالي';
  }

  @override
  String get onboardingValueTitle => 'اعرف ما عليك دفعه هذا الشهر.';

  @override
  String get onboardingPrivacyTitle => 'بياناتك لا تغادر هاتفك.';

  @override
  String get onboardingStartTitle => 'أضف أول التزام وابدأ بوضوح.';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get backupSection => 'النسخ الاحتياطي';

  @override
  String get exportBackup => 'تصدير نسخة احتياطية';

  @override
  String get importBackup => 'استيراد نسخة احتياطية';

  @override
  String get importBackupConfirmTitle => 'استبدال كل البيانات؟';

  @override
  String get importBackupConfirmBody =>
      'الاستيراد سيستبدل التزاماتك الحالية والقوالب المخصصة والإعدادات وجداول الإشعارات. القوالب المدمجة تبقى كما هي. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get backupExportFailed => 'تعذّر تصدير النسخة الاحتياطية.';

  @override
  String get backupImportSuccess => 'تم استعادة النسخة الاحتياطية بنجاح.';

  @override
  String get backupImportInvalidApp => 'هذا الملف ليس نسخة احتياطية من صرف.';

  @override
  String get backupImportUnsupportedVersion =>
      'إصدار النسخة الاحتياطية غير مدعوم.';

  @override
  String get backupImportUnsupportedSchema =>
      'هذه النسخة تستخدم مخططًا أحدث مما يدعمه التطبيق.';

  @override
  String get backupImportInvalidFormat =>
      'الملف المحدد ليس نسخة احتياطية صالحة.';

  @override
  String get diagnosticsSection => 'التشخيص';

  @override
  String get exportCrashLog => 'تصدير سجل الأعطال';

  @override
  String get exportCrashLogHint =>
      'سجل أخطاء محلي فقط. شاركه يدويًا إذا احتجت مساعدة.';

  @override
  String get crashLogEmpty => 'لا توجد أعطال مسجّلة بعد.';

  @override
  String get errorScreenTitle => 'حدث خطأ ما';

  @override
  String get errorScreenBody =>
      'واجه التطبيق خطأً غير متوقع. أعد تشغيل التطبيق للمتابعة.';

  @override
  String get suggestedDefaultHint => 'قيمة افتراضية مقترحة فقط';

  @override
  String get amountSectionTitle => 'المبلغ';

  @override
  String get paymentSectionTitle => 'الدفع';

  @override
  String get exchangeRateLabel => 'سعر التحويل';

  @override
  String exchangeRateHint(String originalCurrency, String reportingCurrency) {
    return '1 $originalCurrency = ? $reportingCurrency';
  }

  @override
  String get invalidExchangeRate => 'أدخل سعر تحويل صالحًا';

  @override
  String estimatedReportingAmount(String amount) {
    return 'المقدّر: $amount';
  }

  @override
  String get estimatedReportingAmountLabel => 'المبلغ المقدّر بعملة التقرير';

  @override
  String get paymentMethodLabel => 'طريقة الدفع';

  @override
  String get paymentMethodCard => 'بطاقة';

  @override
  String get paymentMethodMada => 'مدى';

  @override
  String get paymentMethodApplePay => 'Apple Pay';

  @override
  String get paymentMethodBankTransfer => 'تحويل بنكي';

  @override
  String get paymentMethodCash => 'نقد';

  @override
  String get paymentMethodOther => 'أخرى';

  @override
  String get paymentSourceLabel => 'مصدر الدفع';

  @override
  String get paymentSourceHint => 'اختياري — مثال: بطاقة الراجحي Visa';

  @override
  String get amountApprox => '≈';

  @override
  String paidBy(String source) {
    return 'الدفع: $source';
  }
}
