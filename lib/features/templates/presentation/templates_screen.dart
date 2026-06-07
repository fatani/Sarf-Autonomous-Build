import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/core/utils/template_icons.dart';
import 'package:sarf/features/commitments/presentation/commitment_form_sheet.dart';
import 'package:sarf/l10n/app_localizations.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final templatesAsync = ref.watch(templatesProvider);
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.templatesTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SearchBar(
              hintText: l10n.searchTemplates,
              leading: const Icon(Icons.search),
              onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
            ),
          ),
        ),
      ),
      body: templatesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(templatesProvider),
            child: Text(l10n.retry),
          ),
        ),
        data: (templates) {
          final filtered = templates.where((template) {
            if (_query.isEmpty) {
              return true;
            }
            return template.nameEn.toLowerCase().contains(_query) ||
                template.nameAr.contains(_query);
          }).toList();

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final template = filtered[index];
              return _TemplateTile(
                template: template,
                locale: locale,
                onUse: () => _useTemplate(context, template),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _useTemplate(BuildContext context, ServiceTemplateModel template) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CommitmentFormSheet(template: template),
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.locale,
    required this.onUse,
  });

  final ServiceTemplateModel template;
  final Locale locale;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(templateIcon(template.iconName)),
        ),
        title: Text(template.localizedName(locale.languageCode)),
        subtitle: Text(
          [
            Formatters.categoryLabel(template.category, l10n),
            Formatters.billingCycleLabel(template.defaultBillingCycle, l10n),
            if (template.defaultAmount != null)
              Formatters.money(template.defaultAmount!, 'SAR', locale),
          ].join(' · '),
        ),
        trailing: FilledButton.tonal(
          onPressed: onUse,
          child: Text(l10n.useTemplate),
        ),
      ),
    );
  }
}
