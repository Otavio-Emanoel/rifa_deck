import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';
import '../models/bilhete.dart';
import '../providers/bilhete_providers.dart';
import '../providers/participante_providers.dart';

enum TipoSorteio { simples, multiplo, sequencial }

class SorteioScreen extends ConsumerStatefulWidget {
  final int rifaId;
  final String? rifaTitulo;

  const SorteioScreen({
    super.key,
    required this.rifaId,
    this.rifaTitulo,
  });

  @override
  ConsumerState<SorteioScreen> createState() => _SorteioScreenState();
}

class _SorteioScreenState extends ConsumerState<SorteioScreen>
    with TickerProviderStateMixin {
  late AnimationController _slotController;
  Animation<int>? _slotAnimation;
  late ConfettiController _confettiController;
  
  List<Bilhete> _bilhetesSorteados = [];
  Set<int> _numerosSorteados = {};
  bool _executando = false;
  TipoSorteio _tipoSorteio = TipoSorteio.simples;
  int _quantidadeSortear = 1;
  List<Bilhete>? _todosBilhetes;
  int _velocidadeAnimacao = 80; // ms entre frames

  @override
  void initState() {
    super.initState();
    _slotController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    _carregarBilhetes();
  }

  void _carregarBilhetes() async {
    try {
      final bilhetes = await ref.read(bilhetesVendidosProvider(widget.rifaId).future);
      setState(() => _todosBilhetes = bilhetes);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar bilhetes: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _slotController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _executarSorteio() async {
    if (_executando || _todosBilhetes == null || _todosBilhetes!.isEmpty) return;
    
    setState(() => _executando = true);

    try {
      final bilhetesDisponveis = _todosBilhetes!
          .where((b) => !_numerosSorteados.contains(b.numero))
          .toList();

      if (bilhetesDisponveis.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum bilhete disponível para sortear!')),
        );
        setState(() => _executando = false);
        return;
      }

      // Seleciona número aleatório primeiro
      final indiceAleatorio = DateTime.now().millisecondsSinceEpoch % bilhetesDisponveis.length;
      final bilheteSorteado = bilhetesDisponveis[indiceAleatorio];

      // Anima passando por todos os números várias vezes antes de parar no sorteado
      final repeticoes = 3;
      final valorFinal = (bilhetesDisponveis.length * repeticoes) + indiceAleatorio;
      
      _slotAnimation = IntTween(begin: 0, end: valorFinal)
          .animate(CurvedAnimation(parent: _slotController, curve: Curves.easeInOutCubic));

      setState(() {}); // Força rebuild para mostrar animação

      await _slotController.forward().then((_) {
        _adicionarSorteado(bilheteSorteado);
        _confettiController.play();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      setState(() => _executando = false);
    }
  }

  void _adicionarSorteado(Bilhete bilhete) {
    setState(() {
      _bilhetesSorteados.add(bilhete);
      // Só adiciona aos sorteados se for múltiplo ou sequencial (para remover da próxima rodada)
      if (_tipoSorteio == TipoSorteio.multiplo || _tipoSorteio == TipoSorteio.sequencial) {
        _numerosSorteados.add(bilhete.numero);
      }
    });

    // Continua sorteando se for múltiplo ou sequencial
    if ((_tipoSorteio == TipoSorteio.multiplo || _tipoSorteio == TipoSorteio.sequencial) && 
        _bilhetesSorteados.length < _quantidadeSortear) {
      Future.delayed(const Duration(seconds: 2), () {
        _slotController.reset();
        _executarSorteio();
      });
    }
  }

  void _removerDaSorteio(int numero) {
    setState(() {
      _bilhetesSorteados.removeWhere((b) => b.numero == numero);
      _numerosSorteados.remove(numero);
    });
  }

  void _resetarSorteio() {
    setState(() {
      _bilhetesSorteados.clear();
      _numerosSorteados.clear();
      _slotAnimation = null;
      _slotController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final todosBilhetesCarregados = _todosBilhetes != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rifaTitulo != null ? '${widget.rifaTitulo!} - Sorteio' : 'Sorteio'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 80,
                gravity: 0.15,
                shouldLoop: false,
              ),
            ),
            // Conteúdo
            if (!todosBilhetesCarregados)
              const Center(child: CircularProgressIndicator())
            else if (_executando)
              _construirAnimacaoSorteio(colorScheme)
            else if (_bilhetesSorteados.isEmpty)
              _construirMenuOpcoes(colorScheme)
            else
              _construirResultados(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _construirAnimacaoSorteio(ColorScheme colorScheme) {
    final bilhetesDisponveis = _todosBilhetes!
        .where((b) => !_numerosSorteados.contains(b.numero))
        .toList();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🎰 SORTEANDO 🎰',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
            ),
            const SizedBox(height: 48),
            // Container do número animado
            Container(
              width: 280,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withOpacity(.2),
                    colorScheme.secondary.withOpacity(.2),
                    colorScheme.tertiary.withOpacity(.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.primary,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: _slotAnimation != null
                    ? AnimatedBuilder(
                        animation: _slotAnimation!,
                        builder: (context, child) {
                          final indice = _slotAnimation!.value % bilhetesDisponveis.length;
                          final numeroAtual = bilhetesDisponveis[indice].numero;
                          return Text(
                            numeroAtual.toString().padLeft(3, '0'),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Courier',
                                  color: colorScheme.primary,
                                  letterSpacing: 8,
                                ),
                          );
                        },
                      )
                    : Text(
                        '...',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.outlineVariant,
                            ),
                      ),
              ),
            ),
            const SizedBox(height: 48),
            // Indicador de progresso
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: colorScheme.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Aguarde...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirMenuOpcoes(ColorScheme colorScheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configurar Sorteio',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            // Tipo de sorteio
            Text(
              'Tipo de Sorteio',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _construirOpcaoSorteio(
              TipoSorteio.simples,
              'Simples',
              'Sorteia 1 número (pode repetir)',
              Icons.shuffle,
            ),
            const SizedBox(height: 8),
            _construirOpcaoSorteio(
              TipoSorteio.multiplo,
              'Múltiplo',
              'Sorteia vários números (sem repetir)',
              Icons.layers,
            ),
            const SizedBox(height: 8),
            _construirOpcaoSorteio(
              TipoSorteio.sequencial,
              'Sequencial (1º, 2º, 3º)',
              'Sorteia colocações em ordem',
              Icons.list_rounded,
            ),
            const SizedBox(height: 24),
            // Quantidade se múltiplo ou sequencial
            if (_tipoSorteio == TipoSorteio.multiplo || _tipoSorteio == TipoSorteio.sequencial)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tipoSorteio == TipoSorteio.multiplo 
                        ? 'Quantidade a sortear' 
                        : 'Número de colocações (1º, 2º, 3º...)',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _quantidadeSortear.toDouble(),
                    min: 1,
                    max: (_todosBilhetes?.length ?? 10).toDouble().clamp(1, 10),
                    divisions: ((_todosBilhetes?.length ?? 10).clamp(1, 10) - 1).toInt(),
                    label: '$_quantidadeSortear',
                    onChanged: (value) {
                      setState(() => _quantidadeSortear = value.toInt());
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            // Slider de velocidade
            Text(
              'Velocidade da Animação',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.speed, size: 20, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    value: _velocidadeAnimacao.toDouble(),
                    min: 30,
                    max: 150,
                    divisions: 12,
                    label: _velocidadeAnimacao == 80 ? 'Normal' : 
                           _velocidadeAnimacao < 80 ? 'Rápido' : 'Lento',
                    onChanged: (value) {
                      setState(() => _velocidadeAnimacao = value.toInt());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Botão iniciar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _executando ? null : _executarSorteio,
                icon: const Icon(Icons.play_arrow),
                label: Text(_executando ? 'Sorteando...' : 'INICIAR SORTEIO'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.primary.withOpacity(.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Bilhetes vendidos: ${_todosBilhetes?.length ?? 0}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirOpcaoSorteio(
    TipoSorteio tipo,
    String titulo,
    String descricao,
    IconData icone,
  ) {
    final selected = _tipoSorteio == tipo;
    return GestureDetector(
      onTap: () => setState(() => _tipoSorteio = tipo),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary.withOpacity(.15)
              : Theme.of(context).colorScheme.surfaceVariant.withOpacity(.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icone,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                  ),
                  Text(
                    descricao,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _construirResultados(ColorScheme colorScheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Números Sorteados',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Card do último sorteado
            if (_bilhetesSorteados.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(.15),
                      Colors.teal.withOpacity(.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      'Último Sorteado',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _bilhetesSorteados.last.numero.toString().padLeft(3, '0'),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontFamily: 'Courier',
                          ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            // Lista de sorteados
            Text(
              _tipoSorteio == TipoSorteio.sequencial 
                  ? 'Colocações (${_bilhetesSorteados.length})' 
                  : 'Histórico (${_bilhetesSorteados.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _bilhetesSorteados.asMap().entries.map((entry) {
                final indice = entry.key;
                final bilhete = entry.value;
                return _construirChipSorteado(indice, bilhete, colorScheme);
              }).toList(),
            ),
            const SizedBox(height: 32),
            // Botões de ação
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _executando ? null : _executarSorteio,
                icon: const Icon(Icons.add),
                label: const Text('Sortear Mais Um'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _resetarSorteio,
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar Sorteio'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirChipSorteado(int indice, Bilhete bilhete, ColorScheme colorScheme) {
    String prefixo = _tipoSorteio == TipoSorteio.sequencial
        ? _obterMedalha(indice)
        : '#${bilhete.numero.toString().padLeft(3, '0')}';
    
    String sufixo = _tipoSorteio == TipoSorteio.sequencial
        ? ' ${bilhete.numero.toString().padLeft(3, '0')}'
        : ' (${indice + 1}º)';

    return Chip(
      label: Text(
        '$prefixo$sufixo',
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: _obterCorPosicao(indice),
      onDeleted: () => _removerDaSorteio(bilhete.numero),
      deleteIcon: const Icon(Icons.close, size: 18),
    );
  }

  String _obterMedalha(int indice) {
    switch (indice) {
      case 0:
        return '🥇';
      case 1:
        return '🥈';
      case 2:
        return '🥉';
      default:
        return '${indice + 1}º';
    }
  }

  Color _obterCorPosicao(int indice) {
    const cores = [
      Colors.amber,
      Colors.orange,
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.blue,
    ];
    return cores[indice % cores.length];
  }
}
