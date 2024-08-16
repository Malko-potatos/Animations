
1. AnimationController 생성자에서 시작:
   ```dart
   AnimationController({
     // ... 다른 매개변수들 ...
     required TickerProvider vsync,
   }) {
     // ...
     _ticker = vsync.createTicker(_tick);
     // ...
   }
   ```

2. vsync.createTicker(_tick) 호출:
   - vsync (TickerProvider)를 통해 Ticker 객체를 생성.
   - _tick 메서드를 Ticker의 콜백으로 등록.

3. 애니메이션 시작 시 (예: forward(), reverse(), animateTo() 등 호출 시):
   ```dart
   TickerFuture _startSimulation(Simulation simulation) {
     // ...
     final TickerFuture result = _ticker!.start();
     // ...
     return result;
   }
   ```
   - _ticker.start()를 호출하여 Ticker를 시작.

4. Ticker 내부에서:
   - Ticker는 SchedulerBinding.instance.scheduleFrameCallback()를 사용하여 vsync 신호에 맞춰 프레임 콜백을 스케줄링.

5. 프레임 발생 시:
   - 스케줄된 콜백이 호출되고, 이는 AnimationController의 _tick 메서드를 트리거:
   ```dart
   void _tick(Duration elapsed) {
     _lastElapsedDuration = elapsed;
     final double elapsedInSeconds = elapsed.inMicroseconds.toDouble() / Duration.microsecondsPerSecond;
     assert(elapsedInSeconds >= 0.0);
     _value = clampDouble(_simulation!.x(elapsedInSeconds), lowerBound, upperBound);
     // ... 나머지 로직 ...
   }
   ```

