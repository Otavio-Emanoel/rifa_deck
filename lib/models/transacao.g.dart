// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacao.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransacaoCollection on Isar {
  IsarCollection<Transacao> get transacaos => this.collection();
}

const TransacaoSchema = CollectionSchema(
  name: r'Transacao',
  id: -4675131500292607103,
  properties: {
    r'bilhetesIds': PropertySchema(
      id: 0,
      name: r'bilhetesIds',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 1,
      name: r'data',
      type: IsarType.dateTime,
    ),
    r'descricao': PropertySchema(
      id: 2,
      name: r'descricao',
      type: IsarType.string,
    ),
    r'notas': PropertySchema(
      id: 3,
      name: r'notas',
      type: IsarType.string,
    ),
    r'participanteId': PropertySchema(
      id: 4,
      name: r'participanteId',
      type: IsarType.long,
    ),
    r'rifaId': PropertySchema(
      id: 5,
      name: r'rifaId',
      type: IsarType.long,
    ),
    r'tipo': PropertySchema(
      id: 6,
      name: r'tipo',
      type: IsarType.byte,
      enumMap: _TransacaotipoEnumValueMap,
    ),
    r'valor': PropertySchema(
      id: 7,
      name: r'valor',
      type: IsarType.double,
    )
  },
  estimateSize: _transacaoEstimateSize,
  serialize: _transacaoSerialize,
  deserialize: _transacaoDeserialize,
  deserializeProp: _transacaoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transacaoGetId,
  getLinks: _transacaoGetLinks,
  attach: _transacaoAttach,
  version: '3.1.0+1',
);

int _transacaoEstimateSize(
  Transacao object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bilhetesIds;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.descricao;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transacaoSerialize(
  Transacao object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bilhetesIds);
  writer.writeDateTime(offsets[1], object.data);
  writer.writeString(offsets[2], object.descricao);
  writer.writeString(offsets[3], object.notas);
  writer.writeLong(offsets[4], object.participanteId);
  writer.writeLong(offsets[5], object.rifaId);
  writer.writeByte(offsets[6], object.tipo.index);
  writer.writeDouble(offsets[7], object.valor);
}

Transacao _transacaoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Transacao();
  object.bilhetesIds = reader.readStringOrNull(offsets[0]);
  object.data = reader.readDateTime(offsets[1]);
  object.descricao = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.notas = reader.readStringOrNull(offsets[3]);
  object.participanteId = reader.readLong(offsets[4]);
  object.rifaId = reader.readLong(offsets[5]);
  object.tipo = _TransacaotipoValueEnumMap[reader.readByteOrNull(offsets[6])] ??
      TipoTransacao.venda;
  object.valor = reader.readDouble(offsets[7]);
  return object;
}

P _transacaoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_TransacaotipoValueEnumMap[reader.readByteOrNull(offset)] ??
          TipoTransacao.venda) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransacaotipoEnumValueMap = {
  'venda': 0,
  'reembolso': 1,
  'ajuste': 2,
};
const _TransacaotipoValueEnumMap = {
  0: TipoTransacao.venda,
  1: TipoTransacao.reembolso,
  2: TipoTransacao.ajuste,
};

Id _transacaoGetId(Transacao object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transacaoGetLinks(Transacao object) {
  return [];
}

void _transacaoAttach(IsarCollection<dynamic> col, Id id, Transacao object) {
  object.id = id;
}

extension TransacaoQueryWhereSort
    on QueryBuilder<Transacao, Transacao, QWhere> {
  QueryBuilder<Transacao, Transacao, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransacaoQueryWhere
    on QueryBuilder<Transacao, Transacao, QWhereClause> {
  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransacaoQueryFilter
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {
  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bilhetesIds',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bilhetesIds',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bilhetesIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bilhetesIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> bilhetesIdsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bilhetesIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilhetesIds',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      bilhetesIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bilhetesIds',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'data',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descricao',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      descricaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descricao',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      descricaoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descricao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descricao',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descricao',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> descricaoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      descricaoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      participanteIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participanteId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      participanteIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participanteId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      participanteIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participanteId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      participanteIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participanteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> rifaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rifaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> rifaIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rifaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> rifaIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rifaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> rifaIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rifaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoEqualTo(
      TipoTransacao value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoGreaterThan(
    TipoTransacao value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoLessThan(
    TipoTransacao value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoBetween(
    TipoTransacao lower,
    TipoTransacao upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension TransacaoQueryObject
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {}

extension TransacaoQueryLinks
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {}

extension TransacaoQuerySortBy on QueryBuilder<Transacao, Transacao, QSortBy> {
  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByBilhetesIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesIds', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByBilhetesIdsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesIds', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByParticipanteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByRifaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension TransacaoQuerySortThenBy
    on QueryBuilder<Transacao, Transacao, QSortThenBy> {
  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByBilhetesIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesIds', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByBilhetesIdsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesIds', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByParticipanteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByRifaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension TransacaoQueryWhereDistinct
    on QueryBuilder<Transacao, Transacao, QDistinct> {
  QueryBuilder<Transacao, Transacao, QDistinct> distinctByBilhetesIds(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bilhetesIds', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByDescricao(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descricao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participanteId');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rifaId');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor');
    });
  }
}

extension TransacaoQueryProperty
    on QueryBuilder<Transacao, Transacao, QQueryProperty> {
  QueryBuilder<Transacao, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Transacao, String?, QQueryOperations> bilhetesIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bilhetesIds');
    });
  }

  QueryBuilder<Transacao, DateTime, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<Transacao, String?, QQueryOperations> descricaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descricao');
    });
  }

  QueryBuilder<Transacao, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Transacao, int, QQueryOperations> participanteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participanteId');
    });
  }

  QueryBuilder<Transacao, int, QQueryOperations> rifaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rifaId');
    });
  }

  QueryBuilder<Transacao, TipoTransacao, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<Transacao, double, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }
}
