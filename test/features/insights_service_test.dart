import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/core/utils/notification_ids.dart';
import 'package:sarf/features/insights/domain/insights_service.dart';
import '../test_helpers.dart';

void main() {
  group('DateUtilsSarf', () {
    test('monthlyEquivalent converts yearly amount', () {
      expect(DateUtilsSarf.monthlyEquivalent(1200, BillingCycle.yearly), 100);
    });

    test('daysUntil calculates difference in days', () {
      final due = DateTime(2026, 6, 10);
      final from = DateTime(2026, 6, 7);
      expect(DateUtilsSarf.daysUntil(due, from), 3);
    });

    test('nextWeekdayAtTime schedules same day when time is still ahead', () {
      final from = DateTime(2026, 6, 8, 8, 30);
      final scheduled = DateUtilsSarf.nextWeekdayAtTime(
        from,
        weekday: DateTime.monday,
      );
      expect(scheduled, DateTime(2026, 6, 8, 9, 0));
    });

    test('nextWeekdayAtTime rolls to next week after slot has passed', () {
      final from = DateTime(2026, 6, 8, 10, 0);
      final scheduled = DateUtilsSarf.nextWeekdayAtTime(
        from,
        weekday: DateTime.monday,
      );
      expect(scheduled, DateTime(2026, 6, 15, 9, 0));
    });

    test('nextWeekdayAtTime finds upcoming weekday from mid-week', () {
      final from = DateTime(2026, 6, 10, 14, 0);
      final scheduled = DateUtilsSarf.nextWeekdayAtTime(
        from,
        weekday: DateTime.monday,
      );
      expect(scheduled, DateTime(2026, 6, 15, 9, 0));
    });
  });

  group('NotificationIds', () {
    test('commitment IDs are stable and distinct for different commitments', () {
      final a = NotificationIds.commitmentReminder('commitment-a');
      final b = NotificationIds.commitmentReminder('commitment-b');
      expect(a, NotificationIds.commitmentReminder('commitment-a'));
      expect(a, isNot(equals(b)));
    });
  });

  group('InsightsService', () {
    test('calculates monthly and yearly totals for active commitments', () {
      final service = InsightsService();
      final now = DateTime(2026, 6, 1);
      final commitments = [
        testCommitment(
          id: '1',
          name: 'Rent',
          amount: 3000,
          currency: 'SAR',
          category: CommitmentCategory.other,
          nextDueDate: DateTime(2026, 6, 5),
          createdAt: now,
        ),
        testCommitment(
          id: '2',
          name: 'Insurance',
          amount: 1200,
          currency: 'SAR',
          billingCycle: BillingCycle.yearly,
          category: CommitmentCategory.utilities,
          nextDueDate: DateTime(2026, 12, 1),
          createdAt: now,
        ),
      ];

      final summary = service.calculate(
        commitments: commitments,
        defaultCurrency: 'SAR',
        now: now,
      );

      expect(summary.activeCount, 2);
      expect(summary.monthlyTotal, 3100);
      expect(summary.yearlyProjection, 37200);
      expect(summary.byCategory[CommitmentCategory.other], 3000);
      expect(summary.mostExpensive, hasLength(2));
    });

    test('uses paidReportingAmount for foreign currency totals', () {
      final service = InsightsService();
      final now = DateTime(2026, 6, 1);
      final commitments = [
        testCommitment(
          id: '1',
          name: 'Local',
          amount: 100,
          currency: 'SAR',
          nextDueDate: now,
          createdAt: now,
        ),
        testCommitment(
          id: '2',
          name: 'ChatGPT',
          amount: 20,
          currency: 'USD',
          reportingCurrency: 'SAR',
          paidReportingAmount: 78.42,
          nextDueDate: now,
          createdAt: now,
        ),
      ];

      final summary = service.calculate(
        commitments: commitments,
        defaultCurrency: 'SAR',
        now: now,
      );

      expect(summary.monthlyTotal, closeTo(178.42, 0.001));
      expect(summary.mostExpensive.first.name, 'Local');
      expect(summary.mostExpensive[1].name, 'ChatGPT');
    });

    test('top 3 most expensive uses paidReportingAmount monthly equivalent', () {
      final service = InsightsService();
      final now = DateTime(2026, 6, 1);
      final commitments = [
        testCommitment(
          id: '1',
          name: 'Small USD',
          amount: 10,
          currency: 'USD',
          reportingCurrency: 'SAR',
          paidReportingAmount: 37.5,
          nextDueDate: now,
          createdAt: now,
        ),
        testCommitment(
          id: '2',
          name: 'Large SAR',
          amount: 200,
          currency: 'SAR',
          nextDueDate: now,
          createdAt: now,
        ),
      ];

      final summary = service.calculate(
        commitments: commitments,
        defaultCurrency: 'SAR',
        now: now,
      );

      expect(summary.mostExpensive.first.name, 'Large SAR');
    });

    test('upcoming window is 7 days', () {
      final service = InsightsService();
      final now = DateTime(2026, 6, 1);
      final commitments = [
        testCommitment(
          id: '1',
          name: 'Soon',
          nextDueDate: DateTime(2026, 6, 5),
          createdAt: now,
        ),
        testCommitment(
          id: '2',
          name: 'Later',
          nextDueDate: DateTime(2026, 6, 20),
          createdAt: now,
        ),
      ];

      final summary = service.calculate(commitments: commitments, defaultCurrency: 'SAR', now: now);
      expect(summary.upcoming, hasLength(1));
      expect(summary.upcoming.single.name, 'Soon');
    });

    test('ignores paused and deleted commitments', () {
      final service = InsightsService();
      final now = DateTime(2026, 6, 1);
      final commitments = [
        testCommitment(id: '1', name: 'Active', amount: 100, nextDueDate: now, createdAt: now),
        testCommitment(
          id: '2',
          name: 'Paused',
          amount: 200,
          nextDueDate: now,
          isPaused: true,
          createdAt: now,
        ),
        testCommitment(
          id: '3',
          name: 'Deleted',
          amount: 300,
          nextDueDate: now,
          deletedAt: now,
          createdAt: now,
        ),
      ];

      final summary = service.calculate(commitments: commitments, defaultCurrency: 'SAR', now: now);
      expect(summary.activeCount, 1);
      expect(summary.monthlyTotal, 100);
    });
  });
}
