import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';
import '../providers/bilhete_providers.dart';
import 'create_rifa_screen.dart';

class RelatoriosScreen extends ConsumerWidget {
  const RelatoriosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rifasAsync = ref.watch(rifasAtivasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        elevation: 0,
      ),
      body: rifasAsync.when(
        data: (rifas) {
          if (rifas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text('Nenhuma rifa para relatar'),
                  const SizedBox(height: 8),
                  Text(
                    'Crie uma rifa para começar',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _StatisticasGerais(rifas: rifas),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Detalhes por Rifa',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final rifa = rifas[index];
                    return _RifaRelatorioCard(
                      rifa: rifa,
                      onEditar: () => _editarRifa(context, ref, rifa),
                      onRemover: () => _removerRifa(context, ref, rifa),
                    );
                  },
                  childCount: rifas.length,
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Erro ao carregar: $error'),
        ),
      ),
    );
  }

  void _editarRifa(BuildContext context, WidgetRef ref, rifa) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateRifaScreen(rifaParaEditar: rifa),
      ),
    );
  }

  void _removerRifa(BuildContext context, WidgetRef ref, rifa) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover rifa?'),
        content: Text('Tem certeza que deseja remover a rifa "${rifa.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await ref.read(removerRifaProvider(rifa.id!).future);
                Navigator.pop(ctx);
                ref.invalidate(rifasAtivasProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rifa removida!')),
                  );
                }
              } catch (e) {
                Navigator.pop(ctx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }
}

class _StatisticasGerais extends ConsumerWidget {
  final List<dynamic> rifas;

  const _StatisticasGerais({required this.rifas});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estatísticas Gerais',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _StatCard(
              titulo: 'Total de Rifas',
              valor: rifas.length.toString(),
              icone: Icons.card_giftcard,
              cor: Colors.blue,
            ),
            _StatCard(
              titulo: 'Bilhetes Totais',
              valor: rifas.fold<int>(0, (prev, rifa) => prev + ((rifa.totalBilhetes ?? 0) as int)).toString(),
              icone: Icons.confirmation_number,
              cor: Colors.green,
            ),
            _StatCard(
              titulo: 'Valor Total/Bilhete',
              valor: 'R\$ ${rifas.fold<double>(0.0, (prev, rifa) => prev + ((rifa.valorBilhete ?? 0.0) as double)).toStringAsFixed(2)}',
              icone: Icons.attach_money,
              cor: Colors.orange,
            ),
            _StatCard(
              titulo: 'Rifas Ativas',
              valor: rifas.where((r) => r.status == 'ativa').length.toString(),
              icone: Icons.check_circle,
              cor: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;
  final Color cor;

  const _StatCard({
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cor.withOpacity(.1),
        border: Border.all(color: cor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icone, color: cor, size: 32),
          const SizedBox(height: 8),
          Text(
            valor,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _RifaRelatorioCard extends ConsumerWidget {
  final dynamic rifa;
  final VoidCallback onEditar;
  final VoidCallback onRemover;

  const _RifaRelatorioCard({
    required this.rifa,
    required this.onEditar,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bilhetesVendidosAsync = ref.watch(bilhetesVendidosProvider(rifa.id));
    final bilhetesReservadosAsync = ref.watch(bilhetesReservadosProvider(rifa.id));

    return bilhetesVendidosAsync.when(
      data: (vendidos) {
        return bilhetesReservadosAsync.when(
          data: (reservados) {
            final percentualVendido =
                rifa.totalBilhetes > 0 ? (vendidos.length / rifa.totalBilhetes * 100).toStringAsFixed(1) : '0.0';
            final percentualReservado =
                rifa.totalBilhetes > 0 ? (reservados.length / rifa.totalBilhetes * 100).toStringAsFixed(1) : '0.0';
            final percentualLivre = (100 - double.parse(percentualVendido) - double.parse(percentualReservado))
                .toStringAsFixed(1);
            final receita = vendidos.length * (rifa.valorBilhete ?? 0.0);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rifa.titulo,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              rifa.descricao ?? 'Sem descrição',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'editar') {
                            onEditar();
                          } else if (value == 'remover') {
                            onRemover();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'editar',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 12),
                                Text('Editar'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'remover',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 12),
                                Text('Remover', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Gráfico de progresso
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: vendidos.length / rifa.totalBilhetes,
                      minHeight: 8,
                      backgroundColor: Colors.grey.withOpacity(.2),
                      valueColor: AlwaysStoppedAnimation(Colors.green.shade600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Stats em forma de linha
                  Row(
                    children: [
                      Expanded(
                        child: _StatLinhaCompacta(
                          label: 'Vendidos',
                          valor: vendidos.length.toString(),
                          percentual: percentualVendido,
                          cor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _StatLinhaCompacta(
                          label: 'Reservados',
                          valor: reservados.length.toString(),
                          percentual: percentualReservado,
                          cor: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _StatLinhaCompacta(
                          label: 'Livres',
                          valor: (rifa.totalBilhetes - vendidos.length - reservados.length).toString(),
                          percentual: percentualLivre,
                          cor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Dados financeiros
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receita Gerada',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            Text(
                              'R\$ ${receita.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Valor Potencial',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            Text(
                              'R\$ ${(rifa.totalBilhetes * (rifa.valorBilhete ?? 0.0)).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _StatLinhaCompacta extends StatelessWidget {
  final String label;
  final String valor;
  final String percentual;
  final Color cor;

  const _StatLinhaCompacta({
    required this.label,
    required this.valor,
    required this.percentual,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cor.withOpacity(.1),
        border: Border.all(color: cor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: cor,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            '$percentual%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: cor,
                ),
          ),
        ],
      ),
    );
  }
}
