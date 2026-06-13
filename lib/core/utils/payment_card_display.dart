import 'package:sarf/core/constants/card_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/l10n/app_localizations.dart';

abstract final class PaymentCardDisplay {
  static String? validateLast4(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final trimmed = value.trim();
    if (trimmed.length != 4 || int.tryParse(trimmed) == null) {
      return 'invalid';
    }
    return null;
  }

  static String bankLabel(String bankName, AppLocalizations l10n) {
    return switch (bankName) {
      'Al Rajhi' => l10n.bankAlRajhi,
      'SNB' => l10n.bankSnb,
      'D360' => l10n.bankD360,
      'Saudi Investment Bank' => l10n.bankSaudiInvestment,
      'STC Pay' => l10n.bankStcPay,
      'Barq' => l10n.bankBarq,
      'Alinma' => l10n.bankAlinma,
      'Riyad Bank' => l10n.bankRiyad,
      'SAB' => l10n.bankSab,
      CardConstants.otherBank => l10n.bankOther,
      _ => bankName,
    };
  }

  static String networkLabel(CardNetwork network, AppLocalizations l10n) {
    return switch (network) {
      CardNetwork.visa => l10n.cardNetworkVisa,
      CardNetwork.mastercard => l10n.cardNetworkMastercard,
      CardNetwork.mada => l10n.cardNetworkMada,
      CardNetwork.amex => l10n.cardNetworkAmex,
      CardNetwork.other => l10n.cardNetworkOther,
    };
  }

  static String tierLabel(CardTier? tier, AppLocalizations l10n) {
    if (tier == null) {
      return '';
    }
    return switch (tier) {
      CardTier.classic => l10n.cardTierClassic,
      CardTier.platinum => l10n.cardTierPlatinum,
      CardTier.signature => l10n.cardTierSignature,
      CardTier.infinite => l10n.cardTierInfinite,
      CardTier.world => l10n.cardTierWorld,
      CardTier.worldElite => l10n.cardTierWorldElite,
      CardTier.other => l10n.cardTierOther,
    };
  }

  static String preview(PaymentCardModel card, AppLocalizations l10n) {
    final parts = <String>[
      bankLabel(card.bankName, l10n),
      networkLabel(card.network, l10n),
      if (card.cardTier != null && card.cardTier != CardTier.other)
        tierLabel(card.cardTier, l10n),
      if (card.last4 != null && card.last4!.isNotEmpty) '•••• ${card.last4}',
    ].where((part) => part.isNotEmpty);

    return parts.join(' • ');
  }

  static String shortLabel(PaymentCardModel card, AppLocalizations l10n) {
    final bank = bankLabel(card.bankName, l10n);
    final network = networkLabel(card.network, l10n);
    if (card.last4 != null && card.last4!.isNotEmpty) {
      return '$bank $network •••• ${card.last4}';
    }
    return '$bank $network';
  }

  static String? commitmentPaymentLine({
    required CommitmentModel commitment,
    PaymentCardModel? card,
    required AppLocalizations l10n,
  }) {
    if (card != null) {
      return l10n.paidBy(shortLabel(card, l10n));
    }
    final label = commitment.paymentSourceLabel?.trim();
    if (label != null && label.isNotEmpty) {
      return l10n.paidBy(label);
    }
    return null;
  }
}
