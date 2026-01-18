import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';
import '../providers/bilhete_providers.dart';
import '../widgets/rifa_card.dart';
import 'create_rifa_screen.dart';
import 'rifa_vendas_grid_screen.dart';
import 'participantes_list_screen.dart';
import 'sorteio_screen.dart';
import 'relatorios_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rifasAsync = ref.watch(rifasAtivasProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            rifasAsync.when(
              data: (rifas) {
                return CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: _HomeHeader()),
                    if (rifas.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyState(),
                      )
                    else ...[
                      const SliverToBoxAdapter(child: _QuickActions()),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final rifa = rifas[index];
                            return _RifaCardWithData(rifa: rifa);
                          },
                          childCount: rifas.length,
                        ),
                      ),
                    ],
                  ],
                );
              },
              loading: () {
                return const Center(
                  child: _GradientLoading(),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateRifaScreen()),
          );
          if (created == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rifa criada!')),
            );
          }
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RifaVendasGridScreen(
                      rifaId: rifa.id!,
                      titulo: rifa.titulo,
                    ),
                  ),
                );
              },
              onTapCompradores: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ParticipantesListScreen(
                      rifaId: rifa.id!,
                      rifaTitulo: rifa.titulo,
                    ),
                  ),
                );
              },
              onTapSorteio: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SorteioScreen(
                      rifaId: rifa.id!,
                      rifaTitulo: rifa.titulo,
                    ),
                  ),
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
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(.8),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.auto_awesome_motion,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'Nenhuma rifa criada',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Comece uma campanha em segundos e acompanhe vendas em tempo real.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateRifaScreen()),
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Criar primeira rifa'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(.12),
                  colorScheme.secondary.withOpacity(.12),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: colorScheme.surfaceVariant,
                          child: Icon(
                            Icons.local_activity,
                            color: colorScheme.primary,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RifaDeck',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Sua central de rifas com vendas, reservas e sorteios inteligentes.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[1000]?.withOpacity(0.75),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _HeaderStats(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _HeaderStats extends ConsumerWidget {
  const _HeaderStats();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rifasAsync = ref.watch(rifasAtivasProvider);

    return rifasAsync.when(
      data: (rifas) {
        return FutureBuilder<(int, int, int)>(
          future: _calcularStats(ref, rifas),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final (campanhas, vendas, reservas) = snapshot.data!;
              return Row(
                children: [
                  Expanded(
                    child: _GlassStat(
                      label: 'Campanhas',
                      value: '$campanhas',
                      icon: Icons.layers,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GlassStat(
                      label: 'Vendas',
                      value: '$vendas',
                      icon: Icons.shopping_bag,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GlassStat(
                      label: 'Reservas',
                      value: '$reservas',
                      icon: Icons.schedule,
                    ),
                  ),
                ],
              );
            }

            return Row(
              children: const [
                Expanded(
                  child: _GlassStat(
                    label: 'Campanhas',
                    value: '—',
                    icon: Icons.layers,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _GlassStat(
                    label: 'Vendas',
                    value: '—',
                    icon: Icons.shopping_bag,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _GlassStat(
                    label: 'Reservas',
                    value: '—',
                    icon: Icons.schedule,
                  ),
                ),
              ],
            );
          },
        );
      },
      loading: () => Row(
        children: const [
          Expanded(
            child: _GlassStat(
              label: 'Campanhas',
              value: '—',
              icon: Icons.layers,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _GlassStat(
              label: 'Vendas',
              value: '—',
              icon: Icons.shopping_bag,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _GlassStat(
              label: 'Reservas',
              value: '—',
              icon: Icons.schedule,
            ),
          ),
        ],
      ),
      error: (_, __) => Row(
        children: const [
          Expanded(
            child: _GlassStat(
              label: 'Campanhas',
              value: '0',
              icon: Icons.layers,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _GlassStat(
              label: 'Vendas',
              value: '0',
              icon: Icons.shopping_bag,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _GlassStat(
              label: 'Reservas',
              value: '0',
              icon: Icons.schedule,
            ),
          ),
        ],
      ),
    );
  }

  Future<(int, int, int)> _calcularStats(WidgetRef ref, List<dynamic> rifas) async {
    int vendas = 0;
    int reservas = 0;

    for (final rifa in rifas) {
      try {
        final bilhetesVendidos = await ref.read(bilhetesVendidosProvider(rifa.id).future);
        final bilhetesReservados = await ref.read(bilhetesReservadosProvider(rifa.id).future);
        vendas += bilhetesVendidos.length;
        reservas += bilhetesReservados.length;
      } catch (_) {
        // Ignora erros
      }
    }

    return (rifas.length, vendas, reservas);
  }
}

class _GlassStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _GlassStat({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.add_circle, 'Nova Rifa', () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CreateRifaScreen()),
        );
      }),
      (Icons.insights, 'Relatórios', () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const RelatoriosScreen()),
        );
      }),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: items
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton.icon(
                    onPressed: e.$3,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.12),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 0,
                    ),
                    icon: Icon(e.$1),
                    label: Text(e.$2),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _GradientLoading extends StatelessWidget {
  const _GradientLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 72,
      child: LinearProgressIndicator(
        minHeight: 6,
        borderRadius: BorderRadius.circular(999),
        valueColor: AlwaysStoppedAnimation(colorScheme.primary),
        backgroundColor: colorScheme.primary.withOpacity(.15),
      ),
    );
  }
}
