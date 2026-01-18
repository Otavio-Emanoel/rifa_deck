import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';
import '../providers/bilhete_providers.dart';
import '../widgets/rifa_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rifasAsync = ref.watch(rifasAtivasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎟️ Rifa_Deck'),
        elevation: 0,
      ),
      body: rifasAsync.when(
        data: (rifas) {
          if (rifas.isEmpty) {
            return _EmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: rifas.length,
            itemBuilder: (context, index) {
              final rifa = rifas[index];

              // Busca dados de bilhetes para este card
              return _RifaCardWithData(rifa: rifa);
            },
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Erro ao carregar rifas'),
                const SizedBox(height: 8),
                Text(error.toString()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navegar para tela de criar rifa
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Funcionalidade em desenvolvimento')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nova Rifa'),
      ),
    );
  }
}

class _RifaCardWithData extends ConsumerWidget {
  final rifa;

  const _RifaCardWithData({required this.rifa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bilhetesAsync = ref.watch(bilhetesRifaProvider(rifa.id));
    final bilhetesVendidosAsync = ref.watch(bilhetesVendidosProvider(rifa.id));
    final bilhetesReservadosAsync = ref.watch(bilhetesReservadosProvider(rifa.id));

    return bilhetesVendidosAsync.when(
      data: (bilhetesVendidos) {
        return bilhetesReservadosAsync.when(
          data: (bilhetesReservados) {
            return RifaCard(
              rifa: rifa,
              bilhetesVendidos: bilhetesVendidos.length,
              bilhetesReservados: bilhetesReservados.length,
              onTapAcao: () {
                // TODO: Navegar para tela de venda de bilhetes
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Abrindo venda para ${rifa.titulo}')),
                );
              },
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma rifa criada',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crie sua primeira rifa para começar',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }
}
