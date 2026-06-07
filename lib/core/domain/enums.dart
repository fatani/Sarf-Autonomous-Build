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
