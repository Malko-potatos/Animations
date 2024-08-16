## TickerFuture

### 설명
- `TickerFuture`는 Flutter의 애니메이션 시스템에서 사용되는 클래스 중 하나로, `Ticker`가 특정 애니메이션 또는 작업을 완료했을 때의 결과를 나타냄
- `TickerFuture`는 `Future<void>`의 일종으로, `Ticker`가 완료될 때까지 비동기적으로 작업을 기다리게 함.

### 주요 기능
- **Ticker 완료 대기**: `Ticker`가 애니메이션을 완료할 때까지 대기하거나, 도중에 `cancel` 되었을 때 적절한 후속 작업을 처리하는 데 사용됨.
- **Future-like 행동**: `TickerFuture`는 `Future<void>`와 유사하게 `then`, `whenComplete`, `catchError` 등의 메서드를 지원하여 작업 완료 후에 추가 작업을 연결할 수 있음.

### 사용 예시
`AnimationController`를 사용하는 Flutter 애니메이션에서 `TickerFuture`는 애니메이션이 시작되거나 종료될 때 반환됩니다. 이를 통해 애니메이션이 끝난 후 어떤 작업을 수행하도록 할 수 있음.

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  void _startAnimation() {
    TickerFuture tickerFuture = _controller.forward();
    
    tickerFuture.whenComplete(() {
      // 애니메이션이 끝난 후 실행될 코드
      print("Animation completed");
    }).orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _startAnimation,
      child: Text('Start Animation'),
    );
  }
}
```

### 주요 메서드

1. **whenComplete()**
   - 애니메이션이 끝난 후 실행할 작업을 정의하는 메서드
   - `whenComplete` 안에 정의된 코드는 애니메이션이 정상적으로 완료된 후에 호출

2. **orCancel**
   - 애니메이션이 중간에 취소되었을 때, 예외를 던지거나 취소 작업을 처리
   - `orCancel`은 `Future<void>`를 반환하며, 애니메이션이 취소된 경우에 예외 처리를 가능하게 하게함

### 사용 시나리오
- **애니메이션 후속 작업**: 애니메이션이 완료된 후 특정 작업을 비동기적으로 실행해야 할 때 유용함
- **애니메이션 취소 처리**: 사용자가 애니메이션 도중에 애니메이션을 중단하거나 다른 작업으로 전환할 때, 필요한 정리 작업을 수행할 수 있음
- **동기화 제어**: 여러 애니메이션이나 작업 간의 동기화를 위해 `TickerFuture`를 활용할 수 있습니다.

### 요약
- `TickerFuture`는 Flutter에서 `Ticker`가 완료될 때의 비동기 작업을 관리하는 클래스.
- `whenComplete`와 `orCancel` 메서드를 사용해 애니메이션 종료 후의 작업 처리와 취소에 대한 처리 가능.
- 애니메이션 후속 작업, 애니메이션 취소 처리, 동기화 제어에 유용.