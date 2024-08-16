# Flutter에서의 Curve 이해하기

## Curve란?

`Curve`는 Tween의 선형 보간을 좀 더 자연스럽게 만들어주는 **"곡선"**입니다.

- **비선형 보간**: 시간에 따른 값의 변화를 곡선 형태로 지정
- **대표적인 Curve**: `Curves.easeIn`, `Curves.easeOut`, `Curves.bounce`

## Curve의 주요 특징

1. **비선형 보간**:
   - 선형이 아닌 곡선 형태로 값을 변화시켜, 보다 자연스러운 애니메이션 효과 가능

2. **다양한 곡선 제공**:
   - Flutter에서 미리 정의된 여러 곡선을 사용 가능 (`Curves` 클래스)

3. **애니메이션의 감성 추가**:
   - 단순한 선형 애니메이션 대신, 가속도나 감속도를 추가해 다양한 효과를 구현

## Curve 사용 예시

```dart
_animation = Tween<double>(begin: 0.0, end: 1.0)
  .animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));
```

- **`CurvedAnimation`**: `Animation`을 `Curve`와 함께 사용하여 비선형 애니메이션을 구현
- **`Curves.easeInOut`**: 천천히 시작해서, 중간에 빠르게, 그리고 천천히 끝나는 효과를 적용

## LinearType Tween과 Non-Linear Curve의 차이점

1. **LinearType Tween**:
   - **선형 애니메이션**: 일정한 속도로 애니메이션이 진행됩니다.
   - **사용 예**: 단순한 상태 변화 (예: 페이드 인/아웃)

2. **Non-Linear Curve**:
   - **비선형 애니메이션**: 속도가 일정하지 않고, 가속도나 감속도가 추가됩니다.
   - **사용 예**: 자연스러운 애니메이션 효과 (예: 물체의 중력 효과, 스프링 효과)

## Non-Linear Curve 사용 예시

```dart
_animation = Tween<double>(begin: 0.0, end: 1.0)
  .animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  ));
```

- **`Curves.bounceOut`**: 애니메이션이 빠르게 진행되다가 끝에 가서 튕기는 효과를 구현


## 정리

- **Curve**: Tween의 선형 보간을 비선형으로 변화시켜 자연스러운 애니메이션 효과를 제공
- **Linear vs Non-Linear**: 일정한 속도의 애니메이션과 다양한 속도로 진행되는 애니메이션의 차이점 이해

