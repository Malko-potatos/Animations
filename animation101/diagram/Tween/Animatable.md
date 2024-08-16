# Flutter의 abstract class Animatable<T> 심층 분석

## 기본 정의

```dart
abstract class Animatable<T> {
  const Animatable();
  
  T transform(double t);
  
  Animation<T> animate(Animation<double> parent);
  
  Animatable<T> chain(Animatable<double> parent);
}
```

## 핵심 구성 요소

### 1. transform 메서드
```dart
T transform(double t);
```
- 목적: 입력값 t (0.0 ~ 1.0)를 목표 타입 T로 변환.
- 구현 필수: 모든 Animatable 서브클래스에서 반드시 구현해야 함.
- 활용: AnimationController의 value를 원하는 값 범위로 매핑.

### 2. animate 메서드
```dart
Animation<T> animate(Animation<double> parent);
```
- 기능: Animatable을 Animation 객체로 변환.
- 입력: Animation<double> 타입의 부모 애니메이션.
- 반환: Animation<T> 타입의 새로운 애니메이션 객체.
- 내부 동작: 
  1. 부모 애니메이션의 value 변화 감지.
  2. 변화된 value를 transform 메서드에 전달.
  3. 결과값을 새 Animation<T> 객체의 value로 설정.

### 3. chain 메서드
```dart
Animatable<T> chain(Animatable<double> parent);
```
- 목적: 여러 Animatable 객체의 연결.
- 동작 방식: 
  1. 부모 Animatable의 출력을 현재 Animatable의 입력으로 사용.
  2. 복합 변환 효과 생성.
- 활용: 복잡한 애니메이션 시퀀스나 효과 구현.

## 주요 서브클래스 상세 분석

### 1. Tween<T>
```dart
class Tween<T extends dynamic> extends Animatable<T> {
  Tween({required this.begin, required this.end});
  
  T begin;
  T end;
  
  @override
  T transform(double t) {
    return begin + (end - begin) * t;
  }
}
```
- 특징: 선형 보간 구현.
- 활용: 숫자, 색상, 크기 등의 기본적인 애니메이션.

### 2. ColorTween
```dart
class ColorTween extends Tween<Color?> {
  ColorTween({super.begin, super.end});
  
  @override
  Color? transform(double t) {
    return Color.lerp(begin, end, t);
  }
}
```
- 특징: Color.lerp 메서드를 사용한 색상 보간.
- 활용: 배경색, 텍스트 색상 등의 부드러운 변화.

### 3. CurveTween
```dart
class CurveTween extends Animatable<double> {
  CurveTween({required this.curve});
  
  final Curve curve;
  
  @override
  double transform(double t) {
    return curve.transform(t);
  }
}
```
- 특징: Curve 객체를 사용한 비선형 변환.
- 활용: 가속, 감속 등의 효과 구현.

## 고급 사용 예시

### 1. 복합 Animatable 생성
```dart
final complexAnimatable = Tween<double>(begin: 0, end: 100)
  .chain(CurveTween(curve: Curves.easeInOut))
  .chain(Tween<double>(begin: 100, end: 200));
```
- 설명: 0에서 100까지 선형 증가 후 ease-in-out 효과를 거쳐 200까지 증가.

### 2. 사용자 정의 Animatable
```dart
class BounceAnimatable extends Animatable<double> {
  @override
  double transform(double t) {
    return -9.8 * t * t + 10 * t;  // 간단한 포물선 운동
  }
}
```
- 활용: 물리 기반 애니메이션 효과 구현.

## Animatable의 성능 고려사항

1. **캐싱**: 복잡한 transform 로직의 경우 결과값 캐싱 고려.
2. **계산 복잡도**: transform 메서드의 효율적 구현 중요.
3. **메모리 사용**: 과도한 Animatable 객체 생성 주의.

Animatable<T>: Flutter 애니메이션 시스템의 유연성, 재사용성, 확장성 제공의 핵심 요소. 다양한 애니메이션 효과 구현의 기반.