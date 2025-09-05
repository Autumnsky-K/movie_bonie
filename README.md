# MovieBonie - 영화 정보 앱

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/State%20Management-Riverpod-blue.svg)](https://riverpod.dev)
[![GoRouter](https://img.shields.io/badge/Routing-GoRouter-purple.svg)](https://pub.dev/packages/go_router)
[![Dio](https://img.shields.io/badge/API-Dio-green.svg)](https://pub.dev/packages/dio)

> 이 프로젝트는 Flutter의 기술 스택을 적용하고, **모던 Flutter 개발 역량**과 **클린 아키텍처 설계 능력**을 입증하기 위해 제작된 포트폴리오입니다.

## 📖 프로젝트 소개

**MovieBonie**는 OMDb API를 활용하여 영화 정보를 검색하고, 상세 내용을 확인하며, 좋아하는 영화를 저장할 수 있는 간단한 영화 정보 애플리케이션입니다.

이 프로젝트의 핵심 목표는 단순히 기능을 구현하는 것을 넘어, **유지보수와 확장에 용이한 아키텍처 설계, 성능 최적화, 그리고 최신 라이브러리 활용 능력**을 기르는 것입니다.

## ✨ 핵심 기능

| 기능 | 설명 |
| --- | --- |
| **영화 목록** | 앱 실행 시 기본 영화 목록을 표시합니다. |
| **영화 검색 (디바운싱 적용)** | 사용자 입력이 끝난 후에만 API를 호출하는 디바운싱을 적용하여 불필요한 네트워크 요청을 최소화하고 성능을 최적화했습니다. |
| **영화 상세 정보** | 특정 영화를 선택하면 상세 정보를 확인할 수 있습니다. |
| **좋아요 기능** | 마음에 드는 영화를 '내 보관함'에 저장하고 언제든지 다시 볼 수 있습니다. |

---

## 🚀 기술 탐구 (Tech Deep Dive)

이 프로젝트는 Flutter의 주요 라이브러리인 Riverpod와 GoRouter를 중심으로, 기존 방식 대비 어떤 장점이 있는지를 코드와 함께 보여줍니다.

### 1. 상태 관리: 왜 Provider가 아닌 Riverpod인가?

`Riverpod`는 `Provider`의 단점을 개선하여 등장한 차세대 상태 관리 라이브러리입니다. 이 프로젝트에서는 다음과 같은 `Riverpod`의 핵심 장점을 활용했습니다.

| 장점 | 설명 | 이 프로젝트의 활용 사례 |
| --- | --- | --- |
| **컴파일 타임 안정성** | 런타임에 발생하는 `ProviderNotFoundException` 오류를 컴파일 시점에 방지합니다. Provider는 위젯 트리 상위에 선언되어야 하지만, Riverpod는 전역적으로 선언되므로 찾지 못할 위험이 없습니다. | 모든 Provider를 전역 `final` 변수로 선언하여 어디서든 안전하게 참조합니다. |
| **`BuildContext`로부터의 독립** | Provider와 달리 `BuildContext`에 의존하지 않습니다. 이를 통해 UI와 비즈니스 로직을 더 완벽하게 분리할 수 있습니다. | `favoritesProvider.notifier`와 같은 비즈니스 로직을 위젯의 `build` 메서드 바깥에서도 쉽게 호출하고 테스트할 수 있습니다. |
| **간결하고 강력한 비동기 처리** | `FutureProvider`와 `StreamProvider`를 기본으로 제공하여, 비동기 데이터의 `loading`, `data`, `error` 상태를 `when` 메서드로 매우 간결하게 처리할 수 있습니다. | `moviesProvider`, `movieDetailProvider` 등 API 통신이 필요한 모든 곳에서 `FutureProvider`를 사용하여 UI 코드의 복잡도를 획기적으로 줄였습니다. |
| **더 나은 상태 관리 모델** | `ChangeNotifier`의 단점(mutable state, `notifyListeners()` 수동 호출)을 개선한 `Notifier`를 제공하여, 불변(immutable) 상태를 더 쉽고 안전하게 관리할 수 있습니다. | `favoritesProvider`에 `Notifier`를 사용하여 '좋아요' 목록을 추가/제거하는 로직을 타입-세이프하고 예측 가능하게 구현했습니다. |

### 2. 라우팅: 왜 전통적인 Navigation이 아닌 GoRouter인가?

Flutter의 기본 `Navigator` API는 간단한 앱에서는 유용하지만, 앱이 복잡해질수록 한계에 부딪힙니다. `GoRouter`는 이러한 한계를 극복하기 위한 강력한 URL 기반 라우팅 솔루션입니다.

| | `Navigator 1.0` (전통 방식) | `GoRouter` |
| --- | --- | --- |
| **장점** | - 사용법이 매우 간단 (`Navigator.push`)<br>- 별도 라이브러리 불필요 | - **URL 기반**: 딥링킹, 웹 표준 준수<br>- **중앙 관리**: 모든 경로를 한 곳에서 관리<br>- **타입 세이프**: 파라미터 전달 시 타입 안정성 확보<br>- **고급 기능**: 리다이렉션, 중첩 라우팅 지원 |
| **단점** | - URL 기반이 아님 (웹/딥링킹 취약)<br>- 경로가 앱 전체에 흩어져 관리가 어려움<br>- 파라미터 전달이 타입-세이프하지 않음 | - 간단한 앱에는 과할 수 있음<br>- 초기 설정이 `Navigator`보다 복잡함 |
| **결론** | 간단한 앱이나 특정 플로우에 적합 | 중규모 이상의 앱, 웹 지원, 딥링킹이 필요한 경우 필수적 |

이 프로젝트에서는 `GoRouter`를 사용하여 `/movie/:id`와 같은 **동적 경로**를 구현했습니다. 이를 통해 사용자가 특정 영화를 선택했을 때, 해당 영화의 `id`를 URL 경로에 포함시켜 상세 페이지로 이동하는 기능을 매우 직관적이고 안정적으로 구현할 수 있었습니다.

### 3. 아키텍처: Repository Pattern
- **관심사 분리 (SoC)**: Presentation(UI) - Domain(Model) - Data(Repository)의 3-Layer로 계층을 명확히 분리하여 코드의 결합도를 낮추고 테스트 용이성을 높였습니다.
    - **Presentation Layer**: Riverpod Provider를 통해 데이터를 받고, UI 상태(로딩, 데이터, 에러)에 따라 화면을 렌더링하는 역할에만 집중합니다.
    - **Data Layer (`Repository`)**: `Dio`를 사용한 API 통신, 데이터 파싱 등 데이터 소스와 관련된 모든 로직을 캡슐화합니다. UI는 데이터가 어디서 오는지 알 필요가 없습니다.
- **데이터 흐름:**
  `UI Widgets -> Riverpod Providers -> Repository -> Dio (API)`

### 4. 성능 최적화
- **Debouncing**: 영화 검색 기능에 `Timer`를 이용한 디바운싱을 적용했습니다. 사용자가 타이핑을 멈춘 후에만 API 요청이 발생하도록 하여, 불필요한 네트워크 트래픽을 줄이고 앱의 반응성을 향상시켰습니다.
- **Provider Caching (In-Memory)**: `Riverpod`의 **메모리 내(in-memory)** 캐싱 기능을 활용하여, 한 번 불러온 데이터는 메모리에 저장해두고 재사용함으로써 불필요한 API 호출을 방지합니다. (앱 재시작 시 사라짐)
- **GridView.builder**: 화면에 보이는 위젯만 렌더링하는 `builder` 생성자를 사용하여 대량의 데이터를 효율적으로 처리합니다.

## ⚙️ 실행 방법

1.  **API 키 설정**
    - 프로젝트 루트 디렉터리에 `.env` 파일을 생성하고 아래와 같이 OMDb API 키를 추가합니다.
    ```
    OMDB_API_KEY=your_api_key
    ```

2.  **의존성 설치**
    ```bash
    fvm flutter pub get
    ```

3.  **앱 실행**
    ```bash
    fvm flutter run
    ```

## 📚 사용된 주요 라이브러리

- `flutter_riverpod`: 상태 관리
- `go_router`: 라우팅
- `dio`: HTTP 통신
- `flutter_dotenv`: 환경 변수 관리


---

## 💡 구현 예정 기능 (TODO)

### 1. 데이터 모델 리팩토링 (`Freezed` & `json_serializable` 활용)

-   **현재 상태:** `Movie`, `MovieDetail` 등의 데이터 클래스가 수동으로 작성되어 있으며, `fromJson` 메서드 또한 직접 구현되어 있습니다.
-   **개선 방안:**
    1.  `freezed`를 사용하여 데이터 모델을 불변(immutable) 클래스로 전환합니다. 이를 통해 `copyWith`, `toString`, `==` 비교 등 보일러플레이트 코드가 자동으로 생성되어 코드의 안정성과 가독성이 크게 향상됩니다.
    2.  `json_serializable`을 `freezed`와 함께 사용하여, `fromJson`/`toJson` 로직을 수동으로 작성할 필요 없이 코드 생성으로 자동화합니다.
-   **기대 효과:** 모델 코드의 간결화, 런타임 에러 감소, 유지보수성 증대.

### 2. 서비스 로케이터 도입 (`get_it` 활용)

-   **현재 상태:** `Dio`와 같은 서비스 객체를 `Riverpod`의 `Provider`를 통해 주입하고 있습니다.
-   **개선 방안:**
    1.  `get_it`을 사용하여 `Dio` 인스턴스와 같이 앱 전역에서 단일 인스턴스로 관리되어야 하는 서비스들을 등록합니다.
    2.  `MovieRepository`에서 `Riverpod`의 `ref` 대신 `get_it` 로케이터를 통해 `Dio` 인스턴스를 주입받도록 구조를 변경해 봅니다.
-   **기대 효과:** `Riverpod`는 UI 상태 관리에 더 집중하고, `get_it`은 서비스 의존성 주입에 집중하는 역할 분리를 통해 아키텍처의 관심사를 더 명확하게 나눌 수 있습니다.

### 3. 로컬 캐싱(Local Caching) 기능 구현

-   **현재 상태:** 앱을 실행할 때마다 네트워크를 통해 영화 데이터를 새로 가져옵니다.
-   **개선 방안:**
    1.  `dio-http-cache`와 같은 `Dio` 인터셉터 라이브러리나 `Hive` 같은 로컬 DB를 사용하여 API 응답을 로컬에 캐싱하는 레이어를 추가합니다.
    2.  `MovieRepository`에서 네트워크 요청 전에 먼저 로컬 캐시를 확인하도록 로직을 수정합니다.
-   **기대 효과:** 반복적인 API 호출을 줄여 앱 로딩 속도를 개선하고, 간단한 오프라인 상태에서도 이전에 불러온 데이터를 보여줄 수 있습니다.

### 4. "좋아요" 목록 영구 저장 (`shared_preferences` 활용)

-   **현재 상태:** "좋아요" 목록은 앱이 실행 중일 때만 메모리에 유지되며, 앱을 재시작하면 초기화됩니다.
-   **개선 방안:**
    1.  `shared_preferences` 라이브러리를 사용하여 "좋아요"한 영화 목록을 디바이스에 저장합니다.
    2.  `FavoritesNotifier`가 초기화될 때 저장된 목록을 불러오고, "좋아요" 상태가 변경될 때마다 디바이스에 갱신된 목록을 저장하도록 로직을 수정합니다.
    3.  `Movie` 객체를 JSON 문자열로 변환하기 위해 `toJson` 메서드를 모델에 추가합니다.
-   **기대 효과:** 사용자가 "좋아요"한 영화 목록이 앱을 재시작해도 유지되어 사용자 경험이 크게 향상됩니다.
