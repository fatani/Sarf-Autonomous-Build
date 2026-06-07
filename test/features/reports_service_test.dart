import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/features/reports/domain/reports_service.dart';

void main() {
  test('reports service generates monthly category breakdown', () {
    final service = ReportsService();
    final now = DateTime(2026, 6, 1);
    final commitments = [
      CommitmentModel(
        id: '1',
        name: 'Netflix',
        amount: 49,
        currency: 'SAR',
        billingCycle: BillingCycle.monthly,
        category: CommitmentCategory.entertainment,
        nextDueDate: now,
        createdAt: now,
        updatedAt: now,
      ),
      CommitmentModel(
        id: '2',
        name: 'Electricity',
        amount: 250,
        currency: 'SAR',
        billingCycle: BillingCycle.monthly,
        category: CommitmentCategory.utilities,
        nextDueDate: now,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    final report = service.generate(
      commitments: commitments,
      defaultCurrency: 'SAR',
      now: now,
    );

    expect(report.activeCount, 2);
    expect(report.totalMonthly, 299);
    expect(report.byCategory[CommitmentCategory.entertainment], 49);
    expect(report.byCategory[CommitmentCategory.utilities], 250);
  });
}
