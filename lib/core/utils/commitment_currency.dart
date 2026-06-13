import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';

/// Local currency conversion helpers — no FX API, manual rate only.
abstract final class CommitmentCurrency {
  static bool needsConversion(String originalCurrency, String reportingCurrency) {
    return originalCurrency != reportingCurrency;
  }

  static double computeEstimatedReportingAmount({
    required double originalAmount,
    required String originalCurrency,
    required String reportingCurrency,
    double? exchangeRate,
  }) {
    if (originalCurrency == reportingCurrency) {
      return originalAmount;
    }
    return originalAmount * (exchangeRate ?? 1.0);
  }

  static CommitmentModel normalize({
    required CommitmentModel draft,
    required String reportingCurrency,
    double? exchangeRate,
    PaymentMethod? paymentMethod,
    String? Function()? paymentSourceLabel,
  }) {
    final sameCurrency = draft.currency == reportingCurrency;
    final rate = sameCurrency ? 1.0 : exchangeRate;
    final estimated = computeEstimatedReportingAmount(
      originalAmount: draft.amount,
      originalCurrency: draft.currency,
      reportingCurrency: reportingCurrency,
      exchangeRate: rate,
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
      estimatedReportingAmount: estimated,
      exchangeRate: sameCurrency ? 1.0 : rate,
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
    final exchangeRate = (json['exchangeRate'] as num?)?.toDouble();
    final sameCurrency = currency == reportingCurrency;
    final estimatedReportingAmount = (json['estimatedReportingAmount'] as num?)?.toDouble() ??
        computeEstimatedReportingAmount(
          originalAmount: amount,
          originalCurrency: currency,
          reportingCurrency: reportingCurrency,
          exchangeRate: sameCurrency ? 1.0 : exchangeRate,
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
      estimatedReportingAmount: estimatedReportingAmount,
      exchangeRate: sameCurrency ? 1.0 : exchangeRate,
      paymentMethod: PaymentMethod.fromStorage(json['paymentMethod'] as String?),
      paymentSourceLabel: json['paymentSourceLabel'] as String?,
    );
  }
}
