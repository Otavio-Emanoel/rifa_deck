import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bilhete.dart';
import '../models/enums.dart';
import '../models/participante.dart';
import '../providers/bilhete_providers.dart';
import '../providers/participante_providers.dart';
import '../providers/rifa_providers.dart';
import '../providers/selection_providers.dart';
import 'checkout_modal.dart';

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
                      rifaId: rifaId,
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => CheckoutModal(
                  rifaId: rifaId,
                  quantidade: selecionados.length,
                  total: total,
                  numerosBilhetes: selecionados.toList(),
                ),
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
    final total = bilhetes.length;
    final percentualVendido = total > 0 ? ((vendidos + reservados) / total * 100).toStringAsFixed(0) : '0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: total > 0 ? (vendidos + reservados) / total : 0,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ResumoChip(
                label: 'Livres',
                value: livres,
                color: Colors.grey.shade200,
                textColor: Colors.black87,
              ),
              const SizedBox(width: 8),
              _ResumoChip(
                label: 'Vendidos',
                value: vendidos,
                color: Colors.green.shade100,
                textColor: Colors.green.shade900,
              ),
              const SizedBox(width: 8),
              _ResumoChip(
                label: 'Reservados',
                value: reservados,
                color: Colors.amber.shade100,
                textColor: Colors.orange.shade900,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$percentualVendido%',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResumoChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final Color textColor;

  const _ResumoChip({
    required this.label,
    required this.value,
    required this.color,
    required this.textColor,
  });

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
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(width: 4),
          Text(
            '$value',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _BilhetesGrid extends ConsumerStatefulWidget {
  final List<Bilhete> bilhetes;
  final Set<int> selecionados;
  final ValueChanged<int> onToggle;
  final int rifaId;

  const _BilhetesGrid({
    required this.bilhetes,
    required this.selecionados,
    required this.onToggle,
    required this.rifaId,
  });

  @override
  ConsumerState<_BilhetesGrid> createState() => _BilhetesGridState();
}

class _BilhetesGridState extends ConsumerState<_BilhetesGrid> with TickerProviderStateMixin {
  late Map<int, AnimationController> _animationControllers;
  late Map<int, Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _animationControllers = {};
    _scaleAnimations = {};
  }

  @override
  void dispose() {
    for (var controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  AnimationController _getController(int numero) {
    if (!_animationControllers.containsKey(numero)) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
      _animationControllers[numero] = controller;
      _scaleAnimations[numero] = Tween<double>(begin: 1.0, end: 0.95).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
      );
    }
    return _animationControllers[numero]!;
  }

  void _handleTap(Bilhete bilhete) {
    final controller = _getController(bilhete.numero);
    controller.forward().then((_) => controller.reverse());

    if (bilhete.status == BilheteStatus.livre) {
      widget.onToggle(bilhete.numero);
    } else {
      _mostrarDetalhesModal(bilhete);
    }
  }

  void _mostrarDetalhesModal(Bilhete bilhete) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _BilheteDetalhesModal(bilhete: bilhete, rifaId: widget.rifaId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const crossAxisCount = 5;

    return GridView.builder(
      itemCount: widget.bilhetes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      padding: const EdgeInsets.all(2),
      itemBuilder: (context, index) {
        final bilhete = widget.bilhetes[index];
        final selected = widget.selecionados.contains(bilhete.numero);
        final isClickable = bilhete.status != BilheteStatus.livre;

        return ScaleTransition(
          scale: _scaleAnimations[bilhete.numero] ?? AlwaysStoppedAnimation(1.0),
          child: GestureDetector(
            onTap: () => _handleTap(bilhete),
            onTapDown: (_) => _getController(bilhete.numero).forward(),
            onTapCancel: () => _getController(bilhete.numero).reverse(),
            child: _BilheteTile(
              bilhete: bilhete,
              selected: selected,
              isClickable: isClickable,
            ),
          ),
        );
      },
    );
  }
}

class _BilheteTile extends StatelessWidget {
  final Bilhete bilhete;
  final bool selected;
  final bool isClickable;

  const _BilheteTile({
    required this.bilhete,
    required this.selected,
    required this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = _tileColors(colorScheme, bilhete.status, selected);

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border, width: 2),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: colors.border.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          if (isClickable)
            BoxShadow(
              color: colors.border.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bilhete.numero.toString().padLeft(3, '0'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.foreground,
                        fontSize: 18,
                      ),
                ),
                if (isClickable) ...[
                  const SizedBox(height: 2),
                  Text(
                    bilhete.status == BilheteStatus.vendido ? 'Vendido' : 'Reservado',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.foreground.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (isClickable)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colors.border.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
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

class _BottomVendaBar extends StatefulWidget {
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
  State<_BottomVendaBar> createState() => _BottomVendaBarState();
}

class _BottomVendaBarState extends State<_BottomVendaBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SlideTransition(
      position: _slideAnimation,
      child: SafeArea(
        top: false,
        child: Material(
          elevation: 12,
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
                        'Vender ${widget.quantidade} número${widget.quantidade > 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'R\$ ${widget.total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: widget.onLimpar,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: widget.onVender,
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text('Vender'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BilheteDetalhesModal extends ConsumerStatefulWidget {
  final Bilhete bilhete;
  final int rifaId;

  const _BilheteDetalhesModal({
    required this.bilhete,
    required this.rifaId,
  });

  @override
  ConsumerState<_BilheteDetalhesModal> createState() => _BilheteDetalhesModalState();
}

class _BilheteDetalhesModalState extends ConsumerState<_BilheteDetalhesModal> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<Participante?>(
      future: _getParticipante(),
      builder: (context, snapshot) {
        final participante = snapshot.data;

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.85,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getStatusColor(widget.bilhete.status).withOpacity(0.2),
                            border: Border.all(
                              color: _getStatusColor(widget.bilhete.status),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.bilhete.numero.toString().padLeft(3, '0'),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(widget.bilhete.status),
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
                                'Bilhete',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Nº ${widget.bilhete.numero.toString().padLeft(3, '0')}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.bilhete.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(widget.bilhete.status).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(
                              widget.bilhete.status == BilheteStatus.vendido ? 'Vendido' : 'Reservado',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: _getStatusColor(widget.bilhete.status),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (participante != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comprador',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme.primary.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: colorScheme.primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        participante.nome,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      if (participante.telefone?.isNotEmpty == true)
                                        Text(
                                          participante.telefone ?? '',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    if (participante != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonalIcon(
                          onPressed: _removerDoComprador,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Remover do Comprador'),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (widget.bilhete.status == BilheteStatus.reservado && participante != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _marcarComoPago,
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Confirmar Pagamento'),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Participante?> _getParticipante() async {
    final isar = ref.read(isarServiceProvider);
    if (widget.bilhete.id == null) return null;
    return await isar.obterParticipanteComBilhete(widget.bilhete.id!);
  }

  Color _getStatusColor(BilheteStatus status) {
    if (status == BilheteStatus.vendido) {
      return Colors.green;
    } else if (status == BilheteStatus.reservado) {
      return Colors.orange;
    }
    return Colors.grey;
  }

  void _removerDoComprador() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar remoção'),
        content: const Text('Deseja remover este bilhete do comprador? Ele voltará a estar disponível.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _executarRemocao();
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  void _executarRemocao() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await ref.read(isarServiceProvider).atualizarBilhete(
            widget.bilhete.copyWith(
              status: BilheteStatus.livre,
              clearParticipanteId: true,
            ),
          );

      // Invalida providers para atualizar UI
      ref.invalidate(bilhetesRifaProvider(widget.rifaId));
      ref.invalidate(bilhetesVendidosProvider(widget.rifaId));
      ref.invalidate(bilhetesReservadosProvider(widget.rifaId));
      ref.invalidate(participantesRifaProvider(widget.rifaId));

      navigator.pop();
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Bilhete removido com sucesso')),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  void _marcarComoPago() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar pagamento'),
        content: const Text('Deseja marcar este bilhete como vendido?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _executarConfirmacao();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _executarConfirmacao() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await ref.read(isarServiceProvider).atualizarBilhete(
            widget.bilhete.copyWith(
              status: BilheteStatus.vendido,
            ),
          );

      // Invalida providers
      ref.invalidate(bilhetesRifaProvider(widget.rifaId));
      ref.invalidate(bilhetesVendidosProvider(widget.rifaId));
      ref.invalidate(bilhetesReservadosProvider(widget.rifaId));
      ref.invalidate(participantesRifaProvider(widget.rifaId));

      navigator.pop();
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Pagamento confirmado com sucesso')),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }
}
