import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/rifa_providers.dart';
import '../providers/bilhete_providers.dart';
import '../services/export_import_service.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Importar Rifa',
            onPressed: () => _importarRifa(context, ref),
          ),
        ],
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
                      onExportar: () => _mostrarOpcoesExportar(context, rifa),
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

  void _importarRifa(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ImportarSheet(
        onImportado: () {
          ref.invalidate(rifasAtivasProvider);
        },
      ),
    );
  }

  void _mostrarOpcoesExportar(BuildContext context, dynamic rifa) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ExportarSheet(rifaId: rifa.id!, rifaTitulo: rifa.titulo),
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
  final VoidCallback onExportar;

  const _RifaRelatorioCard({
    required this.rifa,
    required this.onEditar,
    required this.onRemover,
    required this.onExportar,
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
                          } else if (value == 'exportar') {
                            onExportar();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'exportar',
                            child: Row(
                              children: [
                                Icon(Icons.share, size: 18),
                                SizedBox(width: 12),
                                Text('Exportar'),
                              ],
                            ),
                          ),
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

// ========== EXPORTAR SHEET ==========

class _ExportarSheet extends StatefulWidget {
  final int rifaId;
  final String rifaTitulo;

  const _ExportarSheet({
    required this.rifaId,
    required this.rifaTitulo,
  });

  @override
  State<_ExportarSheet> createState() => _ExportarSheetState();
}

class _ExportarSheetState extends State<_ExportarSheet> {
  final _exportService = ExportImportService();
  bool _isLoading = false;

  Future<void> _executarAcao(Future<void> Function() acao, String mensagemSucesso) async {
    setState(() => _isLoading = true);
    try {
      await acao();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagemSucesso),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao exportar: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 24),
            Icon(
              Icons.share,
              size: 48,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Exportar "${widget.rifaTitulo}"',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Escolha como deseja exportar os dados',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else
              Column(
                children: [
                  _ExportOption(
                    icon: Icons.copy,
                    titulo: 'Copiar Resumo',
                    subtitulo: 'Copia texto formatado para colar onde quiser',
                    cor: Colors.blue,
                    onTap: () => _executarAcao(
                      () => _exportService.copiarParaClipboard(widget.rifaId),
                      'Resumo copiado para área de transferência!',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ExportOption(
                    icon: Icons.message,
                    titulo: 'Compartilhar Texto',
                    subtitulo: 'Envie por WhatsApp, mensagem, etc.',
                    cor: Colors.green,
                    onTap: () => _executarAcao(
                    () => _exportService.compartilharTexto(widget.rifaId),
                    'Compartilhado!',
                  ),
                ),
                const SizedBox(height: 12),
                _ExportOption(
                  icon: Icons.file_download,
                  titulo: 'Exportar Backup (JSON)',
                  subtitulo: 'Arquivo completo para importar depois',
                  cor: Colors.orange,
                  onTap: () => _executarAcao(
                    () => _exportService.compartilharJson(widget.rifaId),
                    'Arquivo exportado!',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ExportOption extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color cor;
  final VoidCallback onTap;

  const _ExportOption({
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitulo,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========== IMPORTAR SHEET ==========

class _ImportarSheet extends StatefulWidget {
  final VoidCallback onImportado;

  const _ImportarSheet({required this.onImportado});

  @override
  State<_ImportarSheet> createState() => _ImportarSheetState();
}

class _ImportarSheetState extends State<_ImportarSheet> {
  final _exportService = ExportImportService();
  final _textController = TextEditingController();
  bool _isLoading = false;
  bool _mostrarCampoTexto = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _importarDeArquivo() async {
    setState(() => _isLoading = true);
    try {
      final rifaId = await _exportService.selecionarEImportarJson();
      if (rifaId != null) {
        widget.onImportado();
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rifa importada com sucesso!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao importar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _importarDeTexto() async {
    final texto = _textController.text.trim();
    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cole o JSON no campo'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _exportService.importarDeTexto(texto);
      widget.onImportado();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rifa importada com sucesso!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao importar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 24),
            Icon(
              Icons.file_upload,
              size: 48,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Importar Rifa',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Restaure uma rifa a partir de um backup',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else if (_mostrarCampoTexto)
              Column(
                children: [
                  TextField(
                    controller: _textController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'Cole o JSON aqui',
                      hintText: '{"versao": "1.0", "rifa": {...}}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setState(() => _mostrarCampoTexto = false),
                          child: const Text('Voltar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _importarDeTexto,
                          icon: const Icon(Icons.check),
                          label: const Text('Importar'),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                children: [
                  _ExportOption(
                    icon: Icons.folder_open,
                    titulo: 'Selecionar Arquivo',
                    subtitulo: 'Escolha um arquivo .json do dispositivo',
                    cor: Colors.blue,
                    onTap: _importarDeArquivo,
                  ),
                  const SizedBox(height: 12),
                  _ExportOption(
                    icon: Icons.content_paste,
                    titulo: 'Colar JSON',
                    subtitulo: 'Cole o conteúdo JSON diretamente',
                    cor: Colors.purple,
                    onTap: () => setState(() => _mostrarCampoTexto = true),
                  ),
                ],
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
