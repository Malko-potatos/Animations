import 'package:flutter/material.dart';

class BasicAnimationPage extends StatefulWidget {
  const BasicAnimationPage({super.key});

  @override
  BasicAnimationPageState createState() => BasicAnimationPageState();
}

class BasicAnimationPageState extends State<BasicAnimationPage>
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

    animation = Tween<double>(begin: 50, end: 200).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: animation.value,
              height: animation.value,
              color: Colors.blue,
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
