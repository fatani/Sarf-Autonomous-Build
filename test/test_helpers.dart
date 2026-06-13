import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';

CommitmentModel testCommitment({
  String id = 'c1',
  String name = 'Test',
  double amount = 100,
  String currency = 'SAR',
  BillingCycle billingCycle = BillingCycle.monthly,
  CommitmentCategory category = CommitmentCategory.other,
  DateTime? nextDueDate,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? reportingCurrency,
  double? paidReportingAmount,
  double? exchangeRate,
  PaymentMethod paymentMethod = PaymentMethod.card,
  String? paymentSourceLabel,
  bool isPaused = false,
  DateTime? deletedAt,
}) {
  final now = createdAt ?? DateTime.utc(2026, 1, 1);
  final due = nextDueDate ?? DateTime.utc(2026, 1, 15);
  final reporting = reportingCurrency ?? currency;
  final paid = paidReportingAmount ?? amount;

  return CommitmentModel(
    id: id,
    name: name,
    amount: amount,
    currency: currency,
    billingCycle: billingCycle,
    category: category,
    nextDueDate: due,
    createdAt: now,
    updatedAt: updatedAt ?? now,
    reportingCurrency: reporting,
    paidReportingAmount: paid,
    exchangeRate: exchangeRate ??
        (currency == reporting || amount <= 0 ? 1.0 : paid / amount),
    paymentMethod: paymentMethod,
    paymentSourceLabel: paymentSourceLabel,
    isPaused: isPaused,
    deletedAt: deletedAt,
  );
}
