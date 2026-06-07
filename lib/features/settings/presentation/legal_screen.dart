import 'package:flutter/material.dart';
import 'package:sarf/l10n/app_localizations.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen._({required this.title, required this.body});

  const LegalScreen.privacy()
      : this._(title: 'privacy', body: 'privacy');

  const LegalScreen.terms()
      : this._(title: 'terms', body: 'terms');

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isPrivacy = body == 'privacy';

    return Scaffold(
      appBar: AppBar(title: Text(isPrivacy ? l10n.privacyTitle : l10n.termsTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Text(isPrivacy ? l10n.privacyBody : l10n.termsBody),
      ),
    );
  }
}
