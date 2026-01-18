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
