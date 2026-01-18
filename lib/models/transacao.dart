import 'enums.dart';

class Transacao {
  int? id;

  /// ID da rifa
  late int rifaId;

  /// ID do participante
  late int participanteId;

  /// Tipo de transação
  late TipoTransacao tipo;

  /// Valor da transação
  late double valor;

  /// Descrição da transação
  String? descricao;

  /// Data da transação
  late DateTime data;

  /// IDs dos bilhetes envolvidos (separados por vírgula)
  String? bilhetesIds;

  /// Notas da transação
  String? notas;

  @override
  String toString() => 'Transacao(tipo: $tipo, valor: $valor)';
}
