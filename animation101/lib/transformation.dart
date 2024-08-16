import 'dart:math';

import 'package:flutter/material.dart';

class TransformAnimationPage extends StatefulWidget {
  const TransformAnimationPage({super.key});

  @override
  TransformAnimationPageState createState() => TransformAnimationPageState();
}

class TransformAnimationPageState extends State<TransformAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform-based Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value, // 애니메이션 값에 따라 회전
              child: child,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double angle;

  CirclePainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final x = center.dx + radius * cos(angle);
    final y = center.dy + radius * sin(angle);

    canvas.drawCircle(Offset(x, y), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
