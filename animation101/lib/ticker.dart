import 'dart:math';

import 'package:animation101/transformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerAnimationPage extends StatefulWidget {
  const TickerAnimationPage({super.key});

  @override
  TickerAnimationPageState createState() => TickerAnimationPageState();
}

class TickerAnimationPageState extends State<TickerAnimationPage>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;
  double angle = 0;

  @override
  void initState() {
    super.initState();

    ticker = createTicker((Duration elapsed) {
      setState(() {
        angle = (elapsed.inMilliseconds % 2000) / 2000 * 2 * pi;
      });
    });

    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticker-based Animation'),
      ),
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(angle),
          child: const SizedBox(
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
