import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';

class CreateRifaScreen extends ConsumerStatefulWidget {
  const CreateRifaScreen({super.key});

  @override
  ConsumerState<CreateRifaScreen> createState() => _CreateRifaScreenState();
}

class _CreateRifaScreenState extends ConsumerState<CreateRifaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _premioController = TextEditingController();
  final _quantidadeController = TextEditingController(text: '100');
  final _valorController = TextEditingController(text: '10.00');
  bool _saving = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _premioController.dispose();
    _quantidadeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final service = ref.read(isarServiceProvider);
      final titulo = _nomeController.text.trim();
      final premio = _premioController.text.trim();
      final quantidade = int.parse(_quantidadeController.text.trim());
      final valor = double.parse(_valorController.text.replaceAll(',', '.').trim());

      final rifaId = await service.criarRifa(
        titulo: titulo,
        descricao: premio.isEmpty ? null : premio,
        totalBilhetes: quantidade,
        valorBilhete: valor,
      );

      await service.criarBilhetes(rifaId, quantidade);

      // Atualiza a lista de rifas na Home
      ref.invalidate(rifasAtivasProvider);
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rifa criada com sucesso!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Rifa'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setup da campanha',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Defina o básico e o app gera todos os bilhetes com status LIVRE para você.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nomeController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Rifa',
                    hintText: 'Ex.: Rifa da Smart TV',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome da rifa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _premioController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Prêmio',
                    hintText: 'Ex.: Smart TV 55" 4K',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantidadeController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade de números',
                          hintText: 'Ex.: 100, 200, 1000',
                        ),
                        validator: (value) {
                          final parsed = int.tryParse(value ?? '');
                          if (parsed == null || parsed <= 0) {
                            return 'Quantidade inválida';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _valorController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Valor por número (R\$)',
                          hintText: 'Ex.: 10,00',
                        ),
                        validator: (value) {
                          final parsed = double.tryParse((value ?? '').replaceAll(',', '.'));
                          if (parsed == null || parsed <= 0) {
                            return 'Valor inválido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saving ? null : _save,
                    icon: _saving
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(colorScheme.onPrimary),
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(_saving ? 'Salvando...' : 'Salvar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
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
