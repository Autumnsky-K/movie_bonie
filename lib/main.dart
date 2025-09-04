import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_bonie/features/movies/presentation/favorites_screen.dart';
import 'package:movie_bonie/features/movies/presentation/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_bonie/features/movies/presentation/movie_detail_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/', // 앱이 처음 시작될 때 보여줄 경로
    routes: [
      // '/' 경로에 대한 설정
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      // 상세 페이지를 위한 새로운 라우트 추가
      GoRoute(
        path: '/movie/:id', // :id는 동적 세그먼트
        builder: (context, state) {
          // URL에서 :id 값을 추출
          final String id = state.pathParameters['id']!;
          return MovieDetailScreen(id: id);
        },
      ),
      // 내 보관함 페이지를 위한 새로운 라우트 추가
      GoRoute(
        path: '/favorites',
        builder: (context, state) {
          return const FavoritesScreen();
        },
      )
    ],
  );
});

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Movie Bonie',
    );
  }
}
