import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..forward();

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, anim, __) => const LoginScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasDark,
      body: Stack(
        children: [
          // Ambient row illustration representing hydroponic channels.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.35,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 140),
                painter: _RowsPainter(),
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _controller,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.85, end: 1).animate(
                  CurvedAnimation(
                      parent: _controller, curve: Curves.easeOutBack),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2FD66D), Color(0xFF0E7A3A)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.green.withAlpha((0.45 * 255).round()),
                            blurRadius: 45,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.eco_rounded,
                          color: Colors.white, size: 46),
                    ),
                    const SizedBox(height: 26),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            color: Colors.white),
                        children: [
                          TextSpan(text: 'HydroSense '),
                          TextSpan(
                              text: 'AI',
                              style: TextStyle(color: Color(0xFF4ADE80))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Intelligent Hydroponic Monitoring System',
                      style: TextStyle(color: Color(0xFF8FA196), fontSize: 13),
                    ),
                    const SizedBox(height: 52),
                    const SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        color: Color(0xFF4ADE80),
                        backgroundColor: Color(0x334ADE80),
                        minHeight: 5,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'CALIBRATING SENSOR NETWORK',
                      style: TextStyle(
                        color: Color(0xFF5C7267),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints three faint rows of dots to evoke hydroponic growing channels.
class _RowsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1F5C37)
      ..strokeWidth = 2;
    final dotPaint = Paint()..color = const Color(0xFF2FD66D);

    final rows = [40.0, 70.0, 100.0];
    for (final y in rows) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    for (var i = 0; i < rows.length; i++) {
      final offset = i.isEven ? 30.0 : 50.0;
      for (double x = offset; x < size.width; x += 40) {
        canvas.drawCircle(Offset(x, rows[i]), 6, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
