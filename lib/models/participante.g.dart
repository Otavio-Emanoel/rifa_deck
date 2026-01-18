// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participante.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetParticipanteCollection on Isar {
  IsarCollection<Participante> get participantes => this.collection();
}

const ParticipanteSchema = CollectionSchema(
  name: r'Participante',
  id: 5998819293470135310,
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
    r'email': PropertySchema(
      id: 2,
      name: r'email',
      type: IsarType.string,
    ),
    r'nome': PropertySchema(
      id: 3,
      name: r'nome',
      type: IsarType.string,
    ),
    r'notas': PropertySchema(
      id: 4,
      name: r'notas',
      type: IsarType.string,
    ),
    r'telefone': PropertySchema(
      id: 5,
      name: r'telefone',
      type: IsarType.string,
    ),
    r'valorDevendo': PropertySchema(
      id: 6,
      name: r'valorDevendo',
      type: IsarType.double,
    ),
    r'valorPago': PropertySchema(
      id: 7,
      name: r'valorPago',
      type: IsarType.double,
    )
  },
  estimateSize: _participanteEstimateSize,
  serialize: _participanteSerialize,
  deserialize: _participanteDeserialize,
  deserializeProp: _participanteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _participanteGetId,
  getLinks: _participanteGetLinks,
  attach: _participanteAttach,
  version: '3.1.0+1',
);

int _participanteEstimateSize(
  Participante object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nome.length * 3;
  {
    final value = object.notas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.telefone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _participanteSerialize(
  Participante object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dataAtualizacao);
  writer.writeDateTime(offsets[1], object.dataCriacao);
  writer.writeString(offsets[2], object.email);
  writer.writeString(offsets[3], object.nome);
  writer.writeString(offsets[4], object.notas);
  writer.writeString(offsets[5], object.telefone);
  writer.writeDouble(offsets[6], object.valorDevendo);
  writer.writeDouble(offsets[7], object.valorPago);
}

Participante _participanteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Participante();
  object.dataAtualizacao = reader.readDateTime(offsets[0]);
  object.dataCriacao = reader.readDateTime(offsets[1]);
  object.email = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.nome = reader.readString(offsets[3]);
  object.notas = reader.readStringOrNull(offsets[4]);
  object.telefone = reader.readStringOrNull(offsets[5]);
  object.valorDevendo = reader.readDoubleOrNull(offsets[6]);
  object.valorPago = reader.readDoubleOrNull(offsets[7]);
  return object;
}

P _participanteDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _participanteGetId(Participante object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _participanteGetLinks(Participante object) {
  return [];
}

void _participanteAttach(
    IsarCollection<dynamic> col, Id id, Participante object) {
  object.id = id;
}

extension ParticipanteQueryWhereSort
    on QueryBuilder<Participante, Participante, QWhere> {
  QueryBuilder<Participante, Participante, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ParticipanteQueryWhere
    on QueryBuilder<Participante, Participante, QWhereClause> {
  QueryBuilder<Participante, Participante, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Participante, Participante, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Participante, Participante, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Participante, Participante, QAfterWhereClause> idBetween(
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

extension ParticipanteQueryFilter
    on QueryBuilder<Participante, Participante, QFilterCondition> {
  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataAtualizacaoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataAtualizacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataAtualizacaoLessThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataAtualizacaoBetween(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataCriacaoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataCriacaoGreaterThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataCriacaoLessThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      dataCriacaoBetween(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> nomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasEqualTo(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasGreaterThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasLessThan(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasBetween(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasStartsWith(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasEndsWith(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasContains(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition> notasMatches(
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

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'telefone',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'telefone',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'telefone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'telefone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'telefone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'telefone',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      telefoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'telefone',
        value: '',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valorDevendo',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valorDevendo',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorDevendo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorDevendo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorDevendo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorDevendoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorDevendo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valorPago',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valorPago',
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valorPago',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valorPago',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valorPago',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Participante, Participante, QAfterFilterCondition>
      valorPagoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valorPago',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ParticipanteQueryObject
    on QueryBuilder<Participante, Participante, QFilterCondition> {}

extension ParticipanteQueryLinks
    on QueryBuilder<Participante, Participante, QFilterCondition> {}

extension ParticipanteQuerySortBy
    on QueryBuilder<Participante, Participante, QSortBy> {
  QueryBuilder<Participante, Participante, QAfterSortBy>
      sortByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      sortByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      sortByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByTelefone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByTelefoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByValorDevendo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorDevendo', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      sortByValorDevendoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorDevendo', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByValorPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPago', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> sortByValorPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPago', Sort.desc);
    });
  }
}

extension ParticipanteQuerySortThenBy
    on QueryBuilder<Participante, Participante, QSortThenBy> {
  QueryBuilder<Participante, Participante, QAfterSortBy>
      thenByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      thenByDataAtualizacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAtualizacao', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      thenByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByTelefone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByTelefoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'telefone', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByValorDevendo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorDevendo', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy>
      thenByValorDevendoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorDevendo', Sort.desc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByValorPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPago', Sort.asc);
    });
  }

  QueryBuilder<Participante, Participante, QAfterSortBy> thenByValorPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valorPago', Sort.desc);
    });
  }
}

extension ParticipanteQueryWhereDistinct
    on QueryBuilder<Participante, Participante, QDistinct> {
  QueryBuilder<Participante, Participante, QDistinct>
      distinctByDataAtualizacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataAtualizacao');
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCriacao');
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByTelefone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'telefone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByValorDevendo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorDevendo');
    });
  }

  QueryBuilder<Participante, Participante, QDistinct> distinctByValorPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valorPago');
    });
  }
}

extension ParticipanteQueryProperty
    on QueryBuilder<Participante, Participante, QQueryProperty> {
  QueryBuilder<Participante, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Participante, DateTime, QQueryOperations>
      dataAtualizacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataAtualizacao');
    });
  }

  QueryBuilder<Participante, DateTime, QQueryOperations> dataCriacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCriacao');
    });
  }

  QueryBuilder<Participante, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<Participante, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Participante, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Participante, String?, QQueryOperations> telefoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'telefone');
    });
  }

  QueryBuilder<Participante, double?, QQueryOperations> valorDevendoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorDevendo');
    });
  }

  QueryBuilder<Participante, double?, QQueryOperations> valorPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valorPago');
    });
  }
}
