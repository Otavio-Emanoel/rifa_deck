// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rifa.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRifaCollection on Isar {
  IsarCollection<Rifa> get rifas => this.collection();
}

const RifaSchema = CollectionSchema(
  name: r'Rifa',
  id: -5588983099873711796,
  properties: {
    r'bilheteSorteadoId': PropertySchema(
      id: 0,
      name: r'bilheteSorteadoId',
      type: IsarType.long,
    ),
    r'bilhetesLivres': PropertySchema(
      id: 1,
      name: r'bilhetesLivres',
      type: IsarType.long,
    ),
    r'bilhetesReservados': PropertySchema(
      id: 2,
      name: r'bilhetesReservados',
      type: IsarType.long,
    ),
    r'bilhetesVendidos': PropertySchema(
      id: 3,
      name: r'bilhetesVendidos',
      type: IsarType.long,
    ),
    r'dataAtualizacao': PropertySchema(
      id: 4,
      name: r'dataAtualizacao',
      type: IsarType.dateTime,
    ),
    r'dataCriacao': PropertySchema(
      id: 5,
      name: r'dataCriacao',
      type: IsarType.dateTime,
    ),
    r'dataSorteio': PropertySchema(
      id: 6,
      name: r'dataSorteio',
      type: IsarType.dateTime,
    ),
    r'descricao': PropertySchema(
      id: 7,
      name: r'descricao',
      type: IsarType.string,
    ),
    r'observacoes': PropertySchema(
      id: 8,
      name: r'observacoes',
      type: IsarType.string,
    ),
    r'percentualVenda': PropertySchema(
      id: 9,
      name: r'percentualVenda',
      type: IsarType.double,
    ),
    r'status': PropertySchema(
      id: 10,
      name: r'status',
      type: IsarType.byte,
      enumMap: _RifastatusEnumValueMap,
    ),
    r'titulo': PropertySchema(
      id: 11,
      name: r'titulo',
      type: IsarType.string,
    ),
    r'totalArrecadado': PropertySchema(
      id: 12,
      name: r'totalArrecadado',
      type: IsarType.double,
    ),
    r'totalBilhetes': PropertySchema(
      id: 13,
      name: r'totalBilhetes',
      type: IsarType.long,
    ),
    r'valorBilhete': PropertySchema(
      id: 14,
      name: r'valorBilhete',
      type: IsarType.double,
    )
  },
  estimateSize: _rifaEstimateSize,
  serialize: _rifaSerialize,
  deserialize: _rifaDeserialize,
  deserializeProp: _rifaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _rifaGetId,
  getLinks: _rifaGetLinks,
  attach: _rifaAttach,
  version: '3.1.0+1',
);

int _rifaEstimateSize(
  Rifa object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descricao;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.observacoes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _rifaSerialize(
  Rifa object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bilheteSorteadoId);
  writer.writeLong(offsets[1], object.bilhetesLivres);
  writer.writeLong(offsets[2], object.bilhetesReservados);
  writer.writeLong(offsets[3], object.bilhetesVendidos);
  writer.writeDateTime(offsets[4], object.dataAtualizacao);
  writer.writeDateTime(offsets[5], object.dataCriacao);
  writer.writeDateTime(offsets[6], object.dataSorteio);
  writer.writeString(offsets[7], object.descricao);
  writer.writeString(offsets[8], object.observacoes);
  writer.writeDouble(offsets[9], object.percentualVenda);
  writer.writeByte(offsets[10], object.status.index);
  writer.writeString(offsets[11], object.titulo);
  writer.writeDouble(offsets[12], object.totalArrecadado);
  writer.writeLong(offsets[13], object.totalBilhetes);
  writer.writeDouble(offsets[14], object.valorBilhete);
}

Rifa _rifaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Rifa();
  object.bilheteSorteadoId = reader.readLongOrNull(offsets[0]);
  object.dataAtualizacao = reader.readDateTime(offsets[4]);
  object.dataCriacao = reader.readDateTime(offsets[5]);
  object.dataSorteio = reader.readDateTimeOrNull(offsets[6]);
  object.descricao = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.observacoes = reader.readStringOrNull(offsets[8]);
  object.status = _RifastatusValueEnumMap[reader.readByteOrNull(offsets[10])] ??
      RifaStatus.ativa;
  object.titulo = reader.readString(offsets[11]);
  object.totalBilhetes = reader.readLong(offsets[13]);
  object.valorBilhete = reader.readDouble(offsets[14]);
  return object;
}

