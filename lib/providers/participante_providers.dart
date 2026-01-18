import 'package:riverpod/riverpod.dart';
import '../services/isar_service.dart';
import '../models/participante.dart';
import 'rifa_providers.dart';

// Provider para listar todos os participantes
final todosParticipantesProvider = FutureProvider((ref) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterTodosParticipantes();
});

// Provider para obter um participante específico
final participantePorIdProvider = FutureProvider.family<Participante?, int>((ref, participanteId) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterParticipantePorId(participanteId);
});

// Provider para criar um novo participante
final criarParticipanteProvider = FutureProvider.family<int, ({
  String nome,
  String? telefone,
  String? email,
  String? notas,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.criarParticipante(
    nome: params.nome,
    telefone: params.telefone,
    email: params.email,
    notas: params.notas,
  );
});
/// Modelo simples para participante com bilhetes
class ParticipanteComBilhetes {
  final int id;
  final String nome;
  final String? telefone;
  final List<int> numeroBilhetes;
  final List<String> statusBilhetes;

  ParticipanteComBilhetes({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.numeroBilhetes,
    required this.statusBilhetes,
  });

  bool get temPendente => statusBilhetes.contains('reservado');
  bool get todosPagos => !temPendente;

  String get descricao {
    final qtd = numeroBilhetes.length;
    final status = todosPagos ? 'Pago' : 'Pendente';
    final numeros = numeroBilhetes.join(', ');
    return 'Bilhetes: $numeros ($status)';
  }
}

/// Provider para listar participantes de uma rifa com seus bilhetes
final participantesRifaProvider =
    FutureProvider.family<List<ParticipanteComBilhetes>, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  final rawData = await isarService.obterParticipantesRifaComBilhetes(rifaId);

  return rawData.map((row) {
    final numerosStr = (row['bilhete_numeros'] as String).split(',');
    final statusesStr = (row['bilhete_statuses'] as String).split(',');
    final numeros = numerosStr.map((n) => int.parse(n.trim())).toList();

    return ParticipanteComBilhetes(
      id: row['id'] as int,
      nome: row['nome'] as String,
      telefone: row['telefone'] as String?,
      numeroBilhetes: numeros,
      statusBilhetes: statusesStr,
    );
  }).toList();
});

/// Provider para atualizar participante como pago
final marcarParticipantePagoProvider = FutureProvider.family<void, int>((ref, participanteId) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.marcarParticipantePago(participanteId);
});

/// Provider para atualizar dados do participante (nome e telefone)
final atualizarParticipanteProvider = FutureProvider.family<void, ({
  int id,
  String nome,
  String? telefone,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  final participante = Participante()
    ..id = params.id
    ..nome = params.nome
    ..telefone = params.telefone;
  await isarService.atualizarParticipante(participante);
});

/// Provider para adicionar bilhetes a um participante
final adicionarBilhetesAoParticipanteProvider = FutureProvider.family<void, ({
  int rifaId,
  int participanteId,
  List<int> numerosBilhetes,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.atualizarBilhetesCheckout(
    rifaId: params.rifaId,
    participanteId: params.participanteId,
    numerosBilhetes: params.numerosBilhetes,
    status: 'vendido',
  );
});

/// Provider para remover bilhetes de um participante
final removerBilhetesDoParticipanteProvider = FutureProvider.family<void, ({
  List<int> bilheteIds,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.limparParticipanteDeBilhetes(params.bilheteIds);
});