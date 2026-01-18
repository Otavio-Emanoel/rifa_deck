import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/participante_providers.dart';
import '../providers/bilhete_providers.dart';

class ParticipantesListScreen extends ConsumerWidget {
  final int rifaId;
  final String? rifaTitulo;

  const ParticipantesListScreen({
    super.key,
    required this.rifaId,
    this.rifaTitulo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantesAsync = ref.watch(participantesRifaProvider(rifaId));

    return Scaffold(
      appBar: AppBar(
        title: Text(rifaTitulo != null ? '${rifaTitulo!} - Compradores' : 'Compradores'),
      ),
      body: SafeArea(
        child: participantesAsync.when(
          data: (participantes) {
            if (participantes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text('Nenhum comprador ainda'),
                    const SizedBox(height: 8),
                    Text(
                      'As vendas aparecerão aqui',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: participantes.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final p = participantes[index];
                return _ParticipanteListTile(
                  participante: p,
                  rifaId: rifaId,
                  onParticipanteAtualizado: () {
                    // Invalida o cache para recarregar a lista
                    ref.invalidate(participantesRifaProvider(rifaId));
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Erro ao carregar: $err')),
        ),
      ),
    );
  }
}

class _ParticipanteListTile extends ConsumerWidget {
  final ParticipanteComBilhetes participante;
  final int rifaId;
  final VoidCallback onParticipanteAtualizado;

  const _ParticipanteListTile({
    required this.participante,
    required this.rifaId,
    required this.onParticipanteAtualizado,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = participante.todosPagos ? Colors.green : Colors.orange;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: statusColor.withOpacity(.2),
        child: Icon(
          participante.todosPagos ? Icons.check_circle : Icons.schedule,
          color: statusColor,
        ),
      ),
      title: Text(
        participante.nome,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            participante.descricao,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (participante.telefone != null) ...[
            const SizedBox(height: 4),
            Text(
              participante.telefone!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
            ),
          ],
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') {
            _mostrarEdicaoModal(context, ref);
          } else if (value == 'pagar') {
            _marcarPago(context, ref);
          } else if (value == 'compartilhar') {
            _compartilharComprovante(context);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 12),
                Text('Editar dados'),
              ],
            ),
          ),
          if (participante.temPendente)
            const PopupMenuItem(
              value: 'pagar',
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 18),
                  SizedBox(width: 12),
                  Text('Marcar como pago'),
                ],
              ),
            ),
          const PopupMenuItem(
            value: 'compartilhar',
            child: Row(
              children: [
                Icon(Icons.share, size: 18),
                SizedBox(width: 12),
                Text('Compartilhar'),
              ],
            ),
          ),
        ],
      ),
      onTap: () => _mostrarDetalhesModal(context),
    );
  }

  void _mostrarDetalhesModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _DetalhesParticipanteSheet(
        participante: participante,
      ),
    );
  }

  void _mostrarEdicaoModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _EdicaoParticipanteSheet(
        participante: participante,
        rifaId: rifaId,
        onSaved: () {
          onParticipanteAtualizado();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _marcarPago(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Marcar como pago?'),
        content: Text('${participante.numeroBilhetes.length} bilhetes de ${participante.nome} serão marcados como pagos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await ref.read(marcarParticipantePagoProvider(participante.id).future);
                onParticipanteAtualizado();
                Navigator.pop(ctx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${participante.nome} marcado como pago!')),
                  );
                }
              } catch (e) {
                Navigator.pop(ctx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _compartilharComprovante(BuildContext context) {
    final numerosTexto = participante.numeroBilhetes.join(', ');
    final statusTexto = participante.todosPagos ? '✅ PAGO' : '⏳ PENDENTE';
    final comprovante = '''
*Comprovante de Compra - Rifa Deck*

Comprador: ${participante.nome}
Status: $statusTexto
Quantidade: ${participante.numeroBilhetes.length} número(s)
Bilhetes: $numerosTexto

${participante.todosPagos ? '✅ Pagamento confirmado!' : '⏳ Aguardando pagamento...'}

*Rifa Deck - Suas rifas organizadas*
''';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Comprovante'),
        content: SingleChildScrollView(
          child: SelectableText(comprovante),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Fechar'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Copia para clipboard
              final data = ClipboardData(text: comprovante);
              Clipboard.setData(data);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Comprovante copiado! Cole no WhatsApp.')),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copiar'),
          ),
        ],
      ),
    );
  }
}