P _rifaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (_RifastatusValueEnumMap[reader.readByteOrNull(offset)] ??
          RifaStatus.ativa) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RifastatusEnumValueMap = {
  'ativa': 0,
  'finalizada': 1,
  'pausada': 2,
  'cancelada': 3,
};
const _RifastatusValueEnumMap = {
  0: RifaStatus.ativa,
  1: RifaStatus.finalizada,
  2: RifaStatus.pausada,
  3: RifaStatus.cancelada,
};

Id _rifaGetId(Rifa object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rifaGetLinks(Rifa object) {
  return [];
}

void _rifaAttach(IsarCollection<dynamic> col, Id id, Rifa object) {
  object.id = id;
}

extension RifaQueryWhereSort on QueryBuilder<Rifa, Rifa, QWhere> {
  QueryBuilder<Rifa, Rifa, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RifaQueryWhere on QueryBuilder<Rifa, Rifa, QWhereClause> {
  QueryBuilder<Rifa, Rifa, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Rifa, Rifa, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterWhereClause> idBetween(
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

extension RifaQueryFilter on QueryBuilder<Rifa, Rifa, QFilterCondition> {
  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bilheteSorteadoId',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bilheteSorteadoId',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilheteSorteadoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bilheteSorteadoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bilheteSorteadoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilheteSorteadoIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bilheteSorteadoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesLivresEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilhetesLivres',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesLivresGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bilhetesLivres',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesLivresLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bilhetesLivres',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesLivresBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bilhetesLivres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesReservadosEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilhetesReservados',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesReservadosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bilhetesReservados',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesReservadosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bilhetesReservados',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesReservadosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bilhetesReservados',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesVendidosEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bilhetesVendidos',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesVendidosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bilhetesVendidos',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesVendidosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bilhetesVendidos',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> bilhetesVendidosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bilhetesVendidos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataAtualizacaoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataAtualizacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataAtualizacaoGreaterThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataAtualizacaoLessThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataAtualizacaoBetween(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataCriacaoEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataCriacaoGreaterThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataCriacaoLessThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataCriacaoBetween(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataSorteio',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataSorteio',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataSorteio',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataSorteio',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataSorteio',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> dataSorteioBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataSorteio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descricao',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descricao',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoEqualTo(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoGreaterThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoLessThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoBetween(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoStartsWith(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoEndsWith(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoContains(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoMatches(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> descricaoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descricao',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'observacoes',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'observacoes',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesEqualTo(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesGreaterThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesLessThan(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesBetween(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesStartsWith(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesEndsWith(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesContains(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesMatches(
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observacoes',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> observacoesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'observacoes',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> percentualVendaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentualVenda',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> percentualVendaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentualVenda',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> percentualVendaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentualVenda',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> percentualVendaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentualVenda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> statusEqualTo(
      RifaStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> statusGreaterThan(
    RifaStatus value, {
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> statusLessThan(
    RifaStatus value, {
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> statusBetween(
    RifaStatus lower,
    RifaStatus upper, {
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

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalArrecadadoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalArrecadado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalArrecadadoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalArrecadado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalArrecadadoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalArrecadado',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalArrecadadoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalArrecadado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalBilhetesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalBilhetes',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalBilhetesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalBilhetes',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalBilhetesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalBilhetes',
        value: value,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> totalBilhetesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalBilhetes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> valorBilheteEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorBilhete',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> valorBilheteGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorBilhete',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> valorBilheteLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorBilhete',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterFilterCondition> valorBilheteBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorBilhete',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension RifaQueryObject on QueryBuilder<Rifa, Rifa, QFilterCondition> {}

extension RifaQueryLinks on QueryBuilder<Rifa, Rifa, QFilterCondition> {}

extension RifaQuerySortBy on QueryBuilder<Rifa, Rifa, QSortBy> {
  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilheteSorteadoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilheteSorteadoId', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilheteSorteadoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilheteSorteadoId', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesLivres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesLivres', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesLivresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesLivres', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesReservados() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesReservados', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesReservadosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesReservados', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesVendidos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesVendidos', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByBilhetesVendidosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesVendidos', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataSorteio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSorteio', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDataSorteioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSorteio', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByPercentualVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentualVenda', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByPercentualVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentualVenda', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTotalArrecadado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalArrecadado', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTotalArrecadadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalArrecadado', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTotalBilhetes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBilhetes', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByTotalBilhetesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBilhetes', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByValorBilhete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorBilhete', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> sortByValorBilheteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorBilhete', Sort.desc);
    });
  }
}

extension RifaQuerySortThenBy on QueryBuilder<Rifa, Rifa, QSortThenBy> {
  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilheteSorteadoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilheteSorteadoId', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilheteSorteadoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilheteSorteadoId', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesLivres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesLivres', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesLivresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesLivres', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesReservados() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesReservados', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesReservadosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesReservados', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesVendidos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesVendidos', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByBilhetesVendidosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bilhetesVendidos', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataSorteio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSorteio', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDataSorteioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSorteio', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByObservacoes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByObservacoesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observacoes', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByPercentualVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentualVenda', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByPercentualVendaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentualVenda', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTotalArrecadado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalArrecadado', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTotalArrecadadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalArrecadado', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTotalBilhetes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBilhetes', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByTotalBilhetesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBilhetes', Sort.desc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByValorBilhete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorBilhete', Sort.asc);
    });
  }

  QueryBuilder<Rifa, Rifa, QAfterSortBy> thenByValorBilheteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorBilhete', Sort.desc);
    });
  }
}

extension RifaQueryWhereDistinct on QueryBuilder<Rifa, Rifa, QDistinct> {
  QueryBuilder<Rifa, Rifa, QDistinct> distinctByBilheteSorteadoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bilheteSorteadoId');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByBilhetesLivres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bilhetesLivres');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByBilhetesReservados() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bilhetesReservados');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByBilhetesVendidos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bilhetesVendidos');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataAtualizacao');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCriacao');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByDataSorteio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataSorteio');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByDescricao(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descricao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByObservacoes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observacoes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByPercentualVenda() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'percentualVenda');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByTotalArrecadado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalArrecadado');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByTotalBilhetes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalBilhetes');
    });
  }

  QueryBuilder<Rifa, Rifa, QDistinct> distinctByValorBilhete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorBilhete');
    });
  }
}

