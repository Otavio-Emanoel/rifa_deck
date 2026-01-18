/// Status do bilhete na rifa
enum BilheteStatus {
  /// Ninguém comprou ainda
  livre,
  /// A pessoa disse que quer, mas não pagou (fiado)
  reservado,
  /// Pago e confirmado
  vendido,
}

/// Status da rifa
enum RifaStatus {
  /// Rifa em andamento
  ativa,
  /// Rifa finalizada/sorteio realizado
  finalizada,
  /// Rifa pausada
  pausada,
  /// Rifa cancelada
  cancelada,
}

/// Tipo de transação financeira
enum TipoTransacao {
  /// Pagamento de um bilhete
  venda,
  /// Reembolso
  reembolso,
  /// Ajuste manual
  ajuste,
}
