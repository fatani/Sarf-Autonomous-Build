import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/features/reports/domain/reports_service.dart';
import '../test_helpers.dart';

void main() {
  test('reports service generates monthly category breakdown', () {
    final service = ReportsService();
    final now = DateTime(2026, 6, 1);
    final commitments = [
      testCommitment(
        id: '1',
        name: 'Netflix',
        amount: 49,
        category: CommitmentCategory.entertainment,
        nextDueDate: now,
        createdAt: now,
      ),
      testCommitment(
        id: '2',
        name: 'Electricity',
        amount: 250,
        category: CommitmentCategory.utilities,
        nextDueDate: now,
        createdAt: now,
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

  test('reports service uses paidReportingAmount', () {
    final service = ReportsService();
    final now = DateTime(2026, 6, 1);
    final commitments = [
      testCommitment(
        id: '1',
        name: 'ChatGPT',
        amount: 20,
        currency: 'USD',
        reportingCurrency: 'SAR',
        paidReportingAmount: 78.42,
        nextDueDate: now,
        createdAt: now,
      ),
    ];

    final report = service.generate(
      commitments: commitments,
      defaultCurrency: 'SAR',
      now: now,
    );

    expect(report.totalMonthly, 78.42);
  });
}
