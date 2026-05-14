import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/login_screen.dart';

void main() => runApp(const MyApp());

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBM Shop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          body: Center(
            child: SizedBox(
              width: 420,
              height: 900,
              child: CustomPaint(
                painter: IPhone16OrangePainter(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 14, 13, 14),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(46),
                    child: Stack(
                      children: [
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            padding: const EdgeInsets.only(
                                top: 62, bottom: 12),
                          ),
                          child: child!,
                        ),
                        
                        Positioned(
                          top: 14, left: 0, right: 0,
                          child: Center(
                            child: Container(
                              width: 130, height: 36,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      home: const LoginScreen(),
    );
  }
}

class IPhone16OrangePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final r = const Radius.circular(58);

    
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(6, 12, w - 12, h - 12), r),
        Paint()
          ..color = Colors.black.withOpacity(0.55)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28));

    
    final bodyRect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, w, h), r);
    canvas.drawRRect(bodyRect, Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFF9A5C), Color(0xFFEE6820),
          Color(0xFFD4501A), Color(0xFFB03A10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h)));

    
    canvas.drawRRect(bodyRect, Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.22),
          Colors.white.withOpacity(0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, w * 0.45, h)));

    
    canvas.drawRRect(bodyRect, Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.18), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.center,
      ).createShader(Rect.fromLTWH(0, 0, w, h * 0.4)));

    
    canvas.drawRRect(bodyRect, Paint()
      ..color = const Color(0xFF8B3010).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);

    
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.032, h * 0.016, w * 0.936, h * 0.968),
            const Radius.circular(46)),
        Paint()..color = Colors.black);

    
    _btn(canvas, x: -3.5, y: h * 0.18, bw: 4, bh: h * 0.055);
    _btn(canvas, x: -3.5, y: h * 0.26, bw: 4, bh: h * 0.075);
    _btn(canvas, x: -3.5, y: h * 0.36, bw: 4, bh: h * 0.075);
    
    _btn(canvas, x: w - 0.5, y: h * 0.26, bw: 4, bh: h * 0.11);

    
    final camRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.06, h * 0.74, w * 0.38, h * 0.2),
        const Radius.circular(18));
    canvas.drawRRect(camRect, Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFA03010), Color(0xFF7A2008)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(w * 0.06, h * 0.74, w * 0.38, h * 0.2)));
    canvas.drawRRect(camRect, Paint()
      ..color = const Color(0xFF601808).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);

    
    _lens(canvas, cx: w * 0.165, cy: h * 0.785, r: w * 0.085);
    _lens(canvas, cx: w * 0.335, cy: h * 0.785, r: w * 0.085);
    _lens(canvas, cx: w * 0.165, cy: h * 0.885, r: w * 0.065, small: true);

    
    canvas.drawCircle(Offset(w * 0.335, h * 0.885), w * 0.04, Paint()
      ..shader = RadialGradient(
        colors: [const Color(0xFFFFEEAA), const Color(0xFFDDAA44)],
      ).createShader(Rect.fromCircle(
          center: Offset(w * 0.335, h * 0.885), radius: w * 0.04)));
    canvas.drawCircle(Offset(w * 0.335, h * 0.885), w * 0.04, Paint()
      ..color = const Color(0xFF886600).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);

    
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.38, h * 0.978, w * 0.24, h * 0.016),
            const Radius.circular(3)),
        Paint()..color = const Color(0xFF7A2008).withOpacity(0.7));

    
    for (int i = 0; i < 4; i++) {
      final sp = Paint()..color = const Color(0xFF7A2008).withOpacity(0.5);
      canvas.drawCircle(Offset(w * 0.18 + i * w * 0.028, h * 0.984), w * 0.008, sp);
      canvas.drawCircle(Offset(w * 0.68 + i * w * 0.028, h * 0.984), w * 0.008, sp);
    }
  }

  void _btn(Canvas canvas, {
    required double x, required double y,
    required double bw, required double bh,
  }) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, bw, bh), const Radius.circular(3)),
        Paint()
          ..shader = LinearGradient(
            colors: [
              const Color(0xFFC04010).withOpacity(0.9),
              const Color(0xFFC04010).withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(x, y, bw, bh)));
  }

  void _lens(Canvas canvas, {
    required double cx, required double cy,
    required double r, bool small = false,
  }) {
    canvas.drawCircle(Offset(cx, cy), r, Paint()
      ..color = const Color(0xFF601808).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);
    canvas.drawCircle(Offset(cx, cy), r * 0.88, Paint()
      ..shader = RadialGradient(
        colors: [const Color(0xFF2A3A5A), const Color(0xFF0D1422)],
        stops: const [0.3, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)));
    canvas.drawCircle(Offset(cx - r * 0.25, cy - r * 0.25), r * 0.3, Paint()
      ..color = Colors.white.withOpacity(small ? 0.12 : 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));
    canvas.drawCircle(Offset(cx, cy), r * 0.65, Paint()
      ..color = const Color(0xFF334466).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}