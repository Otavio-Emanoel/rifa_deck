import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' as math;
import '../models/bilhete.dart';
import '../providers/bilhete_providers.dart';
import '../providers/participante_providers.dart';

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
  Bilhete? _bilheteSorteado;
  ParticipanteComBilhetes? _compradorSorteado;
  bool _executado = false;

  @override
  void initState() {
    super.initState();
    _slotController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _confettiController = ConfettiController(duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _slotController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _executarSorteio() async {
    if (_executado) return;
    setState(() => _executado = true);

    try {
      // Obtém bilhete sorteado
      final bilhete = await ref.read(sorteioProvider(widget.rifaId).future);
      if (bilhete == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nenhum bilhete vendido para sortear!'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => _executado = false);
        return;
      }

      // Anima números passando
      _slotAnimation = IntTween(begin: 0, end: bilhete.numero)
          .animate(CurvedAnimation(parent: _slotController, curve: Curves.easeInOutCubic));

      _slotController.forward().then((_) async {
        setState(() => _bilheteSorteado = bilhete);

        // Obtém dados do comprador
        final participantes = await ref.read(participantesRifaProvider(widget.rifaId).future);
        final comprador = participantes.firstWhere(
          (p) => p.numeroBilhetes.contains(bilhete.numero),
          orElse: () => ParticipanteComBilhetes(
            id: 0,
            nome: 'Desconhecido',
            telefone: null,
            numeroBilhetes: [],
            statusBilhetes: [],
          ),
        );
        setState(() => _compradorSorteado = comprador);
        _confettiController.play();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
        );
      }
      setState(() => _executado = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rifaTitulo != null ? '${widget.rifaTitulo!} - Sorteio' : 'Sorteio'),
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
                numberOfParticles: 50,
                gravity: 0.1,
                shouldLoop: false,
              ),
            ),
            // Conteúdo
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'O Grande Sorteio',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 40),
                  // Slot Machine
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(.1),
                          colorScheme.secondary.withOpacity(.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.primary,
                        width: 3,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          'Número Sorteado',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 16),
                        if (_bilheteSorteado == null && _slotAnimation != null)
                          AnimatedBuilder(
                            animation: _slotAnimation!,
                            builder: (context, child) {
                              return Text(
                                _slotAnimation!.value.toString().padLeft(3, '0'),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Courier',
                                      color: colorScheme.primary,
                                    ),
                              );
                            },
                          )
                        else if (_bilheteSorteado != null)
                          Text(
                            _bilheteSorteado!.numero.toString().padLeft(3, '0'),
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Courier',
                                  color: Colors.green,
                                ),
                          )
                        else
                          Text(
                            '---',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Courier',
                                  color: colorScheme.outlineVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Resultado
                  if (_bilheteSorteado != null && _compradorSorteado != null)
                    Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.celebration,
                            size: 48,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'O Vencedor É:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _compradorSorteado!.nome,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                          const SizedBox(height: 8),
                          if (_compradorSorteado!.telefone != null)
                            Text(
                              _compradorSorteado!.telefone!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                            ),
                          const SizedBox(height: 12),
                          Chip(
                            label: Text(
                              'Bilhete #${_bilheteSorteado!.numero}',
                              style: const TextTheme().labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _bilheteSorteado == null
          ? FloatingActionButton.extended(
              onPressed: _executarSorteio,
              icon: const Icon(Icons.shuffle),
              label: const Text('Iniciar Sorteio'),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _bilheteSorteado = null;
                  _compradorSorteado = null;
                  _executado = false;
                  _slotController.reset();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Novo Sorteio'),
            ),
    );
  }
}
