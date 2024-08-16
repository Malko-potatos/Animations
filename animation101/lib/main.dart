import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BasicAnimationPage()),
                );
              },
              child: const Text('Basic Animation'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomAnimationPage()),
                );
              },
              child: const Text('Custom Bouncing Animation'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MultiAnimationPage()),
                );
              },
              child: const Text('Multi Animation'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TickerAnimationPage()),
                );
              },
              child: const Text('Ticker-based Animation'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TimerAnimationPage()),
                );
              },
              child: const Text('Timer-based Animation (Choppy)'),
            ),
          ],
        ),
      ),
    );
  }
}

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

    ticker = this.createTicker((Duration elapsed) {
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
