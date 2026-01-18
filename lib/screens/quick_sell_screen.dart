import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';
import '../providers/bilhete_providers.dart';
import '../models/rifa.dart';
import 'rifa_vendas_grid_screen.dart';

class QuickSellScreen extends ConsumerWidget {
  const QuickSellScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rifasAsync = ref.watch(rifasAtivasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vender Bilhetes'),
        elevation: 0,
        centerTitle: true,
      ),
      body: rifasAsync.when(
        data: (rifas) {
          if (rifas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.layers_clear,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma rifa ativa',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Crie uma rifa para começar a vender',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rifas.length,
            itemBuilder: (context, index) {
              final rifa = rifas[index];
              return _RifaVendaCard(rifa: rifa);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Erro ao carregar: $error'),
            ],
          ),
        ),
      ),
    );
  }
}

class _RifaVendaCard extends ConsumerWidget {
  final Rifa rifa;

  const _RifaVendaCard({required this.rifa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bilhetesVendidosAsync = ref.watch(bilhetesVendidosProvider(rifa.id!));
    final bilhetesReservadosAsync = ref.watch(bilhetesReservadosProvider(rifa.id!));

    return bilhetesVendidosAsync.when(
      data: (bilhetesVendidos) {
        return bilhetesReservadosAsync.when(
          data: (bilhetesReservados) {
            final vendidos = bilhetesVendidos.length;
            final reservados = bilhetesReservados.length;
            final livres = rifa.totalBilhetes - vendidos - reservados;
            final percentual = (vendidos / rifa.totalBilhetes) * 100;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título e status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rifa.titulo,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (rifa.descricao != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  rifa.descricao!,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'R\$ ${rifa.valorBilhete.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Barra de progresso
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progresso de vendas',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            Text(
                              '${percentual.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: percentual / 100,
                            minHeight: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Estatísticas
                    Row(
                      children: [
                        Expanded(
                          child: _StatItem(
                            label: 'Vendidos',
                            value: '$vendidos',
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _StatItem(
                            label: 'Reservados',
                            value: '$reservados',
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _StatItem(
                            label: 'Livres',
                            value: '$livres',
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Botões de ação
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => RifaVendasGridScreen(
                                    rifaId: rifa.id!,
                                    titulo: rifa.titulo,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.grid_3x3),
                            label: const Text('Grid'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _mostrarModalVenda(context, rifa);
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('Vender'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

  void _mostrarModalVenda(BuildContext context, Rifa rifa) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _VendaQuickModal(rifaId: rifa.id!),
    );
  }
}

class _VendaQuickModal extends ConsumerStatefulWidget {
  final int rifaId;

  const _VendaQuickModal({required this.rifaId});

  @override
  ConsumerState<_VendaQuickModal> createState() => _VendaQuickModalState();
}

class _VendaQuickModalState extends ConsumerState<_VendaQuickModal> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _quantidadeController = TextEditingController(text: '1');
  bool _pago = false;
  bool _saving = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vender Bilhetes',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do comprador *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone (opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade de bilhetes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.shopping_cart),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantidade é obrigatória';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 1) {
                    return 'Quantidade deve ser maior que 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _pago ? 'Pagamento efetuado' : 'Reservado',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Switch(
                    value: _pago,
                    onChanged: (value) {
                      setState(() => _pago = value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _vender,
                  child: Text(_saving ? 'Salvando...' : 'Vender'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _vender() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      final quantidade = int.parse(_quantidadeController.text);
      
      // Obtém os bilhetes disponíveis da rifa
      final bilhetes = await ref.read(bilhetesRifaProvider(widget.rifaId).future);
      
      // Filtra apenas bilhetes LIVRE
      final bilhetesLivres = bilhetes
          .where((b) => b.status == 'livre')
          .toList();
      
      // Valida se há bilhetes suficientes
      if (bilhetesLivres.length < quantidade) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Apenas ${bilhetesLivres.length} bilhetes disponíveis'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => _saving = false);
        return;
      }
      
      // Seleciona os primeiros N bilhetes
      final numerosSelecionados = bilhetesLivres
          .take(quantidade)
          .map((b) => b.numero!)
          .toList();
      
      // Chama o provider de checkout com a assinatura correta
      await ref.read(
        checkoutVendaProvider((
          rifaId: widget.rifaId,
          nomeComprador: _nomeController.text,
          telefone: _telefoneController.text.isEmpty ? null : _telefoneController.text,
          numerosBilhetes: numerosSelecionados,
          pago: _pago,
        )).future,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Venda realizada com sucesso! 🎉'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao vender: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
