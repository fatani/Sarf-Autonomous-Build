import 'package:intl/intl.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';

class ReportsService {
  SpendingReport generate({
    required List<CommitmentModel> commitments,
    required String defaultCurrency,
    DateTime? now,
  }) {
    final reference = now ?? DateTime.now();
    final active = commitments.where((c) => c.isActive).toList();
    final byCategory = <CommitmentCategory, double>{};

    var totalMonthly = 0.0;
    for (final commitment in active) {
      final monthly = DateUtilsSarf.monthlyEquivalent(commitment.amount, commitment.billingCycle);
      totalMonthly += monthly;
      byCategory.update(
        commitment.category,
        (value) => value + monthly,
        ifAbsent: () => monthly,
      );
    }

    final periodLabel = DateFormat.yMMMM().format(reference);

    return SpendingReport(
      periodLabel: periodLabel,
      totalMonthly: totalMonthly,
      byCategory: byCategory,
      currency: defaultCurrency,
      activeCount: active.length,
    );
  }
}
