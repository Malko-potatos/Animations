# Flutter에서 Tween과 Animatable 이해하기

## Tween 기본 개념

Tween은 "중간값 계산기"라고 생각하세요.

예시:
```dart
final numberTween = Tween<double>(begin: 0, end: 100);
```
- 0에서 100 사이의 모든 값을 계산할 수 있음

## Tween 작동 방식

1. 시작값과 끝값 설정
2. 진행 정도(0~1 사이 숫자) 입력
3. 해당 지점의 값 계산

예:
```dart
print(numberTween.transform(0.5)); // 50 출력
```

## Animatable 이해하기

Animatable은 "값 변환기"입니다.

- Tween은 Animatable의 한 종류
- 더 복잡한 변환도 가능

## Animatable 예시

사용자 정의 Animatable:
```dart
class SquareAnimatable extends Animatable<double> {
  @override
  double transform(double t) {
    return t * t; // 0~1 사이 값을 제곱
  }
}
```

## Tween과 Animatable 사용

애니메이션 컨트롤러와 함께 사용:
```dart
final controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
final animation = numberTween.animate(controller);

// 또는
final squareAnimation = SquareAnimatable().animate(controller);
```

## 실제 위젯에서 사용

```dart
AnimatedBuilder(
  animation: animation,
  builder: (context, child) {
    return Container(
      width: animation.value, // 애니메이션 값으로 너비 조절
      height: 50,
      color: Colors.blue,
    );
  },
)
```

## 핵심 포인트

1. Tween: 시작과 끝 사이의 값 계산
2. Animatable: 더 일반적인 값 변환 방법
3. 둘 다 애니메이션 값을 생성하는 도구
4. AnimationController와 함께 사용하여 실제 애니메이션 구현

