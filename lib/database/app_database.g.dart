// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CommitmentsTable extends Commitments
    with TableInfo<$CommitmentsTable, Commitment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingCycleMeta = const VerificationMeta(
    'billingCycle',
  );
  @override
  late final GeneratedColumn<String> billingCycle = GeneratedColumn<String>(
    'billing_cycle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderDaysBeforeMeta =
      const VerificationMeta('reminderDaysBefore');
  @override
  late final GeneratedColumn<int> reminderDaysBefore = GeneratedColumn<int>(
    'reminder_days_before',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPausedMeta = const VerificationMeta(
    'isPaused',
  );
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
    'is_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportingCurrencyMeta = const VerificationMeta(
    'reportingCurrency',
  );
  @override
  late final GeneratedColumn<String> reportingCurrency =
      GeneratedColumn<String>(
        'reporting_currency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('SAR'),
      );
  static const VerificationMeta _paidReportingAmountMeta =
      const VerificationMeta('paidReportingAmount');
  @override
  late final GeneratedColumn<double> paidReportingAmount =
      GeneratedColumn<double>(
        'paid_reporting_amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _exchangeRateMeta = const VerificationMeta(
    'exchangeRate',
  );
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
    'exchange_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('card'),
  );
  static const VerificationMeta _paymentSourceLabelMeta =
      const VerificationMeta('paymentSourceLabel');
  @override
  late final GeneratedColumn<String> paymentSourceLabel =
      GeneratedColumn<String>(
        'payment_source_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amount,
    currency,
    billingCycle,
    category,
    nextDueDate,
    reminderDaysBefore,
    notes,
    templateId,
    isPaused,
    deletedAt,
    createdAt,
    updatedAt,
    reportingCurrency,
    paidReportingAmount,
    exchangeRate,
    paymentMethod,
    paymentSourceLabel,
    cardId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commitments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Commitment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('billing_cycle')) {
      context.handle(
        _billingCycleMeta,
        billingCycle.isAcceptableOrUnknown(
          data['billing_cycle']!,
          _billingCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingCycleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('reminder_days_before')) {
      context.handle(
        _reminderDaysBeforeMeta,
        reminderDaysBefore.isAcceptableOrUnknown(
          data['reminder_days_before']!,
          _reminderDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('is_paused')) {
      context.handle(
        _isPausedMeta,
        isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('reporting_currency')) {
      context.handle(
        _reportingCurrencyMeta,
        reportingCurrency.isAcceptableOrUnknown(
          data['reporting_currency']!,
          _reportingCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('paid_reporting_amount')) {
      context.handle(
        _paidReportingAmountMeta,
        paidReportingAmount.isAcceptableOrUnknown(
          data['paid_reporting_amount']!,
          _paidReportingAmountMeta,
        ),
      );
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
        _exchangeRateMeta,
        exchangeRate.isAcceptableOrUnknown(
          data['exchange_rate']!,
          _exchangeRateMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('payment_source_label')) {
      context.handle(
        _paymentSourceLabelMeta,
        paymentSourceLabel.isAcceptableOrUnknown(
          data['payment_source_label']!,
          _paymentSourceLabelMeta,
        ),
      );
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Commitment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Commitment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      billingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_cycle'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      )!,
      reminderDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days_before'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      isPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paused'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      reportingCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporting_currency'],
      )!,
      paidReportingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_reporting_amount'],
      )!,
      exchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paymentSourceLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_source_label'],
      ),
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      ),
    );
  }

  @override
  $CommitmentsTable createAlias(String alias) {
    return $CommitmentsTable(attachedDatabase, alias);
  }
}

class Commitment extends DataClass implements Insertable<Commitment> {
  final String id;
  final String name;
  final double amount;
  final String currency;
  final String billingCycle;
  final String category;
  final DateTime nextDueDate;
  final int? reminderDaysBefore;
  final String? notes;
  final String? templateId;
  final bool isPaused;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String reportingCurrency;
  final double paidReportingAmount;
  final double? exchangeRate;
  final String paymentMethod;
  final String? paymentSourceLabel;
  final String? cardId;
  const Commitment({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.billingCycle,
    required this.category,
    required this.nextDueDate,
    this.reminderDaysBefore,
    this.notes,
    this.templateId,
    required this.isPaused,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.reportingCurrency,
    required this.paidReportingAmount,
    this.exchangeRate,
    required this.paymentMethod,
    this.paymentSourceLabel,
    this.cardId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['billing_cycle'] = Variable<String>(billingCycle);
    map['category'] = Variable<String>(category);
    map['next_due_date'] = Variable<DateTime>(nextDueDate);
    if (!nullToAbsent || reminderDaysBefore != null) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['is_paused'] = Variable<bool>(isPaused);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['reporting_currency'] = Variable<String>(reportingCurrency);
    map['paid_reporting_amount'] = Variable<double>(paidReportingAmount);
    if (!nullToAbsent || exchangeRate != null) {
      map['exchange_rate'] = Variable<double>(exchangeRate);
    }
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || paymentSourceLabel != null) {
      map['payment_source_label'] = Variable<String>(paymentSourceLabel);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<String>(cardId);
    }
    return map;
  }

  CommitmentsCompanion toCompanion(bool nullToAbsent) {
    return CommitmentsCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      currency: Value(currency),
      billingCycle: Value(billingCycle),
      category: Value(category),
      nextDueDate: Value(nextDueDate),
      reminderDaysBefore: reminderDaysBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDaysBefore),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      isPaused: Value(isPaused),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      reportingCurrency: Value(reportingCurrency),
      paidReportingAmount: Value(paidReportingAmount),
      exchangeRate: exchangeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(exchangeRate),
      paymentMethod: Value(paymentMethod),
      paymentSourceLabel: paymentSourceLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentSourceLabel),
      cardId: cardId == null && nullToAbsent
          ? const Value.absent()
          : Value(cardId),
    );
  }

  factory Commitment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Commitment(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      billingCycle: serializer.fromJson<String>(json['billingCycle']),
      category: serializer.fromJson<String>(json['category']),
      nextDueDate: serializer.fromJson<DateTime>(json['nextDueDate']),
      reminderDaysBefore: serializer.fromJson<int?>(json['reminderDaysBefore']),
      notes: serializer.fromJson<String?>(json['notes']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      reportingCurrency: serializer.fromJson<String>(json['reportingCurrency']),
      paidReportingAmount: serializer.fromJson<double>(
        json['paidReportingAmount'],
      ),
      exchangeRate: serializer.fromJson<double?>(json['exchangeRate']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentSourceLabel: serializer.fromJson<String?>(
        json['paymentSourceLabel'],
      ),
      cardId: serializer.fromJson<String?>(json['cardId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'billingCycle': serializer.toJson<String>(billingCycle),
      'category': serializer.toJson<String>(category),
      'nextDueDate': serializer.toJson<DateTime>(nextDueDate),
      'reminderDaysBefore': serializer.toJson<int?>(reminderDaysBefore),
      'notes': serializer.toJson<String?>(notes),
      'templateId': serializer.toJson<String?>(templateId),
      'isPaused': serializer.toJson<bool>(isPaused),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'reportingCurrency': serializer.toJson<String>(reportingCurrency),
      'paidReportingAmount': serializer.toJson<double>(paidReportingAmount),
      'exchangeRate': serializer.toJson<double?>(exchangeRate),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentSourceLabel': serializer.toJson<String?>(paymentSourceLabel),
      'cardId': serializer.toJson<String?>(cardId),
    };
  }

  Commitment copyWith({
    String? id,
    String? name,
    double? amount,
    String? currency,
    String? billingCycle,
    String? category,
    DateTime? nextDueDate,
    Value<int?> reminderDaysBefore = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> templateId = const Value.absent(),
    bool? isPaused,
    Value<DateTime?> deletedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? reportingCurrency,
    double? paidReportingAmount,
    Value<double?> exchangeRate = const Value.absent(),
    String? paymentMethod,
    Value<String?> paymentSourceLabel = const Value.absent(),
    Value<String?> cardId = const Value.absent(),
  }) => Commitment(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    billingCycle: billingCycle ?? this.billingCycle,
    category: category ?? this.category,
    nextDueDate: nextDueDate ?? this.nextDueDate,
    reminderDaysBefore: reminderDaysBefore.present
        ? reminderDaysBefore.value
        : this.reminderDaysBefore,
    notes: notes.present ? notes.value : this.notes,
    templateId: templateId.present ? templateId.value : this.templateId,
    isPaused: isPaused ?? this.isPaused,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    reportingCurrency: reportingCurrency ?? this.reportingCurrency,
    paidReportingAmount: paidReportingAmount ?? this.paidReportingAmount,
    exchangeRate: exchangeRate.present ? exchangeRate.value : this.exchangeRate,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paymentSourceLabel: paymentSourceLabel.present
        ? paymentSourceLabel.value
        : this.paymentSourceLabel,
    cardId: cardId.present ? cardId.value : this.cardId,
  );
  Commitment copyWithCompanion(CommitmentsCompanion data) {
    return Commitment(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      billingCycle: data.billingCycle.present
          ? data.billingCycle.value
          : this.billingCycle,
      category: data.category.present ? data.category.value : this.category,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      reminderDaysBefore: data.reminderDaysBefore.present
          ? data.reminderDaysBefore.value
          : this.reminderDaysBefore,
      notes: data.notes.present ? data.notes.value : this.notes,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      reportingCurrency: data.reportingCurrency.present
          ? data.reportingCurrency.value
          : this.reportingCurrency,
      paidReportingAmount: data.paidReportingAmount.present
          ? data.paidReportingAmount.value
          : this.paidReportingAmount,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentSourceLabel: data.paymentSourceLabel.present
          ? data.paymentSourceLabel.value
          : this.paymentSourceLabel,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Commitment(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('category: $category, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('notes: $notes, ')
          ..write('templateId: $templateId, ')
          ..write('isPaused: $isPaused, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('reportingCurrency: $reportingCurrency, ')
          ..write('paidReportingAmount: $paidReportingAmount, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentSourceLabel: $paymentSourceLabel, ')
          ..write('cardId: $cardId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    amount,
    currency,
    billingCycle,
    category,
    nextDueDate,
    reminderDaysBefore,
    notes,
    templateId,
    isPaused,
    deletedAt,
    createdAt,
    updatedAt,
    reportingCurrency,
    paidReportingAmount,
    exchangeRate,
    paymentMethod,
    paymentSourceLabel,
    cardId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Commitment &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.billingCycle == this.billingCycle &&
          other.category == this.category &&
          other.nextDueDate == this.nextDueDate &&
          other.reminderDaysBefore == this.reminderDaysBefore &&
          other.notes == this.notes &&
          other.templateId == this.templateId &&
          other.isPaused == this.isPaused &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.reportingCurrency == this.reportingCurrency &&
          other.paidReportingAmount == this.paidReportingAmount &&
          other.exchangeRate == this.exchangeRate &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentSourceLabel == this.paymentSourceLabel &&
          other.cardId == this.cardId);
}

class CommitmentsCompanion extends UpdateCompanion<Commitment> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> currency;
  final Value<String> billingCycle;
  final Value<String> category;
  final Value<DateTime> nextDueDate;
  final Value<int?> reminderDaysBefore;
  final Value<String?> notes;
  final Value<String?> templateId;
  final Value<bool> isPaused;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> reportingCurrency;
  final Value<double> paidReportingAmount;
  final Value<double?> exchangeRate;
  final Value<String> paymentMethod;
  final Value<String?> paymentSourceLabel;
  final Value<String?> cardId;
  final Value<int> rowid;
  const CommitmentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.billingCycle = const Value.absent(),
    this.category = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.notes = const Value.absent(),
    this.templateId = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.reportingCurrency = const Value.absent(),
    this.paidReportingAmount = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentSourceLabel = const Value.absent(),
    this.cardId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommitmentsCompanion.insert({
    required String id,
    required String name,
    required double amount,
    required String currency,
    required String billingCycle,
    required String category,
    required DateTime nextDueDate,
    this.reminderDaysBefore = const Value.absent(),
    this.notes = const Value.absent(),
    this.templateId = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.reportingCurrency = const Value.absent(),
    this.paidReportingAmount = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentSourceLabel = const Value.absent(),
    this.cardId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       amount = Value(amount),
       currency = Value(currency),
       billingCycle = Value(billingCycle),
       category = Value(category),
       nextDueDate = Value(nextDueDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Commitment> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<String>? billingCycle,
    Expression<String>? category,
    Expression<DateTime>? nextDueDate,
    Expression<int>? reminderDaysBefore,
    Expression<String>? notes,
    Expression<String>? templateId,
    Expression<bool>? isPaused,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? reportingCurrency,
    Expression<double>? paidReportingAmount,
    Expression<double>? exchangeRate,
    Expression<String>? paymentMethod,
    Expression<String>? paymentSourceLabel,
    Expression<String>? cardId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (billingCycle != null) 'billing_cycle': billingCycle,
      if (category != null) 'category': category,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (reminderDaysBefore != null)
        'reminder_days_before': reminderDaysBefore,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'template_id': templateId,
      if (isPaused != null) 'is_paused': isPaused,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (reportingCurrency != null) 'reporting_currency': reportingCurrency,
      if (paidReportingAmount != null)
        'paid_reporting_amount': paidReportingAmount,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentSourceLabel != null)
        'payment_source_label': paymentSourceLabel,
      if (cardId != null) 'card_id': cardId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommitmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? currency,
    Value<String>? billingCycle,
    Value<String>? category,
    Value<DateTime>? nextDueDate,
    Value<int?>? reminderDaysBefore,
    Value<String?>? notes,
    Value<String?>? templateId,
    Value<bool>? isPaused,
    Value<DateTime?>? deletedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? reportingCurrency,
    Value<double>? paidReportingAmount,
    Value<double?>? exchangeRate,
    Value<String>? paymentMethod,
    Value<String?>? paymentSourceLabel,
    Value<String?>? cardId,
    Value<int>? rowid,
  }) {
    return CommitmentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      category: category ?? this.category,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      notes: notes ?? this.notes,
      templateId: templateId ?? this.templateId,
      isPaused: isPaused ?? this.isPaused,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reportingCurrency: reportingCurrency ?? this.reportingCurrency,
      paidReportingAmount: paidReportingAmount ?? this.paidReportingAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentSourceLabel: paymentSourceLabel ?? this.paymentSourceLabel,
      cardId: cardId ?? this.cardId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (billingCycle.present) {
      map['billing_cycle'] = Variable<String>(billingCycle.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (reminderDaysBefore.present) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (reportingCurrency.present) {
      map['reporting_currency'] = Variable<String>(reportingCurrency.value);
    }
    if (paidReportingAmount.present) {
      map['paid_reporting_amount'] = Variable<double>(
        paidReportingAmount.value,
      );
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentSourceLabel.present) {
      map['payment_source_label'] = Variable<String>(paymentSourceLabel.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitmentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('billingCycle: $billingCycle, ')
          ..write('category: $category, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('notes: $notes, ')
          ..write('templateId: $templateId, ')
          ..write('isPaused: $isPaused, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('reportingCurrency: $reportingCurrency, ')
          ..write('paidReportingAmount: $paidReportingAmount, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentSourceLabel: $paymentSourceLabel, ')
          ..write('cardId: $cardId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentCardsTable extends PaymentCards
    with TableInfo<$PaymentCardsTable, PaymentCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _networkMeta = const VerificationMeta(
    'network',
  );
  @override
  late final GeneratedColumn<String> network = GeneratedColumn<String>(
    'network',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardTierMeta = const VerificationMeta(
    'cardTier',
  );
  @override
  late final GeneratedColumn<String> cardTier = GeneratedColumn<String>(
    'card_tier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _last4Meta = const VerificationMeta('last4');
  @override
  late final GeneratedColumn<String> last4 = GeneratedColumn<String>(
    'last4',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    network,
    bankName,
    cardTier,
    last4,
    nickname,
    isArchived,
    createdAt,
    updatedAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('network')) {
      context.handle(
        _networkMeta,
        network.isAcceptableOrUnknown(data['network']!, _networkMeta),
      );
    } else if (isInserting) {
      context.missing(_networkMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('card_tier')) {
      context.handle(
        _cardTierMeta,
        cardTier.isAcceptableOrUnknown(data['card_tier']!, _cardTierMeta),
      );
    }
    if (data.containsKey('last4')) {
      context.handle(
        _last4Meta,
        last4.isAcceptableOrUnknown(data['last4']!, _last4Meta),
      );
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      network: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}network'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      cardTier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_tier'],
      ),
      last4: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last4'],
      ),
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $PaymentCardsTable createAlias(String alias) {
    return $PaymentCardsTable(attachedDatabase, alias);
  }
}

class PaymentCard extends DataClass implements Insertable<PaymentCard> {
  final String id;
  final String network;
  final String bankName;
  final String? cardTier;
  final String? last4;
  final String? nickname;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  const PaymentCard({
    required this.id,
    required this.network,
    required this.bankName,
    this.cardTier,
    this.last4,
    this.nickname,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['network'] = Variable<String>(network);
    map['bank_name'] = Variable<String>(bankName);
    if (!nullToAbsent || cardTier != null) {
      map['card_tier'] = Variable<String>(cardTier);
    }
    if (!nullToAbsent || last4 != null) {
      map['last4'] = Variable<String>(last4);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  PaymentCardsCompanion toCompanion(bool nullToAbsent) {
    return PaymentCardsCompanion(
      id: Value(id),
      network: Value(network),
      bankName: Value(bankName),
      cardTier: cardTier == null && nullToAbsent
          ? const Value.absent()
          : Value(cardTier),
      last4: last4 == null && nullToAbsent
          ? const Value.absent()
          : Value(last4),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory PaymentCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentCard(
      id: serializer.fromJson<String>(json['id']),
      network: serializer.fromJson<String>(json['network']),
      bankName: serializer.fromJson<String>(json['bankName']),
      cardTier: serializer.fromJson<String?>(json['cardTier']),
      last4: serializer.fromJson<String?>(json['last4']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'network': serializer.toJson<String>(network),
      'bankName': serializer.toJson<String>(bankName),
      'cardTier': serializer.toJson<String?>(cardTier),
      'last4': serializer.toJson<String?>(last4),
      'nickname': serializer.toJson<String?>(nickname),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  PaymentCard copyWith({
    String? id,
    String? network,
    String? bankName,
    Value<String?> cardTier = const Value.absent(),
    Value<String?> last4 = const Value.absent(),
    Value<String?> nickname = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => PaymentCard(
    id: id ?? this.id,
    network: network ?? this.network,
    bankName: bankName ?? this.bankName,
    cardTier: cardTier.present ? cardTier.value : this.cardTier,
    last4: last4.present ? last4.value : this.last4,
    nickname: nickname.present ? nickname.value : this.nickname,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  PaymentCard copyWithCompanion(PaymentCardsCompanion data) {
    return PaymentCard(
      id: data.id.present ? data.id.value : this.id,
      network: data.network.present ? data.network.value : this.network,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      cardTier: data.cardTier.present ? data.cardTier.value : this.cardTier,
      last4: data.last4.present ? data.last4.value : this.last4,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentCard(')
          ..write('id: $id, ')
          ..write('network: $network, ')
          ..write('bankName: $bankName, ')
          ..write('cardTier: $cardTier, ')
          ..write('last4: $last4, ')
          ..write('nickname: $nickname, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    network,
    bankName,
    cardTier,
    last4,
    nickname,
    isArchived,
    createdAt,
    updatedAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentCard &&
          other.id == this.id &&
          other.network == this.network &&
          other.bankName == this.bankName &&
          other.cardTier == this.cardTier &&
          other.last4 == this.last4 &&
          other.nickname == this.nickname &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt);
}

class PaymentCardsCompanion extends UpdateCompanion<PaymentCard> {
  final Value<String> id;
  final Value<String> network;
  final Value<String> bankName;
  final Value<String?> cardTier;
  final Value<String?> last4;
  final Value<String?> nickname;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const PaymentCardsCompanion({
    this.id = const Value.absent(),
    this.network = const Value.absent(),
    this.bankName = const Value.absent(),
    this.cardTier = const Value.absent(),
    this.last4 = const Value.absent(),
    this.nickname = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentCardsCompanion.insert({
    required String id,
    required String network,
    required String bankName,
    this.cardTier = const Value.absent(),
    this.last4 = const Value.absent(),
    this.nickname = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       network = Value(network),
       bankName = Value(bankName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PaymentCard> custom({
    Expression<String>? id,
    Expression<String>? network,
    Expression<String>? bankName,
    Expression<String>? cardTier,
    Expression<String>? last4,
    Expression<String>? nickname,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (network != null) 'network': network,
      if (bankName != null) 'bank_name': bankName,
      if (cardTier != null) 'card_tier': cardTier,
      if (last4 != null) 'last4': last4,
      if (nickname != null) 'nickname': nickname,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? network,
    Value<String>? bankName,
    Value<String?>? cardTier,
    Value<String?>? last4,
    Value<String?>? nickname,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return PaymentCardsCompanion(
      id: id ?? this.id,
      network: network ?? this.network,
      bankName: bankName ?? this.bankName,
      cardTier: cardTier ?? this.cardTier,
      last4: last4 ?? this.last4,
      nickname: nickname ?? this.nickname,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (network.present) {
      map['network'] = Variable<String>(network.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (cardTier.present) {
      map['card_tier'] = Variable<String>(cardTier.value);
    }
    if (last4.present) {
      map['last4'] = Variable<String>(last4.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentCardsCompanion(')
          ..write('id: $id, ')
          ..write('network: $network, ')
          ..write('bankName: $bankName, ')
          ..write('cardTier: $cardTier, ')
          ..write('last4: $last4, ')
          ..write('nickname: $nickname, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceTemplatesTable extends ServiceTemplates
    with TableInfo<$ServiceTemplatesTable, ServiceTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultAmountMeta = const VerificationMeta(
    'defaultAmount',
  );
  @override
  late final GeneratedColumn<double> defaultAmount = GeneratedColumn<double>(
    'default_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultBillingCycleMeta =
      const VerificationMeta('defaultBillingCycle');
  @override
  late final GeneratedColumn<String> defaultBillingCycle =
      GeneratedColumn<String>(
        'default_billing_cycle',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('receipt_long'),
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameAr,
    category,
    defaultAmount,
    defaultBillingCycle,
    iconName,
    isBuiltIn,
    defaultCurrency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('default_amount')) {
      context.handle(
        _defaultAmountMeta,
        defaultAmount.isAcceptableOrUnknown(
          data['default_amount']!,
          _defaultAmountMeta,
        ),
      );
    }
    if (data.containsKey('default_billing_cycle')) {
      context.handle(
        _defaultBillingCycleMeta,
        defaultBillingCycle.isAcceptableOrUnknown(
          data['default_billing_cycle']!,
          _defaultBillingCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultBillingCycleMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      defaultAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_amount'],
      ),
      defaultBillingCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_billing_cycle'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      ),
    );
  }

  @override
  $ServiceTemplatesTable createAlias(String alias) {
    return $ServiceTemplatesTable(attachedDatabase, alias);
  }
}

class ServiceTemplate extends DataClass implements Insertable<ServiceTemplate> {
  final String id;
  final String nameEn;
  final String nameAr;
  final String category;
  final double? defaultAmount;
  final String defaultBillingCycle;
  final String iconName;
  final bool isBuiltIn;
  final String? defaultCurrency;
  const ServiceTemplate({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.category,
    this.defaultAmount,
    required this.defaultBillingCycle,
    required this.iconName,
    required this.isBuiltIn,
    this.defaultCurrency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_ar'] = Variable<String>(nameAr);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || defaultAmount != null) {
      map['default_amount'] = Variable<double>(defaultAmount);
    }
    map['default_billing_cycle'] = Variable<String>(defaultBillingCycle);
    map['icon_name'] = Variable<String>(iconName);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    if (!nullToAbsent || defaultCurrency != null) {
      map['default_currency'] = Variable<String>(defaultCurrency);
    }
    return map;
  }

  ServiceTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ServiceTemplatesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameAr: Value(nameAr),
      category: Value(category),
      defaultAmount: defaultAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAmount),
      defaultBillingCycle: Value(defaultBillingCycle),
      iconName: Value(iconName),
      isBuiltIn: Value(isBuiltIn),
      defaultCurrency: defaultCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCurrency),
    );
  }

  factory ServiceTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceTemplate(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      category: serializer.fromJson<String>(json['category']),
      defaultAmount: serializer.fromJson<double?>(json['defaultAmount']),
      defaultBillingCycle: serializer.fromJson<String>(
        json['defaultBillingCycle'],
      ),
      iconName: serializer.fromJson<String>(json['iconName']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      defaultCurrency: serializer.fromJson<String?>(json['defaultCurrency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAr': serializer.toJson<String>(nameAr),
      'category': serializer.toJson<String>(category),
      'defaultAmount': serializer.toJson<double?>(defaultAmount),
      'defaultBillingCycle': serializer.toJson<String>(defaultBillingCycle),
      'iconName': serializer.toJson<String>(iconName),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'defaultCurrency': serializer.toJson<String?>(defaultCurrency),
    };
  }

  ServiceTemplate copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    String? category,
    Value<double?> defaultAmount = const Value.absent(),
    String? defaultBillingCycle,
    String? iconName,
    bool? isBuiltIn,
    Value<String?> defaultCurrency = const Value.absent(),
  }) => ServiceTemplate(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameAr: nameAr ?? this.nameAr,
    category: category ?? this.category,
    defaultAmount: defaultAmount.present
        ? defaultAmount.value
        : this.defaultAmount,
    defaultBillingCycle: defaultBillingCycle ?? this.defaultBillingCycle,
    iconName: iconName ?? this.iconName,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    defaultCurrency: defaultCurrency.present
        ? defaultCurrency.value
        : this.defaultCurrency,
  );
  ServiceTemplate copyWithCompanion(ServiceTemplatesCompanion data) {
    return ServiceTemplate(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      category: data.category.present ? data.category.value : this.category,
      defaultAmount: data.defaultAmount.present
          ? data.defaultAmount.value
          : this.defaultAmount,
      defaultBillingCycle: data.defaultBillingCycle.present
          ? data.defaultBillingCycle.value
          : this.defaultBillingCycle,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceTemplate(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('category: $category, ')
          ..write('defaultAmount: $defaultAmount, ')
          ..write('defaultBillingCycle: $defaultBillingCycle, ')
          ..write('iconName: $iconName, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('defaultCurrency: $defaultCurrency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameAr,
    category,
    defaultAmount,
    defaultBillingCycle,
    iconName,
    isBuiltIn,
    defaultCurrency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceTemplate &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameAr == this.nameAr &&
          other.category == this.category &&
          other.defaultAmount == this.defaultAmount &&
          other.defaultBillingCycle == this.defaultBillingCycle &&
          other.iconName == this.iconName &&
          other.isBuiltIn == this.isBuiltIn &&
          other.defaultCurrency == this.defaultCurrency);
}

class ServiceTemplatesCompanion extends UpdateCompanion<ServiceTemplate> {
  final Value<String> id;
  final Value<String> nameEn;
  final Value<String> nameAr;
  final Value<String> category;
  final Value<double?> defaultAmount;
  final Value<String> defaultBillingCycle;
  final Value<String> iconName;
  final Value<bool> isBuiltIn;
  final Value<String?> defaultCurrency;
  final Value<int> rowid;
  const ServiceTemplatesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultAmount = const Value.absent(),
    this.defaultBillingCycle = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceTemplatesCompanion.insert({
    required String id,
    required String nameEn,
    required String nameAr,
    required String category,
    this.defaultAmount = const Value.absent(),
    required String defaultBillingCycle,
    this.iconName = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameEn = Value(nameEn),
       nameAr = Value(nameAr),
       category = Value(category),
       defaultBillingCycle = Value(defaultBillingCycle);
  static Insertable<ServiceTemplate> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameAr,
    Expression<String>? category,
    Expression<double>? defaultAmount,
    Expression<String>? defaultBillingCycle,
    Expression<String>? iconName,
    Expression<bool>? isBuiltIn,
    Expression<String>? defaultCurrency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAr != null) 'name_ar': nameAr,
      if (category != null) 'category': category,
      if (defaultAmount != null) 'default_amount': defaultAmount,
      if (defaultBillingCycle != null)
        'default_billing_cycle': defaultBillingCycle,
      if (iconName != null) 'icon_name': iconName,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? nameEn,
    Value<String>? nameAr,
    Value<String>? category,
    Value<double?>? defaultAmount,
    Value<String>? defaultBillingCycle,
    Value<String>? iconName,
    Value<bool>? isBuiltIn,
    Value<String?>? defaultCurrency,
    Value<int>? rowid,
  }) {
    return ServiceTemplatesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      category: category ?? this.category,
      defaultAmount: defaultAmount ?? this.defaultAmount,
      defaultBillingCycle: defaultBillingCycle ?? this.defaultBillingCycle,
      iconName: iconName ?? this.iconName,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultAmount.present) {
      map['default_amount'] = Variable<double>(defaultAmount.value);
    }
    if (defaultBillingCycle.present) {
      map['default_billing_cycle'] = Variable<String>(
        defaultBillingCycle.value,
      );
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('category: $category, ')
          ..write('defaultAmount: $defaultAmount, ')
          ..write('defaultBillingCycle: $defaultBillingCycle, ')
          ..write('iconName: $iconName, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationSchedulesTable extends NotificationSchedules
    with TableInfo<$NotificationSchedulesTable, NotificationSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commitmentIdMeta = const VerificationMeta(
    'commitmentId',
  );
  @override
  late final GeneratedColumn<String> commitmentId = GeneratedColumn<String>(
    'commitment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    commitmentId,
    scheduledAt,
    notificationId,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('commitment_id')) {
      context.handle(
        _commitmentIdMeta,
        commitmentId.isAcceptableOrUnknown(
          data['commitment_id']!,
          _commitmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_commitmentIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      commitmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commitment_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $NotificationSchedulesTable createAlias(String alias) {
    return $NotificationSchedulesTable(attachedDatabase, alias);
  }
}

class NotificationSchedule extends DataClass
    implements Insertable<NotificationSchedule> {
  final String id;
  final String commitmentId;
  final DateTime scheduledAt;
  final int notificationId;
  final String status;
  const NotificationSchedule({
    required this.id,
    required this.commitmentId,
    required this.scheduledAt,
    required this.notificationId,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['commitment_id'] = Variable<String>(commitmentId);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['notification_id'] = Variable<int>(notificationId);
    map['status'] = Variable<String>(status);
    return map;
  }

  NotificationSchedulesCompanion toCompanion(bool nullToAbsent) {
    return NotificationSchedulesCompanion(
      id: Value(id),
      commitmentId: Value(commitmentId),
      scheduledAt: Value(scheduledAt),
      notificationId: Value(notificationId),
      status: Value(status),
    );
  }

  factory NotificationSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSchedule(
      id: serializer.fromJson<String>(json['id']),
      commitmentId: serializer.fromJson<String>(json['commitmentId']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'commitmentId': serializer.toJson<String>(commitmentId),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'notificationId': serializer.toJson<int>(notificationId),
      'status': serializer.toJson<String>(status),
    };
  }

  NotificationSchedule copyWith({
    String? id,
    String? commitmentId,
    DateTime? scheduledAt,
    int? notificationId,
    String? status,
  }) => NotificationSchedule(
    id: id ?? this.id,
    commitmentId: commitmentId ?? this.commitmentId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    notificationId: notificationId ?? this.notificationId,
    status: status ?? this.status,
  );
  NotificationSchedule copyWithCompanion(NotificationSchedulesCompanion data) {
    return NotificationSchedule(
      id: data.id.present ? data.id.value : this.id,
      commitmentId: data.commitmentId.present
          ? data.commitmentId.value
          : this.commitmentId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSchedule(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, commitmentId, scheduledAt, notificationId, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSchedule &&
          other.id == this.id &&
          other.commitmentId == this.commitmentId &&
          other.scheduledAt == this.scheduledAt &&
          other.notificationId == this.notificationId &&
          other.status == this.status);
}

class NotificationSchedulesCompanion
    extends UpdateCompanion<NotificationSchedule> {
  final Value<String> id;
  final Value<String> commitmentId;
  final Value<DateTime> scheduledAt;
  final Value<int> notificationId;
  final Value<String> status;
  final Value<int> rowid;
  const NotificationSchedulesCompanion({
    this.id = const Value.absent(),
    this.commitmentId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationSchedulesCompanion.insert({
    required String id,
    required String commitmentId,
    required DateTime scheduledAt,
    required int notificationId,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       commitmentId = Value(commitmentId),
       scheduledAt = Value(scheduledAt),
       notificationId = Value(notificationId);
  static Insertable<NotificationSchedule> custom({
    Expression<String>? id,
    Expression<String>? commitmentId,
    Expression<DateTime>? scheduledAt,
    Expression<int>? notificationId,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commitmentId != null) 'commitment_id': commitmentId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (notificationId != null) 'notification_id': notificationId,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationSchedulesCompanion copyWith({
    Value<String>? id,
    Value<String>? commitmentId,
    Value<DateTime>? scheduledAt,
    Value<int>? notificationId,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return NotificationSchedulesCompanion(
      id: id ?? this.id,
      commitmentId: commitmentId ?? this.commitmentId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      notificationId: notificationId ?? this.notificationId,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (commitmentId.present) {
      map['commitment_id'] = Variable<String>(commitmentId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchemaMetaTable extends SchemaMeta
    with TableInfo<$SchemaMetaTable, SchemaMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchemaMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _migratedAtMeta = const VerificationMeta(
    'migratedAt',
  );
  @override
  late final GeneratedColumn<DateTime> migratedAt = GeneratedColumn<DateTime>(
    'migrated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [version, migratedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schema_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchemaMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('migrated_at')) {
      context.handle(
        _migratedAtMeta,
        migratedAt.isAcceptableOrUnknown(data['migrated_at']!, _migratedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_migratedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {version};
  @override
  SchemaMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchemaMetaData(
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      migratedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}migrated_at'],
      )!,
    );
  }

  @override
  $SchemaMetaTable createAlias(String alias) {
    return $SchemaMetaTable(attachedDatabase, alias);
  }
}

class SchemaMetaData extends DataClass implements Insertable<SchemaMetaData> {
  final int version;
  final DateTime migratedAt;
  const SchemaMetaData({required this.version, required this.migratedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<int>(version);
    map['migrated_at'] = Variable<DateTime>(migratedAt);
    return map;
  }

  SchemaMetaCompanion toCompanion(bool nullToAbsent) {
    return SchemaMetaCompanion(
      version: Value(version),
      migratedAt: Value(migratedAt),
    );
  }

  factory SchemaMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchemaMetaData(
      version: serializer.fromJson<int>(json['version']),
      migratedAt: serializer.fromJson<DateTime>(json['migratedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<int>(version),
      'migratedAt': serializer.toJson<DateTime>(migratedAt),
    };
  }

  SchemaMetaData copyWith({int? version, DateTime? migratedAt}) =>
      SchemaMetaData(
        version: version ?? this.version,
        migratedAt: migratedAt ?? this.migratedAt,
      );
  SchemaMetaData copyWithCompanion(SchemaMetaCompanion data) {
    return SchemaMetaData(
      version: data.version.present ? data.version.value : this.version,
      migratedAt: data.migratedAt.present
          ? data.migratedAt.value
          : this.migratedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMetaData(')
          ..write('version: $version, ')
          ..write('migratedAt: $migratedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(version, migratedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchemaMetaData &&
          other.version == this.version &&
          other.migratedAt == this.migratedAt);
}

class SchemaMetaCompanion extends UpdateCompanion<SchemaMetaData> {
  final Value<int> version;
  final Value<DateTime> migratedAt;
  const SchemaMetaCompanion({
    this.version = const Value.absent(),
    this.migratedAt = const Value.absent(),
  });
  SchemaMetaCompanion.insert({
    this.version = const Value.absent(),
    required DateTime migratedAt,
  }) : migratedAt = Value(migratedAt);
  static Insertable<SchemaMetaData> custom({
    Expression<int>? version,
    Expression<DateTime>? migratedAt,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (migratedAt != null) 'migrated_at': migratedAt,
    });
  }

  SchemaMetaCompanion copyWith({
    Value<int>? version,
    Value<DateTime>? migratedAt,
  }) {
    return SchemaMetaCompanion(
      version: version ?? this.version,
      migratedAt: migratedAt ?? this.migratedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (migratedAt.present) {
      map['migrated_at'] = Variable<DateTime>(migratedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMetaCompanion(')
          ..write('version: $version, ')
          ..write('migratedAt: $migratedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CommitmentsTable commitments = $CommitmentsTable(this);
  late final $PaymentCardsTable paymentCards = $PaymentCardsTable(this);
  late final $ServiceTemplatesTable serviceTemplates = $ServiceTemplatesTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $NotificationSchedulesTable notificationSchedules =
      $NotificationSchedulesTable(this);
  late final $SchemaMetaTable schemaMeta = $SchemaMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    commitments,
    paymentCards,
    serviceTemplates,
    appSettings,
    notificationSchedules,
    schemaMeta,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CommitmentsTableCreateCompanionBuilder =
    CommitmentsCompanion Function({
      required String id,
      required String name,
      required double amount,
      required String currency,
      required String billingCycle,
      required String category,
      required DateTime nextDueDate,
      Value<int?> reminderDaysBefore,
      Value<String?> notes,
      Value<String?> templateId,
      Value<bool> isPaused,
      Value<DateTime?> deletedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> reportingCurrency,
      Value<double> paidReportingAmount,
      Value<double?> exchangeRate,
      Value<String> paymentMethod,
      Value<String?> paymentSourceLabel,
      Value<String?> cardId,
      Value<int> rowid,
    });
typedef $$CommitmentsTableUpdateCompanionBuilder =
    CommitmentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> amount,
      Value<String> currency,
      Value<String> billingCycle,
      Value<String> category,
      Value<DateTime> nextDueDate,
      Value<int?> reminderDaysBefore,
      Value<String?> notes,
      Value<String?> templateId,
      Value<bool> isPaused,
      Value<DateTime?> deletedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> reportingCurrency,
      Value<double> paidReportingAmount,
      Value<double?> exchangeRate,
      Value<String> paymentMethod,
      Value<String?> paymentSourceLabel,
      Value<String?> cardId,
      Value<int> rowid,
    });

class $$CommitmentsTableFilterComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportingCurrency => $composableBuilder(
    column: $table.reportingCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidReportingAmount => $composableBuilder(
    column: $table.paidReportingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentSourceLabel => $composableBuilder(
    column: $table.paymentSourceLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CommitmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportingCurrency => $composableBuilder(
    column: $table.reportingCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidReportingAmount => $composableBuilder(
    column: $table.paidReportingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentSourceLabel => $composableBuilder(
    column: $table.paymentSourceLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommitmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get billingCycle => $composableBuilder(
    column: $table.billingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get reportingCurrency => $composableBuilder(
    column: $table.reportingCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidReportingAmount => $composableBuilder(
    column: $table.paidReportingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentSourceLabel => $composableBuilder(
    column: $table.paymentSourceLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);
}

class $$CommitmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CommitmentsTable,
          Commitment,
          $$CommitmentsTableFilterComposer,
          $$CommitmentsTableOrderingComposer,
          $$CommitmentsTableAnnotationComposer,
          $$CommitmentsTableCreateCompanionBuilder,
          $$CommitmentsTableUpdateCompanionBuilder,
          (
            Commitment,
            BaseReferences<_$AppDatabase, $CommitmentsTable, Commitment>,
          ),
          Commitment,
          PrefetchHooks Function()
        > {
  $$CommitmentsTableTableManager(_$AppDatabase db, $CommitmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommitmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommitmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommitmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> billingCycle = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> nextDueDate = const Value.absent(),
                Value<int?> reminderDaysBefore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> reportingCurrency = const Value.absent(),
                Value<double> paidReportingAmount = const Value.absent(),
                Value<double?> exchangeRate = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> paymentSourceLabel = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommitmentsCompanion(
                id: id,
                name: name,
                amount: amount,
                currency: currency,
                billingCycle: billingCycle,
                category: category,
                nextDueDate: nextDueDate,
                reminderDaysBefore: reminderDaysBefore,
                notes: notes,
                templateId: templateId,
                isPaused: isPaused,
                deletedAt: deletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                reportingCurrency: reportingCurrency,
                paidReportingAmount: paidReportingAmount,
                exchangeRate: exchangeRate,
                paymentMethod: paymentMethod,
                paymentSourceLabel: paymentSourceLabel,
                cardId: cardId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double amount,
                required String currency,
                required String billingCycle,
                required String category,
                required DateTime nextDueDate,
                Value<int?> reminderDaysBefore = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> reportingCurrency = const Value.absent(),
                Value<double> paidReportingAmount = const Value.absent(),
                Value<double?> exchangeRate = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> paymentSourceLabel = const Value.absent(),
                Value<String?> cardId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommitmentsCompanion.insert(
                id: id,
                name: name,
                amount: amount,
                currency: currency,
                billingCycle: billingCycle,
                category: category,
                nextDueDate: nextDueDate,
                reminderDaysBefore: reminderDaysBefore,
                notes: notes,
                templateId: templateId,
                isPaused: isPaused,
                deletedAt: deletedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                reportingCurrency: reportingCurrency,
                paidReportingAmount: paidReportingAmount,
                exchangeRate: exchangeRate,
                paymentMethod: paymentMethod,
                paymentSourceLabel: paymentSourceLabel,
                cardId: cardId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CommitmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CommitmentsTable,
      Commitment,
      $$CommitmentsTableFilterComposer,
      $$CommitmentsTableOrderingComposer,
      $$CommitmentsTableAnnotationComposer,
      $$CommitmentsTableCreateCompanionBuilder,
      $$CommitmentsTableUpdateCompanionBuilder,
      (
        Commitment,
        BaseReferences<_$AppDatabase, $CommitmentsTable, Commitment>,
      ),
      Commitment,
      PrefetchHooks Function()
    >;
typedef $$PaymentCardsTableCreateCompanionBuilder =
    PaymentCardsCompanion Function({
      required String id,
      required String network,
      required String bankName,
      Value<String?> cardTier,
      Value<String?> last4,
      Value<String?> nickname,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });
typedef $$PaymentCardsTableUpdateCompanionBuilder =
    PaymentCardsCompanion Function({
      Value<String> id,
      Value<String> network,
      Value<String> bankName,
      Value<String?> cardTier,
      Value<String?> last4,
      Value<String?> nickname,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<int> rowid,
    });

class $$PaymentCardsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentCardsTable> {
  $$PaymentCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardTier => $composableBuilder(
    column: $table.cardTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get last4 => $composableBuilder(
    column: $table.last4,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentCardsTable> {
  $$PaymentCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get network => $composableBuilder(
    column: $table.network,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardTier => $composableBuilder(
    column: $table.cardTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get last4 => $composableBuilder(
    column: $table.last4,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentCardsTable> {
  $$PaymentCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get network =>
      $composableBuilder(column: $table.network, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get cardTier =>
      $composableBuilder(column: $table.cardTier, builder: (column) => column);

  GeneratedColumn<String> get last4 =>
      $composableBuilder(column: $table.last4, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );
}

class $$PaymentCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentCardsTable,
          PaymentCard,
          $$PaymentCardsTableFilterComposer,
          $$PaymentCardsTableOrderingComposer,
          $$PaymentCardsTableAnnotationComposer,
          $$PaymentCardsTableCreateCompanionBuilder,
          $$PaymentCardsTableUpdateCompanionBuilder,
          (
            PaymentCard,
            BaseReferences<_$AppDatabase, $PaymentCardsTable, PaymentCard>,
          ),
          PaymentCard,
          PrefetchHooks Function()
        > {
  $$PaymentCardsTableTableManager(_$AppDatabase db, $PaymentCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> network = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String?> cardTier = const Value.absent(),
                Value<String?> last4 = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentCardsCompanion(
                id: id,
                network: network,
                bankName: bankName,
                cardTier: cardTier,
                last4: last4,
                nickname: nickname,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String network,
                required String bankName,
                Value<String?> cardTier = const Value.absent(),
                Value<String?> last4 = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentCardsCompanion.insert(
                id: id,
                network: network,
                bankName: bankName,
                cardTier: cardTier,
                last4: last4,
                nickname: nickname,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentCardsTable,
      PaymentCard,
      $$PaymentCardsTableFilterComposer,
      $$PaymentCardsTableOrderingComposer,
      $$PaymentCardsTableAnnotationComposer,
      $$PaymentCardsTableCreateCompanionBuilder,
      $$PaymentCardsTableUpdateCompanionBuilder,
      (
        PaymentCard,
        BaseReferences<_$AppDatabase, $PaymentCardsTable, PaymentCard>,
      ),
      PaymentCard,
      PrefetchHooks Function()
    >;
typedef $$ServiceTemplatesTableCreateCompanionBuilder =
    ServiceTemplatesCompanion Function({
      required String id,
      required String nameEn,
      required String nameAr,
      required String category,
      Value<double?> defaultAmount,
      required String defaultBillingCycle,
      Value<String> iconName,
      Value<bool> isBuiltIn,
      Value<String?> defaultCurrency,
      Value<int> rowid,
    });
typedef $$ServiceTemplatesTableUpdateCompanionBuilder =
    ServiceTemplatesCompanion Function({
      Value<String> id,
      Value<String> nameEn,
      Value<String> nameAr,
      Value<String> category,
      Value<double?> defaultAmount,
      Value<String> defaultBillingCycle,
      Value<String> iconName,
      Value<bool> isBuiltIn,
      Value<String?> defaultCurrency,
      Value<int> rowid,
    });

class $$ServiceTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceTemplatesTable> {
  $$ServiceTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultAmount => $composableBuilder(
    column: $table.defaultAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultBillingCycle => $composableBuilder(
    column: $table.defaultBillingCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceTemplatesTable> {
  $$ServiceTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultAmount => $composableBuilder(
    column: $table.defaultAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultBillingCycle => $composableBuilder(
    column: $table.defaultBillingCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceTemplatesTable> {
  $$ServiceTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get defaultAmount => $composableBuilder(
    column: $table.defaultAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultBillingCycle => $composableBuilder(
    column: $table.defaultBillingCycle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );
}

class $$ServiceTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceTemplatesTable,
          ServiceTemplate,
          $$ServiceTemplatesTableFilterComposer,
          $$ServiceTemplatesTableOrderingComposer,
          $$ServiceTemplatesTableAnnotationComposer,
          $$ServiceTemplatesTableCreateCompanionBuilder,
          $$ServiceTemplatesTableUpdateCompanionBuilder,
          (
            ServiceTemplate,
            BaseReferences<
              _$AppDatabase,
              $ServiceTemplatesTable,
              ServiceTemplate
            >,
          ),
          ServiceTemplate,
          PrefetchHooks Function()
        > {
  $$ServiceTemplatesTableTableManager(
    _$AppDatabase db,
    $ServiceTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double?> defaultAmount = const Value.absent(),
                Value<String> defaultBillingCycle = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<String?> defaultCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceTemplatesCompanion(
                id: id,
                nameEn: nameEn,
                nameAr: nameAr,
                category: category,
                defaultAmount: defaultAmount,
                defaultBillingCycle: defaultBillingCycle,
                iconName: iconName,
                isBuiltIn: isBuiltIn,
                defaultCurrency: defaultCurrency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameEn,
                required String nameAr,
                required String category,
                Value<double?> defaultAmount = const Value.absent(),
                required String defaultBillingCycle,
                Value<String> iconName = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<String?> defaultCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceTemplatesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameAr: nameAr,
                category: category,
                defaultAmount: defaultAmount,
                defaultBillingCycle: defaultBillingCycle,
                iconName: iconName,
                isBuiltIn: isBuiltIn,
                defaultCurrency: defaultCurrency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceTemplatesTable,
      ServiceTemplate,
      $$ServiceTemplatesTableFilterComposer,
      $$ServiceTemplatesTableOrderingComposer,
      $$ServiceTemplatesTableAnnotationComposer,
      $$ServiceTemplatesTableCreateCompanionBuilder,
      $$ServiceTemplatesTableUpdateCompanionBuilder,
      (
        ServiceTemplate,
        BaseReferences<_$AppDatabase, $ServiceTemplatesTable, ServiceTemplate>,
      ),
      ServiceTemplate,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$NotificationSchedulesTableCreateCompanionBuilder =
    NotificationSchedulesCompanion Function({
      required String id,
      required String commitmentId,
      required DateTime scheduledAt,
      required int notificationId,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$NotificationSchedulesTableUpdateCompanionBuilder =
    NotificationSchedulesCompanion Function({
      Value<String> id,
      Value<String> commitmentId,
      Value<DateTime> scheduledAt,
      Value<int> notificationId,
      Value<String> status,
      Value<int> rowid,
    });

class $$NotificationSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationSchedulesTable> {
  $$NotificationSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commitmentId => $composableBuilder(
    column: $table.commitmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationSchedulesTable> {
  $$NotificationSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commitmentId => $composableBuilder(
    column: $table.commitmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationSchedulesTable> {
  $$NotificationSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get commitmentId => $composableBuilder(
    column: $table.commitmentId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$NotificationSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationSchedulesTable,
          NotificationSchedule,
          $$NotificationSchedulesTableFilterComposer,
          $$NotificationSchedulesTableOrderingComposer,
          $$NotificationSchedulesTableAnnotationComposer,
          $$NotificationSchedulesTableCreateCompanionBuilder,
          $$NotificationSchedulesTableUpdateCompanionBuilder,
          (
            NotificationSchedule,
            BaseReferences<
              _$AppDatabase,
              $NotificationSchedulesTable,
              NotificationSchedule
            >,
          ),
          NotificationSchedule,
          PrefetchHooks Function()
        > {
  $$NotificationSchedulesTableTableManager(
    _$AppDatabase db,
    $NotificationSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSchedulesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationSchedulesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationSchedulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> commitmentId = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<int> notificationId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSchedulesCompanion(
                id: id,
                commitmentId: commitmentId,
                scheduledAt: scheduledAt,
                notificationId: notificationId,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String commitmentId,
                required DateTime scheduledAt,
                required int notificationId,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSchedulesCompanion.insert(
                id: id,
                commitmentId: commitmentId,
                scheduledAt: scheduledAt,
                notificationId: notificationId,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationSchedulesTable,
      NotificationSchedule,
      $$NotificationSchedulesTableFilterComposer,
      $$NotificationSchedulesTableOrderingComposer,
      $$NotificationSchedulesTableAnnotationComposer,
      $$NotificationSchedulesTableCreateCompanionBuilder,
      $$NotificationSchedulesTableUpdateCompanionBuilder,
      (
        NotificationSchedule,
        BaseReferences<
          _$AppDatabase,
          $NotificationSchedulesTable,
          NotificationSchedule
        >,
      ),
      NotificationSchedule,
      PrefetchHooks Function()
    >;
typedef $$SchemaMetaTableCreateCompanionBuilder =
    SchemaMetaCompanion Function({
      Value<int> version,
      required DateTime migratedAt,
    });
typedef $$SchemaMetaTableUpdateCompanionBuilder =
    SchemaMetaCompanion Function({
      Value<int> version,
      Value<DateTime> migratedAt,
    });

class $$SchemaMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SchemaMetaTable> {
  $$SchemaMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get migratedAt => $composableBuilder(
    column: $table.migratedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchemaMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SchemaMetaTable> {
  $$SchemaMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get migratedAt => $composableBuilder(
    column: $table.migratedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchemaMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchemaMetaTable> {
  $$SchemaMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get migratedAt => $composableBuilder(
    column: $table.migratedAt,
    builder: (column) => column,
  );
}

class $$SchemaMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchemaMetaTable,
          SchemaMetaData,
          $$SchemaMetaTableFilterComposer,
          $$SchemaMetaTableOrderingComposer,
          $$SchemaMetaTableAnnotationComposer,
          $$SchemaMetaTableCreateCompanionBuilder,
          $$SchemaMetaTableUpdateCompanionBuilder,
          (
            SchemaMetaData,
            BaseReferences<_$AppDatabase, $SchemaMetaTable, SchemaMetaData>,
          ),
          SchemaMetaData,
          PrefetchHooks Function()
        > {
  $$SchemaMetaTableTableManager(_$AppDatabase db, $SchemaMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchemaMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchemaMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchemaMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                Value<DateTime> migratedAt = const Value.absent(),
              }) =>
                  SchemaMetaCompanion(version: version, migratedAt: migratedAt),
          createCompanionCallback:
              ({
                Value<int> version = const Value.absent(),
                required DateTime migratedAt,
              }) => SchemaMetaCompanion.insert(
                version: version,
                migratedAt: migratedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchemaMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchemaMetaTable,
      SchemaMetaData,
      $$SchemaMetaTableFilterComposer,
      $$SchemaMetaTableOrderingComposer,
      $$SchemaMetaTableAnnotationComposer,
      $$SchemaMetaTableCreateCompanionBuilder,
      $$SchemaMetaTableUpdateCompanionBuilder,
      (
        SchemaMetaData,
        BaseReferences<_$AppDatabase, $SchemaMetaTable, SchemaMetaData>,
      ),
      SchemaMetaData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CommitmentsTableTableManager get commitments =>
      $$CommitmentsTableTableManager(_db, _db.commitments);
  $$PaymentCardsTableTableManager get paymentCards =>
      $$PaymentCardsTableTableManager(_db, _db.paymentCards);
  $$ServiceTemplatesTableTableManager get serviceTemplates =>
      $$ServiceTemplatesTableTableManager(_db, _db.serviceTemplates);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$NotificationSchedulesTableTableManager get notificationSchedules =>
      $$NotificationSchedulesTableTableManager(_db, _db.notificationSchedules);
  $$SchemaMetaTableTableManager get schemaMeta =>
      $$SchemaMetaTableTableManager(_db, _db.schemaMeta);
}
