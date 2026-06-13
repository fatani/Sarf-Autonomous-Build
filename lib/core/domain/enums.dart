enum BillingCycle {
  weekly,
  monthly,
  quarterly,
  yearly,
  oneTime;

  String get storageKey => name;

  static BillingCycle fromStorage(String value) {
    return BillingCycle.values.firstWhere(
      (cycle) => cycle.name == value,
      orElse: () => BillingCycle.monthly,
    );
  }
}

enum CommitmentCategory {
  entertainment,
  work,
  education,
  telecom,
  utilities,
  storage,
  other;

  String get storageKey => name;

  static CommitmentCategory fromStorage(String value) {
    final normalized = switch (value) {
      'subscription' => 'entertainment',
      'utility' => 'utilities',
      'rent' || 'finance' => 'other',
      _ => value,
    };
    return CommitmentCategory.values.firstWhere(
      (category) => category.name == normalized,
      orElse: () => CommitmentCategory.other,
    );
  }
}

enum PaymentMethod {
  card,
  mada,
  applePay,
  bankTransfer,
  cash,
  other;

  String get storageKey => name;

  static PaymentMethod fromStorage(String? value) {
    if (value == null) {
      return PaymentMethod.card;
    }
    return PaymentMethod.values.firstWhere(
      (method) => method.name == value,
      orElse: () => PaymentMethod.other,
    );
  }
}

enum CardNetwork {
  visa,
  mastercard,
  mada,
  amex,
  other;

  String get storageKey => name;

  static CardNetwork fromStorage(String? value) {
    if (value == null) {
      return CardNetwork.other;
    }
    return CardNetwork.values.firstWhere(
      (network) => network.name == value,
      orElse: () => CardNetwork.other,
    );
  }
}

enum CardTier {
  classic,
  platinum,
  signature,
  infinite,
  world,
  worldElite,
  other;

  String get storageKey => name;

  static CardTier? fromStorage(String? value) {
    if (value == null) {
      return null;
    }
    return CardTier.values.firstWhere(
      (tier) => tier.name == value,
      orElse: () => CardTier.other,
    );
  }
}

enum AppLocalePreference {
  system,
  en,
  ar;

  String get storageKey => name;

  static AppLocalePreference fromStorage(String? value) {
    if (value == null) {
      return AppLocalePreference.system;
    }
    return AppLocalePreference.values.firstWhere(
      (pref) => pref.name == value,
      orElse: () => AppLocalePreference.system,
    );
  }
}
