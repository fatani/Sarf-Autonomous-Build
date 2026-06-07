/// Stable, collision-resistant notification IDs for local scheduling.
abstract final class NotificationIds {
  static const int commitmentBase = 10000;
  static const int commitmentRange = 800000;
  static const int trialReminder = 900001;
  static const int weeklyDigest = 900002;

  static int commitmentReminder(String commitmentId) {
    return commitmentBase + _fnv1a32('commitment:$commitmentId') % commitmentRange;
  }

  static int _fnv1a32(String input) {
    var hash = 0x811c9dc5;
    for (final unit in input.codeUnits) {
      hash = (hash ^ unit) * 0x01000193;
      hash = hash & 0x7fffffff;
    }
    return hash;
  }
}
