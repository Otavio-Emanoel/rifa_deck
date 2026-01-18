import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withOpacity(.08),
                    colorScheme.secondary.withOpacity(.08),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'app_logo',
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.local_activity,
                            size: 64,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Rifa_Deck',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _GradientLoader(color: colorScheme.primary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientLoader extends StatelessWidget {
  final Color color;
  const _GradientLoader({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
          builder: (context, value, _) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: color.withOpacity(.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 4,
            );
          },
        ),
      ),
    );
  }
}