extension RifaQueryProperty on QueryBuilder<Rifa, Rifa, QQueryProperty> {
  QueryBuilder<Rifa, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Rifa, int?, QQueryOperations> bilheteSorteadoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bilheteSorteadoId');
    });
  }

  QueryBuilder<Rifa, int, QQueryOperations> bilhetesLivresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bilhetesLivres');
    });
  }

  QueryBuilder<Rifa, int, QQueryOperations> bilhetesReservadosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bilhetesReservados');
    });
  }

  QueryBuilder<Rifa, int, QQueryOperations> bilhetesVendidosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bilhetesVendidos');
    });
  }

  QueryBuilder<Rifa, DateTime, QQueryOperations> dataAtualizacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataAtualizacao');
    });
  }

  QueryBuilder<Rifa, DateTime, QQueryOperations> dataCriacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCriacao');
    });
  }

  QueryBuilder<Rifa, DateTime?, QQueryOperations> dataSorteioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataSorteio');
    });
  }

  QueryBuilder<Rifa, String?, QQueryOperations> descricaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descricao');
    });
  }

  QueryBuilder<Rifa, String?, QQueryOperations> observacoesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observacoes');
    });
  }

  QueryBuilder<Rifa, double, QQueryOperations> percentualVendaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percentualVenda');
    });
  }

  QueryBuilder<Rifa, RifaStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Rifa, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }

  QueryBuilder<Rifa, double, QQueryOperations> totalArrecadadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalArrecadado');
    });
  }

  QueryBuilder<Rifa, int, QQueryOperations> totalBilhetesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalBilhetes');
    });
  }

  QueryBuilder<Rifa, double, QQueryOperations> valorBilheteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorBilhete');
    });
  }
}
