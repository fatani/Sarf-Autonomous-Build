import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/constants/card_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/payment_card_display.dart';
import 'package:sarf/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({this.existing, super.key});

  final PaymentCardModel? existing;

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _last4Controller = TextEditingController();
  final _customBankController = TextEditingController();
  final _uuid = const Uuid();

  late CardNetwork _network;
  late String _bank;
  CardTier? _tier;
  var _useCustomBank = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _network = existing?.network ?? CardNetwork.visa;
    _bank = existing?.bankName ?? CardConstants.suggestedBanks.first;
    _tier = existing?.cardTier;
    _last4Controller.text = existing?.last4 ?? '';
    _useCustomBank = existing != null &&
        !CardConstants.suggestedBanks.contains(existing.bankName) &&
        existing.bankName != CardConstants.otherBank;
    if (_useCustomBank) {
      _customBankController.text = existing!.bankName;
      _bank = CardConstants.otherBank;
    }
  }

  @override
  void dispose() {
    _last4Controller.dispose();
    _customBankController.dispose();
    super.dispose();
  }

  PaymentCardModel get _previewCard {
    return PaymentCardModel(
      id: widget.existing?.id ?? 'preview',
      network: _network,
      bankName: _resolvedBankName(),
      cardTier: _tier,
      last4: _last4Controller.text.trim().isEmpty ? null : _last4Controller.text.trim(),
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );
  }

  String _resolvedBankName() {
    if (_bank == CardConstants.otherBank) {
      return _customBankController.text.trim().isEmpty
          ? CardConstants.otherBank
          : _customBankController.text.trim();
    }
    return _bank;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.existing != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? l10n.editCard : l10n.addCard)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.cardNetworkSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CardNetwork.values.map((network) {
                return ChoiceChip(
                  label: Text(PaymentCardDisplay.networkLabel(network, l10n)),
                  selected: _network == network,
                  onSelected: (_) => setState(() => _network = network),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(l10n.cardBankSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...CardConstants.suggestedBanks.map(
                  (bank) => ChoiceChip(
                    label: Text(PaymentCardDisplay.bankLabel(bank, l10n)),
                    selected: _bank == bank && !_useCustomBank,
                    onSelected: (_) => setState(() {
                      _bank = bank;
                      _useCustomBank = false;
                    }),
                  ),
                ),
                ChoiceChip(
                  label: Text(l10n.bankOther),
                  selected: _bank == CardConstants.otherBank || _useCustomBank,
                  onSelected: (_) => setState(() {
                    _bank = CardConstants.otherBank;
                    _useCustomBank = true;
                  }),
                ),
              ],
            ),
            if (_bank == CardConstants.otherBank) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _customBankController,
                decoration: InputDecoration(labelText: l10n.customBankLabel),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (_bank == CardConstants.otherBank &&
                      (value == null || value.trim().isEmpty)) {
                    return l10n.fieldRequired;
                  }
                  return null;
                },
              ),
            ],
            const SizedBox(height: 20),
            Text(l10n.cardTierSection, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CardTier.values.map((tier) {
                return ChoiceChip(
                  label: Text(PaymentCardDisplay.tierLabel(tier, l10n)),
                  selected: _tier == tier,
                  onSelected: (_) => setState(() => _tier = _tier == tier ? null : tier),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _last4Controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.last4DigitsLabel,
                counterText: '',
              ),
              onChanged: (_) => setState(() {}),
              validator: (value) {
                final error = PaymentCardDisplay.validateLast4(value);
                if (error != null) {
                  return l10n.invalidLast4;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(l10n.cardPreviewLabel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  PaymentCardDisplay.preview(_previewCard, l10n),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: Text(isEditing ? l10n.save : l10n.addCard),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final existing = widget.existing;
    final now = DateTime.now().toUtc();
    final last4 = _last4Controller.text.trim();
    final card = PaymentCardModel(
      id: existing?.id ?? _uuid.v4(),
      network: _network,
      bankName: _resolvedBankName(),
      cardTier: _tier,
      last4: last4.isEmpty ? null : last4,
      nickname: existing?.nickname,
      isArchived: existing?.isArchived ?? false,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
      archivedAt: existing?.archivedAt,
    );

    await ref.read(paymentCardRepositoryProvider).upsert(card);
    if (mounted) {
      context.pop(card);
    }
  }
}
