import 'package:animation101/basic.dart';
import 'package:animation101/custom.dart';
import 'package:animation101/multi.dart';
import 'package:animation101/ticker.dart';
import 'package:animation101/timer.dart';
import 'package:animation101/transformation.dart';
import 'package:flutter/material.dart';
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
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransformAnimationPage()),
                );
              },
              child: const Text('Transform-based Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
