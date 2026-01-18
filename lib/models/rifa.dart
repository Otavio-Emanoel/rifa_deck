import 'enums.dart';

class Rifa {
  int? id;

  /// Título/Nome da rifa
  late String titulo;

  /// Descrição da rifa
  String? descricao;

  /// Quantidade total de bilhetes
  late int totalBilhetes;

  /// Valor de cada bilhete em reais
  late double valorBilhete;

  /// Status da rifa
  late RifaStatus status;

  /// ID do bilhete sorteado (se já realizado)
  int? bilheteSorteadoId;

  /// Data do sorteio
  DateTime? dataSorteio;

  /// Data de criação
  late DateTime dataCriacao;

  /// Data de atualização
  late DateTime dataAtualizacao;

  /// Observações/Notas
  String? observacoes;

  /// Calcula quantidade de bilhetes vendidos
  int get bilhetesVendidos => 0; // será calculado via query

  /// Calcula quantidade de bilhetes reservados
  int get bilhetesReservados => 0; // será calculado via query

  /// Calcula quantidade de bilhetes livres
  int get bilhetesLivres => totalBilhetes - bilhetesVendidos - bilhetesReservados;

  /// Calcula a porcentagem de venda
  double get percentualVenda => (bilhetesVendidos / totalBilhetes) * 100;

  /// Calcula a arrecadação total
  double get totalArrecadado => bilhetesVendidos * valorBilhete;

  @override
  String toString() => 'Rifa(titulo: $titulo, status: $status)';
}
