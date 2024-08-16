import 'dart:math';

import 'package:flutter/material.dart';

class CustomBouncingAnimation extends Animatable<double> {
  @override
  double transform(double t) {
    return t < 0.5 ? 16 * t * t * t * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
  }
}

class CustomAnimationPage extends StatefulWidget {
  const CustomAnimationPage({super.key});

  @override
  CustomAnimationPageState createState() => CustomAnimationPageState();
}

class CustomAnimationPageState extends State<CustomAnimationPage>
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

    animation = CustomBouncingAnimation().animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Bouncing Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: 50 + animation.value * 150,
              height: 50 + animation.value * 150,
              color: Colors.red,
            );
          },
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
