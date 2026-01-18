class Participante {
  int? id;

  /// Nome do participante
  late String nome;

  /// Telefone (WhatsApp, etc)
  String? telefone;

  /// Email
  String? email;

  /// Total em reais que deve (bilhetes reservados não pagos)
  double? valorDevendo = 0.0;

  /// Total em reais que pagou
  double? valorPago = 0.0;

  /// Data de criação
  late DateTime dataCriacao;

  /// Data de atualização
  late DateTime dataAtualizacao;

  /// Notas do participante
  String? notas;

  @override
  String toString() => 'Participante(nome: $nome)';
}
