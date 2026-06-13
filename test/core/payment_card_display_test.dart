import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/utils/payment_card_display.dart';
import 'package:sarf/l10n/app_localizations.dart';

import '../test_helpers.dart';

void main() {
  group('PaymentCardDisplay.validateLast4', () {
    test('allows empty optional last4', () {
      expect(PaymentCardDisplay.validateLast4(null), isNull);
      expect(PaymentCardDisplay.validateLast4(''), isNull);
      expect(PaymentCardDisplay.validateLast4('   '), isNull);
    });

    test('requires exactly 4 digits when present', () {
      expect(PaymentCardDisplay.validateLast4('123'), isNotNull);
      expect(PaymentCardDisplay.validateLast4('12345'), isNotNull);
      expect(PaymentCardDisplay.validateLast4('12a4'), isNotNull);
      expect(PaymentCardDisplay.validateLast4('1234'), isNull);
    });
  });

  group('PaymentCardDisplay preview', () {
    test('updates preview with bank network tier and last4', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final card = testPaymentCard(last4: '1331');

      final preview = PaymentCardDisplay.preview(card, l10n);
      expect(preview, contains('Al Rajhi'));
      expect(preview, contains('Visa'));
      expect(preview, contains('Infinite'));
      expect(preview, contains('1331'));
    });
  });

  group('PaymentCardDisplay commitmentPaymentLine', () {
    test('prefers linked card over legacy label', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final card = testPaymentCard(last4: '4774');
      final commitment = testCommitment(
        cardId: 'card-1',
        paymentSourceLabel: 'Legacy label',
      );

      final line = PaymentCardDisplay.commitmentPaymentLine(
        commitment: commitment,
        card: card,
        l10n: l10n,
      );

      expect(line, contains('4774'));
      expect(line, isNot(contains('Legacy label')));
    });

    test('falls back to paymentSourceLabel when no card', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final commitment = testCommitment(paymentSourceLabel: 'Apple Pay');

      final line = PaymentCardDisplay.commitmentPaymentLine(
        commitment: commitment,
        l10n: l10n,
      );

      expect(line, contains('Apple Pay'));
    });

    test('returns null when no payment info', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final commitment = testCommitment(paymentSourceLabel: null);

      final line = PaymentCardDisplay.commitmentPaymentLine(
        commitment: commitment,
        l10n: l10n,
      );

      expect(line, isNull);
    });
  });
}
