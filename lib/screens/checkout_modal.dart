import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../providers/bilhete_providers.dart';
import '../providers/selection_providers.dart';
import '../providers/participante_providers.dart';

class CheckoutModal extends ConsumerStatefulWidget {
  final int rifaId;
  final int quantidade;
  final double total;
  final List<int> numerosBilhetes;

  const CheckoutModal({
    super.key,
    required this.rifaId,
    required this.quantidade,
    required this.total,
    required this.numerosBilhetes,
  });

  @override
  ConsumerState<CheckoutModal> createState() => _CheckoutModalState();
}

class _CheckoutModalState extends ConsumerState<CheckoutModal> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  bool _pago = false;
  bool _saving = false;
  int? _participanteEscolhidoId;
  bool _isNovoParticipante = true;

  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  void _selecionarParticipante(int id, String nome, String? telefone) {
    setState(() {
      _participanteEscolhidoId = id;
      _nomeController.text = nome;
      _telefoneController.text = telefone ?? '';
      _isNovoParticipante = false;
    });
  }

  void _limparSelecao() {
    setState(() {
      _participanteEscolhidoId = null;
      _nomeController.clear();
      _telefoneController.clear();
      _isNovoParticipante = true;
    });
  }

  Future<void> _confirmar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final nome = _nomeController.text.trim();
      final telefone = _telefoneController.text.trim().isEmpty ? null : _telefoneController.text.trim();

      await ref.read(checkoutVendaProvider((
        rifaId: widget.rifaId,
        nomeComprador: nome,
        telefone: telefone,
        numerosBilhetes: widget.numerosBilhetes,
        pago: _pago,
      )).future);

      // Limpa a seleção
      ref.read(selecionadosProvider(widget.rifaId).notifier).clear();

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.quantidade} números ${_pago ? 'vendidos' : 'reservados'} para $nome!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao confirmar: $e'), backgroundColor: Colors.red),
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
    final participantesAsync = ref.watch(participantesRifaProvider(widget.rifaId));

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
              'Finalizar venda',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.quantidade} números - R\$ ${widget.total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 20),
            // Lista de compradores existentes
            participantesAsync.when(
              data: (participantes) {
                if (participantes.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compradores Existentes',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: participantes.length,
                        itemBuilder: (context, index) {
                          final p = participantes[index];
                          final isSelected = _participanteEscolhidoId == p.id;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => _selecionarParticipante(p.id, p.nome, p.telefone),
                              child: Container(
                                width: 120,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorScheme.primary.withOpacity(.2)
                                      : colorScheme.surfaceVariant,
                                  border: Border.all(
                                    color: isSelected
                                        ? colorScheme.primary
                                        : colorScheme.outline.withOpacity(.3),
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      p.nome,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    if (p.telefone != null)
                                      Text(
                                        p.telefone!,
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: colorScheme.primary,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    const Spacer(),
                                    Text(
                                      '${p.numeroBilhetes.length} bilhetes',
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_participanteEscolhidoId != null)
                      TextButton.icon(
                        onPressed: _limparSelecao,
                        icon: const Icon(Icons.clear),
                        label: const Text('Novo Comprador'),
                      ),
                    const SizedBox(height: 16),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            // Formulário
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Nome do Comprador *',
                      hintText: 'Ex.: João Silva',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o nome do comprador';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _telefoneController,
                    inputFormatters: [_telefoneMask],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Telefone / WhatsApp',
                      hintText: '(11) 98765-4321',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _pago ? colorScheme.primary.withOpacity(.1) : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _pago ? colorScheme.primary : colorScheme.outline.withOpacity(.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Já está pago?',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                _pago ? 'Vendido' : 'Reservado (Pendente)',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _pago,
                          onChanged: (val) => setState(() => _pago = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saving ? null : _confirmar,
                      icon: _saving
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(colorScheme.onPrimary),
                              ),
                            )
                          : const Icon(Icons.check_circle),
                      label: Text(_saving ? 'Processando...' : 'Confirmar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _saving ? null : () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
