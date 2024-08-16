# Flutter에서의 Ticker 이해하기

## Ticker란?

Ticker는 "시간 알리미"라고 생각하면 쉽습니다.

- 화면 갱신 시마다 알림을 보내는 역할
- 보통 초당 60번 알림 (60fps 화면 기준)

## Ticker의 주요 특징

1. 정확한 타이밍:
   - 화면 갱신과 동기화되어 부드러운 애니메이션 가능

2. 효율성:
   - 필요할 때만 동작, 불필요한 리소스 사용 방지

3. 단일 콜백:
   - 한 번에 하나의 콜백 함수만 등록 가능

## Ticker 사용 예시

```dart
class MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = this.createTicker((elapsed) {
      // 매 프레임마다 실행될 코드
      print('경과 시간: $elapsed');
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
```

## Ticker와 애니메이션

1. AnimationController와의 관계:
   - AnimationController는 내부적으로 Ticker 사용
   - 애니메이션 값 계산에 Ticker의 타이밍 활용

2. 사용 예:
   ```dart
   final controller = AnimationController(
     vsync: this, // Ticker 제공자
     duration: Duration(seconds: 1),
   );
   ```

## Ticker의 장점

1. 성능 최적화:
   - 화면 갱신과 동기화되어 효율적인 리소스 사용

2. 부드러운 애니메이션:
   - 일정한 간격의 알림으로 끊김 없는 애니메이션 구현

3. 백그라운드 동작 제어:
   - 앱이 백그라운드로 갈 때 자동으로 중지

## 주의사항

1. 메모리 관리:
   - 사용 후 반드시 dispose 호출 필요

2. 과도한 사용 주의:
   - 너무 많은 Ticker 사용 시 성능 저하 가능

## 정리

- Ticker: Flutter 애니메이션의 "심장박동"
- 정확하고 효율적인 시간 기반 작업 수행
- AnimationController와 함께 부드러운 애니메이션 구현의 핵심

