// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bilhete.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBilheteCollection on Isar {
  IsarCollection<Bilhete> get bilhetes => this.collection();
}

const BilheteSchema = CollectionSchema(
  name: r'Bilhete',
  id: -6641960496140827205,
  properties: {
    r'dataAtualizacao': PropertySchema(
      id: 0,
      name: r'dataAtualizacao',
      type: IsarType.dateTime,
    ),
    r'dataCriacao': PropertySchema(
      id: 1,
      name: r'dataCriacao',
      type: IsarType.dateTime,
    ),
    r'dataVenda': PropertySchema(
      id: 2,
      name: r'dataVenda',
      type: IsarType.dateTime,
    ),
    r'numero': PropertySchema(
      id: 3,
      name: r'numero',
      type: IsarType.long,
    ),
    r'observacoes': PropertySchema(
      id: 4,
      name: r'observacoes',
      type: IsarType.string,
    ),
    r'participanteId': PropertySchema(
      id: 5,
      name: r'participanteId',
      type: IsarType.long,
    ),
    r'rifaId': PropertySchema(
      id: 6,
      name: r'rifaId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.byte,
      enumMap: _BilhetestatusEnumValueMap,
    )
  },
  estimateSize: _bilheteEstimateSize,
  serialize: _bilheteSerialize,
  deserialize: _bilheteDeserialize,
  deserializeProp: _bilheteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bilheteGetId,
  getLinks: _bilheteGetLinks,
  attach: _bilheteAttach,
  version: '3.1.0+1',
);

int _bilheteEstimateSize(
  Bilhete object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.observacoes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _bilheteSerialize(
  Bilhete object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dataAtualizacao);
  writer.writeDateTime(offsets[1], object.dataCriacao);
  writer.writeDateTime(offsets[2], object.dataVenda);
  writer.writeLong(offsets[3], object.numero);
  writer.writeString(offsets[4], object.observacoes);
  writer.writeLong(offsets[5], object.participanteId);
  writer.writeLong(offsets[6], object.rifaId);
  writer.writeByte(offsets[7], object.status.index);
}

Bilhete _bilheteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Bilhete();
  object.dataAtualizacao = reader.readDateTime(offsets[0]);
  object.dataCriacao = reader.readDateTime(offsets[1]);
  object.dataVenda = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.numero = reader.readLong(offsets[3]);
  object.observacoes = reader.readStringOrNull(offsets[4]);
  object.participanteId = reader.readLongOrNull(offsets[5]);
  object.rifaId = reader.readLong(offsets[6]);
  object.status =
      _BilhetestatusValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          BilheteStatus.livre;
  return object;
}

P _bilheteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (_BilhetestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          BilheteStatus.livre) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BilhetestatusEnumValueMap = {
  'livre': 0,
  'reservado': 1,
  'vendido': 2,
};
const _BilhetestatusValueEnumMap = {
  0: BilheteStatus.livre,
  1: BilheteStatus.reservado,
  2: BilheteStatus.vendido,
};

Id _bilheteGetId(Bilhete object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bilheteGetLinks(Bilhete object) {
  return [];
}

void _bilheteAttach(IsarCollection<dynamic> col, Id id, Bilhete object) {
  object.id = id;
}

extension BilheteQueryWhereSort on QueryBuilder<Bilhete, Bilhete, QWhere> {
  QueryBuilder<Bilhete, Bilhete, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BilheteQueryWhere on QueryBuilder<Bilhete, Bilhete, QWhereClause> {
  QueryBuilder<Bilhete, Bilhete, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Bilhete, Bilhete, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterWhereClause> idBetween(
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

extension BilheteQueryFilter
    on QueryBuilder<Bilhete, Bilhete, QFilterCondition> {
  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataAtualizacaoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataAtualizacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition>
      dataAtualizacaoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataAtualizacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataAtualizacaoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataAtualizacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataAtualizacaoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataAtualizacao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataCriacaoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataCriacaoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataCriacaoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataCriacaoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataCriacao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataVenda',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataVenda',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataVenda',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataVenda',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataVenda',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> dataVendaBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataVenda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> numeroEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numero',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> numeroGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numero',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> numeroLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numero',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> numeroBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numero',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observacoes',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observacoes',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observacoes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'observacoes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'observacoes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> observacoesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacoes',
        value: '',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition>
      observacoesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observacoes',
        value: '',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> participanteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'participanteId',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition>
      participanteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'participanteId',
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> participanteIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participanteId',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition>
      participanteIdGreaterThan(
    int? value, {
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> participanteIdLessThan(
    int? value, {
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> participanteIdBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> rifaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rifaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> rifaIdGreaterThan(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> rifaIdLessThan(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> rifaIdBetween(
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

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> statusEqualTo(
      BilheteStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> statusGreaterThan(
    BilheteStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> statusLessThan(
    BilheteStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterFilterCondition> statusBetween(
    BilheteStatus lower,
    BilheteStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BilheteQueryObject
    on QueryBuilder<Bilhete, Bilhete, QFilterCondition> {}

extension BilheteQueryLinks
    on QueryBuilder<Bilhete, Bilhete, QFilterCondition> {}

extension BilheteQuerySortBy on QueryBuilder<Bilhete, Bilhete, QSortBy> {
  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataVenda', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByDataVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataVenda', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByParticipanteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByRifaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension BilheteQuerySortThenBy
    on QueryBuilder<Bilhete, Bilhete, QSortThenBy> {
  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataVenda', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByDataVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataVenda', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByNumeroDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numero', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByParticipanteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participanteId', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByRifaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rifaId', Sort.desc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension BilheteQueryWhereDistinct
    on QueryBuilder<Bilhete, Bilhete, QDistinct> {
  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataAtualizacao');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCriacao');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByDataVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataVenda');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByNumero() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numero');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByObservacoes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacoes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByParticipanteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participanteId');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByRifaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rifaId');
    });
  }

  QueryBuilder<Bilhete, Bilhete, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension BilheteQueryProperty
    on QueryBuilder<Bilhete, Bilhete, QQueryProperty> {
  QueryBuilder<Bilhete, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Bilhete, DateTime, QQueryOperations> dataAtualizacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataAtualizacao');
    });
  }

  QueryBuilder<Bilhete, DateTime, QQueryOperations> dataCriacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCriacao');
    });
  }

  QueryBuilder<Bilhete, DateTime?, QQueryOperations> dataVendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataVenda');
    });
  }

  QueryBuilder<Bilhete, int, QQueryOperations> numeroProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numero');
    });
  }

  QueryBuilder<Bilhete, String?, QQueryOperations> observacoesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacoes');
    });
  }

  QueryBuilder<Bilhete, int?, QQueryOperations> participanteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participanteId');
    });
  }

  QueryBuilder<Bilhete, int, QQueryOperations> rifaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rifaId');
    });
  }

  QueryBuilder<Bilhete, BilheteStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
