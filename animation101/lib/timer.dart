import 'dart:async';
import 'dart:math';

import 'package:animation101/transformation.dart';
import 'package:flutter/material.dart';

class TimerAnimationPage extends StatefulWidget {
  const TimerAnimationPage({super.key});

  @override
  TimerAnimationPageState createState() => TimerAnimationPageState();
}

class TimerAnimationPageState extends State<TimerAnimationPage> {
  double angle = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        angle = (angle + 0.1) % (2 * pi);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer-based Animation (Choppy)'),
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
