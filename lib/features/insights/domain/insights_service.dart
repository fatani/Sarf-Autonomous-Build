import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';

class InsightsService {
  InsightsSummary calculate({
    required List<CommitmentModel> commitments,
    required List<PaymentCardModel> cards,
    required String defaultCurrency,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final active = commitments.where((c) => c.isActive).toList();

    var monthlyTotal = 0.0;
    var yearlyProjection = 0.0;
    final byCategory = <CommitmentCategory, double>{};

    for (final commitment in active) {
      final reportingAmount = commitment.paidReportingAmount;
      final monthly = DateUtilsSarf.monthlyEquivalent(reportingAmount, commitment.billingCycle);
      final yearly = DateUtilsSarf.yearlyEquivalent(reportingAmount, commitment.billingCycle);
      monthlyTotal += monthly;
      yearlyProjection += yearly;
      byCategory.update(
        commitment.category,
        (value) => value + monthly,
        ifAbsent: () => monthly,
      );
    }

    final upcoming = active.toList()
      ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
    final filteredUpcoming = upcoming
        .where((c) => DateUtilsSarf.daysUntil(c.nextDueDate, reference) <= 7)
        .take(10)
        .toList();

    final mostExpensive = active.toList()
      ..sort((a, b) {
        final monthlyA =
            DateUtilsSarf.monthlyEquivalent(a.paidReportingAmount, a.billingCycle);
        final monthlyB =
            DateUtilsSarf.monthlyEquivalent(b.paidReportingAmount, b.billingCycle);
        return monthlyB.compareTo(monthlyA);
      });

    return InsightsSummary(
      monthlyTotal: monthlyTotal,
      yearlyProjection: yearlyProjection,
      activeCount: active.length,
      upcoming: filteredUpcoming,
      mostExpensive: mostExpensive.take(3).toList(),
      byCategory: byCategory,
      byCard: _spendingByCard(active),
      currency: defaultCurrency,
    );
  }

  List<CardSpendingSummary> _spendingByCard(List<CommitmentModel> active) {
    final totalsByCard = <String, double>{};
    final countsByCard = <String, int>{};
    final totalsByFallback = <String, double>{};
    final countsByFallback = <String, int>{};

    for (final commitment in active) {
      final monthly =
          DateUtilsSarf.monthlyEquivalent(commitment.paidReportingAmount, commitment.billingCycle);
      if (commitment.cardId != null) {
        totalsByCard.update(
          commitment.cardId!,
          (value) => value + monthly,
          ifAbsent: () => monthly,
        );
        countsByCard.update(commitment.cardId!, (value) => value + 1, ifAbsent: () => 1);
      } else if (commitment.paymentSourceLabel != null &&
          commitment.paymentSourceLabel!.trim().isNotEmpty) {
        final label = commitment.paymentSourceLabel!.trim();
        totalsByFallback.update(label, (value) => value + monthly, ifAbsent: () => monthly);
        countsByFallback.update(label, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    final summaries = <CardSpendingSummary>[
      ...totalsByCard.entries.map(
        (entry) => CardSpendingSummary(
          cardId: entry.key,
          monthlyTotal: entry.value,
          commitmentCount: countsByCard[entry.key] ?? 0,
        ),
      ),
      ...totalsByFallback.entries.map(
        (entry) => CardSpendingSummary(
          fallbackLabel: entry.key,
          monthlyTotal: entry.value,
          commitmentCount: countsByFallback[entry.key] ?? 0,
        ),
      ),
    ]..sort((a, b) => b.monthlyTotal.compareTo(a.monthlyTotal));

    return summaries;
  }
}
