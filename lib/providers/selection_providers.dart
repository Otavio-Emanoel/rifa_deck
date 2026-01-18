import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Guarda a seleção temporária de bilhetes (números) por rifa.
final selecionadosProvider =
    StateNotifierProvider.autoDispose.family<_SelecionadosNotifier, Set<int>, int>(
  (ref, rifaId) => _SelecionadosNotifier(),
);

class _SelecionadosNotifier extends StateNotifier<Set<int>> {
  _SelecionadosNotifier() : super(<int>{});

  void toggle(int numero) {
    final next = Set<int>.from(state);
    if (next.contains(numero)) {
      next.remove(numero);
    } else {
      next.add(numero);
    }
    state = next;
  }

  void clear() {
    state = <int>{};
  }
}