class _DetalhesParticipanteSheet extends StatelessWidget {
  final ParticipanteComBilhetes participante;

  const _DetalhesParticipanteSheet({required this.participante});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = participante.todosPagos ? Colors.green : Colors.orange;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              participante.nome,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    participante.todosPagos ? Icons.check_circle : Icons.schedule,
                    size: 18,
                    color: statusColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    participante.todosPagos ? 'Pago' : 'Pendente',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (participante.telefone != null) ...[
              Text(
                'Telefone',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                participante.telefone!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'Bilhetes (${participante.numeroBilhetes.length})',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: participante.numeroBilhetes.map((numero) {
                final statusIdx = participante.numeroBilhetes.indexOf(numero);
                final status = participante.statusBilhetes[statusIdx];
                final chipColor = status == 'vendido' ? Colors.green : Colors.orange;
                return Chip(
                  label: Text(
                    numero.toString().padLeft(3, '0'),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  backgroundColor: chipColor,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _EdicaoParticipanteSheet extends ConsumerStatefulWidget {
  final ParticipanteComBilhetes participante;
  final int rifaId;
  final VoidCallback onSaved;

  const _EdicaoParticipanteSheet({
    required this.participante,
    required this.rifaId,
    required this.onSaved,
  });

  @override
  ConsumerState<_EdicaoParticipanteSheet> createState() =>
      _EdicaoParticipanteSheetState();
}

class _EdicaoParticipanteSheetState extends ConsumerState<_EdicaoParticipanteSheet> {
  late TextEditingController _nomeController;
  late TextEditingController _telefoneController;
  bool _saving = false;
  Set<int> _bilhetesARemover = {};
  List<int> _novosBilhetes = [];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.participante.nome);
    _telefoneController = TextEditingController(text: widget.participante.telefone ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    setState(() => _saving = true);
    try {
      // Atualiza nome e telefone
      await ref.read(
        atualizarParticipanteProvider((
          id: widget.participante.id,
          nome: _nomeController.text,
          telefone: _telefoneController.text.isEmpty ? null : _telefoneController.text,
          rifaId: widget.rifaId,
        )).future,
      );

      // Remove bilhetes selecionados
      if (_bilhetesARemover.isNotEmpty) {
        // Precisa buscar os IDs dos bilhetes para remover
        final bilhetes = await ref.read(bilhetesRifaProvider(widget.rifaId).future);
        final idsParaRemover = <int>[];
        for (final numero in _bilhetesARemover) {
          final bilhete = bilhetes.firstWhere((b) => b.numero == numero);
          idsParaRemover.add(bilhete.id!);
        }
        if (idsParaRemover.isNotEmpty) {
          await ref.read(
            removerBilhetesDoParticipanteProvider((
              bilheteIds: idsParaRemover,
              rifaId: widget.rifaId,
            )).future,
          );
        }
      }

      widget.onSaved();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados atualizados!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Editar dados',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bilhetes (${widget.participante.numeroBilhetes.length})',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                if (_bilhetesARemover.isNotEmpty)
                  TextButton(
                    onPressed: () => setState(() => _bilhetesARemover.clear()),
                    child: const Text('Limpar seleção'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: widget.participante.numeroBilhetes.length,
              itemBuilder: (context, index) {
                final numero = widget.participante.numeroBilhetes[index];
                final status = widget.participante.statusBilhetes[index];
                final isSelected = _bilhetesARemover.contains(numero);
                final chipColor = status == 'vendido' ? Colors.green : Colors.orange;

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _bilhetesARemover.remove(numero);
                      } else {
                        _bilhetesARemover.add(numero);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red.withOpacity(.2) : chipColor.withOpacity(.2),
                      border: Border.all(
                        color: isSelected ? Colors.red : chipColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            numero.toString().padLeft(3, '0'),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.red : chipColor,
                                ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_bilhetesARemover.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.1),
                  border: Border.all(color: Colors.red.withOpacity(.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.red, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Clique em Salvar para remover ${_bilhetesARemover.length} bilhete(s)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(_saving ? 'Salvando...' : 'Salvar'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
