import 'package:sarf/core/domain/enums.dart';

class CommitmentModel {
  const CommitmentModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.billingCycle,
    required this.category,
    required this.nextDueDate,
    this.reminderDaysBefore,
    this.notes,
    this.templateId,
    this.isPaused = false,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.reportingCurrency,
    required this.paidReportingAmount,
    this.exchangeRate,
    this.paymentMethod = PaymentMethod.card,
    this.paymentSourceLabel,
  });

  final String id;
  final String name;

  /// Original subscription amount (same as [originalAmount]).
  final double amount;

  /// Original subscription currency (same as [originalCurrency]).
  final String currency;
  final BillingCycle billingCycle;
  final CommitmentCategory category;
  final DateTime nextDueDate;
  final int? reminderDaysBefore;
  final String? notes;
  final String? templateId;
  final bool isPaused;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String reportingCurrency;

  /// Actual amount charged in [reportingCurrency] (e.g. SAR deducted from card).
  final double paidReportingAmount;

  /// Computed effective rate (paid / original). Stored for convenience, not user input.
  final double? exchangeRate;
  final PaymentMethod paymentMethod;
  final String? paymentSourceLabel;

  double get originalAmount => amount;
  String get originalCurrency => currency;

  bool get isDeleted => deletedAt != null;
  bool get isActive => !isDeleted && !isPaused;
  bool get hasForeignCurrency => currency != reportingCurrency;

  double? get effectiveExchangeRate {
    if (!hasForeignCurrency || amount <= 0) {
      return null;
    }
    return exchangeRate ?? (paidReportingAmount / amount);
  }

  CommitmentModel copyWith({
    String? name,
    double? amount,
    String? currency,
    BillingCycle? billingCycle,
    CommitmentCategory? category,
    DateTime? nextDueDate,
    int? Function()? reminderDaysBefore,
    String? Function()? notes,
    String? Function()? templateId,
    bool? isPaused,
    DateTime? Function()? deletedAt,
    DateTime? updatedAt,
    String? reportingCurrency,
    double? paidReportingAmount,
    double? Function()? exchangeRate,
    PaymentMethod? paymentMethod,
    String? Function()? paymentSourceLabel,
  }) {
    return CommitmentModel(
      id: id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      category: category ?? this.category,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      reminderDaysBefore:
          reminderDaysBefore != null ? reminderDaysBefore() : this.reminderDaysBefore,
      notes: notes != null ? notes() : this.notes,
      templateId: templateId != null ? templateId() : this.templateId,
      isPaused: isPaused ?? this.isPaused,
      deletedAt: deletedAt != null ? deletedAt() : this.deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reportingCurrency: reportingCurrency ?? this.reportingCurrency,
      paidReportingAmount: paidReportingAmount ?? this.paidReportingAmount,
      exchangeRate: exchangeRate != null ? exchangeRate() : this.exchangeRate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentSourceLabel:
          paymentSourceLabel != null ? paymentSourceLabel() : this.paymentSourceLabel,
    );
  }
}

class ServiceTemplateModel {
  const ServiceTemplateModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.category,
    this.defaultAmount,
    required this.defaultBillingCycle,
    required this.iconName,
    this.isBuiltIn = true,
    this.defaultCurrency,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final CommitmentCategory category;
  final double? defaultAmount;
  final BillingCycle defaultBillingCycle;
  final String iconName;
  final bool isBuiltIn;
  final String? defaultCurrency;

  String localizedName(String languageCode) {
    return languageCode == 'ar' ? nameAr : nameEn;
  }
}

class AppSettingsModel {
  const AppSettingsModel({
    required this.localePreference,
    required this.notificationsEnabled,
    required this.defaultCurrency,
  });

  final AppLocalePreference localePreference;
  final bool notificationsEnabled;
  final String defaultCurrency;

  AppSettingsModel copyWith({
    AppLocalePreference? localePreference,
    bool? notificationsEnabled,
    String? defaultCurrency,
  }) {
    return AppSettingsModel(
      localePreference: localePreference ?? this.localePreference,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    );
  }
}

class InsightsSummary {
  const InsightsSummary({
    required this.monthlyTotal,
    required this.yearlyProjection,
    required this.activeCount,
    required this.upcoming,
    required this.mostExpensive,
    required this.byCategory,
    required this.currency,
  });

  final double monthlyTotal;
  final double yearlyProjection;
  final int activeCount;
  final List<CommitmentModel> upcoming;
  final List<CommitmentModel> mostExpensive;
  final Map<CommitmentCategory, double> byCategory;
  final String currency;
}

class SpendingReport {
  const SpendingReport({
    required this.periodLabel,
    required this.totalMonthly,
    required this.byCategory,
    required this.currency,
    required this.activeCount,
  });

  final String periodLabel;
  final double totalMonthly;
  final Map<CommitmentCategory, double> byCategory;
  final String currency;
  final int activeCount;
}
