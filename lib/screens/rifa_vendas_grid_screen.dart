import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bilhete.dart';
import '../models/enums.dart';
import '../providers/bilhete_providers.dart';
import '../providers/rifa_providers.dart';
import '../providers/selection_providers.dart';

class RifaVendasGridScreen extends ConsumerWidget {
  final int rifaId;
  final String? titulo;

  const RifaVendasGridScreen({super.key, required this.rifaId, this.titulo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bilhetesAsync = ref.watch(bilhetesRifaProvider(rifaId));
    final rifaAsync = ref.watch(rifaPorIdProvider(rifaId));
    final selecionados = ref.watch(selecionadosProvider(rifaId));

    return Scaffold(
      appBar: AppBar(
        title: rifaAsync.when(
          data: (rifa) => Text(rifa?.titulo ?? titulo ?? 'Rifa'),
          loading: () => Text(titulo ?? 'Rifa'),
          error: (_, __) => const Text('Rifa'),
        ),
      ),
      body: SafeArea(
        child: bilhetesAsync.when(
          data: (bilhetes) {
            return Column(
              children: [
                _Resumo(bilhetes: bilhetes),
                const SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _BilhetesGrid(
                      bilhetes: bilhetes,
                      selecionados: selecionados,
                      onToggle: (numero) {
                        final bilhete = bilhetes.firstWhere((b) => b.numero == numero);
                        if (bilhete.status != BilheteStatus.livre) return;
                        ref.read(selecionadosProvider(rifaId).notifier).toggle(numero);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Erro ao carregar bilhetes: $err')),
        ),
      ),
      bottomNavigationBar: rifaAsync.when(
        data: (rifa) {
          if (rifa == null || selecionados.isEmpty) return const SizedBox.shrink();
          final total = selecionados.length * rifa.valorBilhete;
          return _BottomVendaBar(
            quantidade: selecionados.length,
            total: total,
            onLimpar: () => ref.read(selecionadosProvider(rifaId).notifier).clear(),
            onVender: () {
              // TODO: integrar fluxo de venda/participante
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Vender ${selecionados.length} números (R\$ ${total.toStringAsFixed(2)})')),
              );
            },
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}

class _Resumo extends StatelessWidget {
  final List<Bilhete> bilhetes;
  const _Resumo({required this.bilhetes});

  @override
  Widget build(BuildContext context) {
    final livres = bilhetes.where((b) => b.status == BilheteStatus.livre).length;
    final vendidos = bilhetes.where((b) => b.status == BilheteStatus.vendido).length;
    final reservados = bilhetes.where((b) => b.status == BilheteStatus.reservado).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          _Chip(label: 'Livres', value: livres, color: Colors.grey.shade200, textColor: Colors.black87),
          const SizedBox(width: 8),
          _Chip(label: 'Vendidos', value: vendidos, color: Colors.green.shade100, textColor: Colors.green.shade900),
          const SizedBox(width: 8),
          _Chip(label: 'Reservados', value: reservados, color: Colors.amber.shade100, textColor: Colors.orange.shade900),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final Color textColor;
  const _Chip({required this.label, required this.value, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor)),
          const SizedBox(width: 6),
          Text('$value', style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}

class _BilhetesGrid extends StatelessWidget {
  final List<Bilhete> bilhetes;
  final Set<int> selecionados;
  final ValueChanged<int> onToggle;

  const _BilhetesGrid({required this.bilhetes, required this.selecionados, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const crossAxisCount = 5;
    return GridView.builder(
      itemCount: bilhetes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final bilhete = bilhetes[index];
        final selected = selecionados.contains(bilhete.numero);
        final colors = _tileColors(colorScheme, bilhete.status, selected);
        return GestureDetector(
          onTap: () => onToggle(bilhete.numero),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colors.border, width: 1.5),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: colors.border.withOpacity(.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                bilhete.numero.toString().padLeft(3, '0'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.foreground,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TileColors {
  final Color background;
  final Color border;
  final Color foreground;
  const _TileColors({required this.background, required this.border, required this.foreground});
}

_TileColors _tileColors(ColorScheme colorScheme, BilheteStatus status, bool selected) {
  if (status == BilheteStatus.vendido) {
    return _TileColors(
      background: Colors.green.shade100,
      border: Colors.green.shade600,
      foreground: Colors.green.shade900,
    );
  }
  if (status == BilheteStatus.reservado) {
    return _TileColors(
      background: Colors.amber.shade100,
      border: Colors.amber.shade700,
      foreground: Colors.amber.shade900,
    );
  }
  if (selected) {
    return _TileColors(
      background: colorScheme.primary.withOpacity(.15),
      border: colorScheme.primary,
      foreground: colorScheme.primary,
    );
  }
  return _TileColors(
    background: Colors.grey.shade100,
    border: Colors.grey.shade300,
    foreground: Colors.grey.shade800,
  );
}

class _BottomVendaBar extends StatelessWidget {
  final int quantidade;
  final double total;
  final VoidCallback onLimpar;
  final VoidCallback onVender;

  const _BottomVendaBar({
    required this.quantidade,
    required this.total,
    required this.onLimpar,
    required this.onVender,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Material(
        elevation: 8,
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Vender $quantidade números',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: onLimpar, child: const Text('Limpar')),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onVender,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text('Vender'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
