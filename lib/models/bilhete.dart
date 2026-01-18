import 'enums.dart';

class Bilhete {
  int? id;

  /// ID da rifa a qual pertence
  late int rifaId;

  /// Número do bilhete (ex: 001, 042)
  late int numero;

  /// Status do bilhete
  late BilheteStatus status;

  /// ID do participante (se já vendido/reservado)
  int? participanteId;

  /// Data e hora da venda
  DateTime? dataVenda;

  /// Observações
  String? observacoes;

  /// Data de criação
  late DateTime dataCriacao;

  /// Data de atualização
  late DateTime dataAtualizacao;

  @override
  String toString() => 'Bilhete(numero: $numero, status: $status)';
}
