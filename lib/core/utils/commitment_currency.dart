import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';

/// Local paid-amount helpers — no FX API, user enters actual charged amount.
abstract final class CommitmentCurrency {
  static bool needsConversion(String originalCurrency, String reportingCurrency) {
    return originalCurrency != reportingCurrency;
  }

  static double? computeEffectiveRate({
    required double originalAmount,
    required double paidReportingAmount,
    required String originalCurrency,
    required String reportingCurrency,
  }) {
    if (originalCurrency == reportingCurrency || originalAmount <= 0) {
      return 1.0;
    }
    return paidReportingAmount / originalAmount;
  }

  static CommitmentModel normalize({
    required CommitmentModel draft,
    required String reportingCurrency,
    double? paidReportingAmount,
    PaymentMethod? paymentMethod,
    String? Function()? paymentSourceLabel,
  }) {
    final sameCurrency = draft.currency == reportingCurrency;
    final paid = sameCurrency ? draft.amount : (paidReportingAmount ?? draft.paidReportingAmount);
    final rate = computeEffectiveRate(
      originalAmount: draft.amount,
      paidReportingAmount: paid,
      originalCurrency: draft.currency,
      reportingCurrency: reportingCurrency,
    );

    return CommitmentModel(
      id: draft.id,
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
      createdAt: draft.createdAt,
      updatedAt: draft.updatedAt,
      reportingCurrency: reportingCurrency,
      paidReportingAmount: paid,
      exchangeRate: rate,
      paymentMethod: paymentMethod ?? draft.paymentMethod,
      paymentSourceLabel:
          paymentSourceLabel != null ? paymentSourceLabel() : draft.paymentSourceLabel,
    );
  }

  static CommitmentModel fromLegacyJsonFields({
    required Map<String, dynamic> json,
    required String id,
    required String name,
    required double amount,
    required String currency,
    required BillingCycle billingCycle,
    required CommitmentCategory category,
    required DateTime nextDueDate,
    int? reminderDaysBefore,
    String? notes,
    String? templateId,
    bool isPaused = false,
    DateTime? deletedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    final reportingCurrency =
        json['reportingCurrency'] as String? ?? AppConstants.defaultCurrency;
    final sameCurrency = currency == reportingCurrency;
    final paidReportingAmount = (json['paidReportingAmount'] as num?)?.toDouble() ??
        (json['estimatedReportingAmount'] as num?)?.toDouble() ??
        amount;
    final exchangeRate = (json['exchangeRate'] as num?)?.toDouble() ??
        computeEffectiveRate(
          originalAmount: amount,
          paidReportingAmount: paidReportingAmount,
          originalCurrency: currency,
          reportingCurrency: reportingCurrency,
        );

    return CommitmentModel(
      id: id,
      name: name,
      amount: amount,
      currency: currency,
      billingCycle: billingCycle,
      category: category,
      nextDueDate: nextDueDate,
      reminderDaysBefore: reminderDaysBefore,
      notes: notes,
      templateId: templateId,
      isPaused: isPaused,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      reportingCurrency: reportingCurrency,
      paidReportingAmount: paidReportingAmount,
      exchangeRate: sameCurrency ? 1.0 : exchangeRate,
      paymentMethod: PaymentMethod.fromStorage(json['paymentMethod'] as String?),
      paymentSourceLabel: json['paymentSourceLabel'] as String?,
    );
  }
}
