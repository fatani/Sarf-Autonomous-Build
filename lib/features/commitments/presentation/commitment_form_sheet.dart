import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/commitment_currency.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/features/commitments/application/commitment_actions.dart';
import 'package:sarf/l10n/app_localizations.dart';

class CommitmentFormSheet extends ConsumerStatefulWidget {
  const CommitmentFormSheet({
    this.existing,
    this.template,
    super.key,
  });

  final CommitmentModel? existing;
  final ServiceTemplateModel? template;

  @override
  ConsumerState<CommitmentFormSheet> createState() => _CommitmentFormSheetState();
}

class _CommitmentFormSheetState extends ConsumerState<CommitmentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _paidAmountController;
  late final TextEditingController _paymentSourceController;
  late final TextEditingController _notesController;
  late BillingCycle _billingCycle;
  late CommitmentCategory _category;
  late DateTime _nextDueDate;
  int? _reminderDaysBefore;
  late String _currency;
  late PaymentMethod _paymentMethod;
  var _currencyInitialized = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    final template = widget.template;
    _nameController = TextEditingController(text: existing?.name ?? template?.nameEn ?? '');
    _amountController = TextEditingController(
      text: existing?.amount.toString() ??
          (template?.defaultAmount?.toString() ?? ''),
    );
    _paidAmountController = TextEditingController(
      text: existing != null && existing.hasForeignCurrency
          ? existing.paidReportingAmount.toString()
          : '',
    );
    _paymentSourceController = TextEditingController(
      text: existing?.paymentSourceLabel ?? '',
    );
    _notesController = TextEditingController(text: existing?.notes ?? '');
    _billingCycle = existing?.billingCycle ?? template?.defaultBillingCycle ?? BillingCycle.monthly;
    _category = existing?.category ?? template?.category ?? CommitmentCategory.other;
    _nextDueDate = existing?.nextDueDate ?? DateTime.now().add(const Duration(days: 30));
    _reminderDaysBefore = existing?.reminderDaysBefore ?? 3;
    _currency = existing?.currency ??
        template?.defaultCurrency ??
        AppConstants.defaultCurrency;
    _paymentMethod = existing?.paymentMethod ?? PaymentMethod.card;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _paidAmountController.dispose();
    _paymentSourceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String get _reportingCurrency {
    return ref.read(settingsProvider).valueOrNull?.defaultCurrency ??
        AppConstants.defaultCurrency;
  }

  bool get _needsConversion =>
      CommitmentCurrency.needsConversion(_currency, _reportingCurrency);

  double? get _parsedAmount => double.tryParse(_amountController.text.trim());

  double? get _parsedPaidAmount {
    if (!_needsConversion) {
      return _parsedAmount;
    }
    return double.tryParse(_paidAmountController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.existing != null;
    final settings = ref.watch(settingsProvider);
    final locale = Localizations.localeOf(context);

    settings.whenData((value) {
      if (!_currencyInitialized && widget.existing == null && widget.template == null) {
        _currency = value.defaultCurrency;
        _currencyInitialized = true;
      }
    });

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? l10n.editCommitment : l10n.addCommitment,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.nameLabel),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? l10n.fieldRequired : null,
              ),
              const SizedBox(height: 12),
              Text(l10n.amountSectionTitle, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: _needsConversion ? l10n.originalAmountLabel : l10n.amountLabel,
                ),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed <= 0) {
                    return l10n.invalidAmount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: ValueKey(_currency),
                initialValue: _currency,
                decoration: InputDecoration(
                  labelText: _needsConversion ? l10n.originalCurrencyLabel : l10n.currencyLabel,
                ),
                items: AppConstants.supportedCurrencies
                    .map(
                      (code) => DropdownMenuItem(
                        value: code,
                        child: Text(code),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _currency = value);
                  }
                },
              ),
              if (_needsConversion) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _paidAmountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.paidAmountInReportingCurrency(_reportingCurrency),
                  ),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (!_needsConversion) {
                      return null;
                    }
                    final parsed = double.tryParse(value ?? '');
                    if (parsed == null || parsed <= 0) {
                      return l10n.invalidPaidAmount;
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 16),
              Text(l10n.paymentSectionTitle, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              DropdownButtonFormField<PaymentMethod>(
                key: ValueKey(_paymentMethod),
                initialValue: _paymentMethod,
                decoration: InputDecoration(labelText: l10n.paymentMethodLabel),
                items: PaymentMethod.values
                    .map(
                      (method) => DropdownMenuItem(
                        value: method,
                        child: Text(Formatters.paymentMethodLabel(method, l10n)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _paymentMethod = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _paymentSourceController,
                decoration: InputDecoration(
                  labelText: l10n.paymentSourceLabel,
                  hintText: l10n.paymentSourceHint,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<BillingCycle>(
                initialValue: _billingCycle,
                decoration: InputDecoration(labelText: l10n.billingCycleLabel),
                items: BillingCycle.values
                    .map(
                      (cycle) => DropdownMenuItem(
                        value: cycle,
                        child: Text(Formatters.billingCycleLabel(cycle, l10n)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _billingCycle = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CommitmentCategory>(
                initialValue: _category,
                decoration: InputDecoration(labelText: l10n.categoryLabel),
                items: CommitmentCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(Formatters.categoryLabel(category, l10n)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _category = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.nextDueDateLabel),
                subtitle: Text(Formatters.date(_nextDueDate, locale)),
                trailing: const Icon(Icons.calendar_today_outlined),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _nextDueDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _nextDueDate = picked);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int?>(
                initialValue: _reminderDaysBefore,
                decoration: InputDecoration(labelText: l10n.reminderDaysLabel),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.noReminder)),
                  for (final days in [1, 2, 3, 5, 7])
                    DropdownMenuItem(
                      value: days,
                      child: Text(l10n.reminderDaysOption(days)),
                    ),
                ],
                onChanged: (value) => setState(() => _reminderDaysBefore = value),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(labelText: l10n.notesLabel),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _save,
                      child: Text(l10n.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final existing = widget.existing;
    final paymentSource = _paymentSourceController.text.trim();
    final originalAmount = double.parse(_amountController.text.trim());
    final paidAmount = _parsedPaidAmount ?? originalAmount;

    final draft = CommitmentModel(
      id: existing?.id ?? '',
      name: _nameController.text.trim(),
      amount: originalAmount,
      currency: _currency,
      billingCycle: _billingCycle,
      category: _category,
      nextDueDate: DateUtilsSarf.startOfDay(_nextDueDate),
      reminderDaysBefore: _reminderDaysBefore,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      templateId: existing?.templateId ?? widget.template?.id,
      isPaused: existing?.isPaused ?? false,
      deletedAt: existing?.deletedAt,
      createdAt: existing?.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: existing?.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      reportingCurrency: _reportingCurrency,
      paidReportingAmount: paidAmount,
      paymentMethod: _paymentMethod,
      paymentSourceLabel: paymentSource.isEmpty ? null : paymentSource,
    );

    await ref.read(commitmentActionsProvider).createFromInput(
          draft: draft,
          paidReportingAmount: paidAmount,
        );
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
