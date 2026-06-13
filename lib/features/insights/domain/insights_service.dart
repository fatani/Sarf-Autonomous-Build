import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';

class InsightsService {
  InsightsSummary calculate({
    required List<CommitmentModel> commitments,
    required String defaultCurrency,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final active = commitments.where((c) => c.isActive).toList();

    var monthlyTotal = 0.0;
    var yearlyProjection = 0.0;
    final byCategory = <CommitmentCategory, double>{};

    for (final commitment in active) {
      final reportingAmount = commitment.estimatedReportingAmount;
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
            DateUtilsSarf.monthlyEquivalent(a.estimatedReportingAmount, a.billingCycle);
        final monthlyB =
            DateUtilsSarf.monthlyEquivalent(b.estimatedReportingAmount, b.billingCycle);
        return monthlyB.compareTo(monthlyA);
      });
    final topExpensive = mostExpensive.take(3).toList();

    return InsightsSummary(
      monthlyTotal: monthlyTotal,
      yearlyProjection: yearlyProjection,
      activeCount: active.length,
      upcoming: filteredUpcoming,
      mostExpensive: topExpensive,
      byCategory: byCategory,
      currency: defaultCurrency,
    );
  }
}
