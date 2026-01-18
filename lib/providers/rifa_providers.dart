import 'package:riverpod/riverpod.dart';
import '../services/isar_service.dart';
import '../models/rifa.dart';
import '../models/enums.dart';

// Provider para o serviço Isar
final isarServiceProvider = Provider((ref) {
  return IsarService();
});

// Provider para inicializar o Isar
final isarInitProvider = FutureProvider((ref) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.initialize();
  return isarService;
});

// Provider para listar todas as rifas
final todasRifasProvider = FutureProvider((ref) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterTodasRifas();
});

// Provider para listar rifas ativas
final rifasAtivasProvider = FutureProvider((ref) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterRifasAtivas();
});

// Provider para criar uma nova rifa
final criarRifaProvider = FutureProvider.family<int, ({
  String titulo,
  String? descricao,
  int totalBilhetes,
  double valorBilhete,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.criarRifa(
    titulo: params.titulo,
    descricao: params.descricao,
    totalBilhetes: params.totalBilhetes,
    valorBilhete: params.valorBilhete,
  );
});

// Provider para obter uma rifa específica
final rifaPorIdProvider = FutureProvider.family<Rifa?, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterRifaPorId(rifaId);
});

// Provider para remover uma rifa
final removerRifaProvider = FutureProvider.family<void, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.removerRifa(rifaId);
});
