import 'package:riverpod/riverpod.dart';
import '../services/isar_service.dart';
import '../models/bilhete.dart';
import 'rifa_providers.dart';

// Provider para obter bilhetes de uma rifa
final bilhetesRifaProvider = FutureProvider.family<List<Bilhete>, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterBilhetesRifa(rifaId);
});

final bilhetesVendidosProvider = FutureProvider.family<List<Bilhete>, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterBilhetesVendidos(rifaId);
});

final bilhetesReservadosProvider = FutureProvider.family<List<Bilhete>, int>((ref, rifaId) async {
  final isarService = ref.watch(isarServiceProvider);
  return await isarService.obterBilhetesReservados(rifaId);
});

// Provider para vender bilhetes
final venderBilhetesProvider = FutureProvider.family<void, ({
  int rifaId,
  int participanteId,
  List<int> numerosBilhetes,
  double totalPago,
})>((ref, params) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.venderBilhetes(
    rifaId: params.rifaId,
    participanteId: params.participanteId,
    numerosBilhetes: params.numerosBilhetes,
    totalPago: params.totalPago,
  );
  // Invalida o cache para recarregar
  ref.invalidate(bilhetesRifaProvider(params.rifaId));
  ref.invalidate(bilhetesVendidosProvider(params.rifaId));
});
