import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/l10n/app_localizations.dart';

abstract final class Formatters {
  static String money(double amount, String currency, Locale locale) {
    final formatter = NumberFormat.currency(
      locale: locale.toLanguageTag(),
      symbol: currency,
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String commitmentPrimaryAmount(
    CommitmentModel commitment,
    Locale locale,
    AppLocalizations l10n,
  ) {
    if (!commitment.hasForeignCurrency) {
      return money(
        commitment.originalAmount,
        commitment.originalCurrency,
        locale,
      );
    }
    return money(commitment.originalAmount, commitment.originalCurrency, locale);
  }

  static String commitmentSecondaryAmount(
    CommitmentModel commitment,
    Locale locale,
    AppLocalizations l10n,
  ) {
    if (!commitment.hasForeignCurrency) {
      return '';
    }
    return '${l10n.amountApprox} ${money(commitment.estimatedReportingAmount, commitment.reportingCurrency, locale)}';
  }

  static String commitmentAmountLine(
    CommitmentModel commitment,
    Locale locale,
    AppLocalizations l10n,
  ) {
    if (!commitment.hasForeignCurrency) {
      return money(
        commitment.originalAmount,
        commitment.originalCurrency,
        locale,
      );
    }
    return '${money(commitment.originalAmount, commitment.originalCurrency, locale)} '
        '${l10n.amountApprox} '
        '${money(commitment.estimatedReportingAmount, commitment.reportingCurrency, locale)}';
  }

  static String? paymentSourceLine(CommitmentModel commitment, AppLocalizations l10n) {
    final parts = <String>[
      paymentMethodLabel(commitment.paymentMethod, l10n),
      if (commitment.paymentSourceLabel != null &&
          commitment.paymentSourceLabel!.trim().isNotEmpty)
        commitment.paymentSourceLabel!.trim(),
    ];
    if (parts.every((part) => part.isEmpty)) {
      return null;
    }
    return l10n.paidBy(parts.join(' · '));
  }

  static String paymentMethodLabel(PaymentMethod method, AppLocalizations l10n) {
    return switch (method) {
      PaymentMethod.card => l10n.paymentMethodCard,
      PaymentMethod.mada => l10n.paymentMethodMada,
      PaymentMethod.applePay => l10n.paymentMethodApplePay,
      PaymentMethod.bankTransfer => l10n.paymentMethodBankTransfer,
      PaymentMethod.cash => l10n.paymentMethodCash,
      PaymentMethod.other => l10n.paymentMethodOther,
    };
  }

  static String date(DateTime date, Locale locale) {
    return DateFormat.yMMMd(locale.toLanguageTag()).format(date);
  }

  static String billingCycleLabel(BillingCycle cycle, AppLocalizations l10n) {
    return switch (cycle) {
      BillingCycle.weekly => l10n.billingCycleWeekly,
      BillingCycle.monthly => l10n.billingCycleMonthly,
      BillingCycle.quarterly => l10n.billingCycleQuarterly,
      BillingCycle.yearly => l10n.billingCycleYearly,
      BillingCycle.oneTime => l10n.billingCycleOneTime,
    };
  }

  static String categoryLabel(CommitmentCategory category, AppLocalizations l10n) {
    return switch (category) {
      CommitmentCategory.entertainment => l10n.categoryEntertainment,
      CommitmentCategory.work => l10n.categoryWork,
      CommitmentCategory.education => l10n.categoryEducation,
      CommitmentCategory.telecom => l10n.categoryTelecom,
      CommitmentCategory.utilities => l10n.categoryUtilities,
      CommitmentCategory.storage => l10n.categoryStorage,
      CommitmentCategory.other => l10n.categoryOther,
    };
  }
}

abstract final class DateUtilsSarf {
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static int daysUntil(DateTime dueDate, DateTime from) {
    final due = startOfDay(dueDate);
    final today = startOfDay(from);
    return due.difference(today).inDays;
  }

  /// Next occurrence of [weekday] at [hour]:[minute] on or after [from].
  static DateTime nextWeekdayAtTime(
    DateTime from, {
    required int weekday,
    int hour = 9,
    int minute = 0,
  }) {
    var day = startOfDay(from);
    while (day.weekday != weekday) {
      day = day.add(const Duration(days: 1));
    }
    var scheduledAt = DateTime(day.year, day.month, day.day, hour, minute);
    if (!scheduledAt.isAfter(from)) {
      scheduledAt = scheduledAt.add(const Duration(days: 7));
    }
    return scheduledAt;
  }

  static DateTime advanceDueDate(DateTime dueDate, BillingCycle cycle) {
    return switch (cycle) {
      BillingCycle.weekly => dueDate.add(const Duration(days: 7)),
      BillingCycle.monthly => DateTime(dueDate.year, dueDate.month + 1, dueDate.day),
      BillingCycle.quarterly => DateTime(dueDate.year, dueDate.month + 3, dueDate.day),
      BillingCycle.yearly => DateTime(dueDate.year + 1, dueDate.month, dueDate.day),
      BillingCycle.oneTime => dueDate,
    };
  }

  static double monthlyEquivalent(double amount, BillingCycle cycle) {
    return switch (cycle) {
      BillingCycle.weekly => amount * 52 / 12,
      BillingCycle.monthly => amount,
      BillingCycle.quarterly => amount / 3,
      BillingCycle.yearly => amount / 12,
      BillingCycle.oneTime => 0,
    };
  }

  static double yearlyEquivalent(double amount, BillingCycle cycle) {
    return switch (cycle) {
      BillingCycle.weekly => amount * 52,
      BillingCycle.monthly => amount * 12,
      BillingCycle.quarterly => amount * 4,
      BillingCycle.yearly => amount,
      BillingCycle.oneTime => amount,
    };
  }
}
