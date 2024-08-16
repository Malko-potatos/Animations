import 'package:flutter/material.dart';

class MultiAnimationPage extends StatefulWidget {
  const MultiAnimationPage({super.key});

  @override
  MultiAnimationPageState createState() => MultiAnimationPageState();
}

class MultiAnimationPageState extends State<MultiAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    animation1 = Tween<double>(begin: 50, end: 200).animate(controller1);

    animation2 = Tween<double>(begin: 100, end: 300).animate(controller2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Animation'),
      ),
      body: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: animation1,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  left: 50,
                  top: 50,
                  child: Container(
                    width: animation1.value,
                    height: animation1.value,
                    color: Colors.green,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: animation2,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  right: 50,
                  bottom: 50,
                  child: Container(
                    width: animation2.value,
                    height: animation2.value,
                    color: Colors.orange,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}
