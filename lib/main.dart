import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/', // 앱이 처음 시작될 때 보여줄 경로
    routes: [
      // '/' 경로에 대한 설정
      GoRoute(
        path: '/',
        builder: (context, state) {
          // TODO 홈화면위젯으로 교체 필요
          return const Scaffold(
              body: Center(
            child: Text('Home Screen'),
          ));
        },
      ),
    ],
  );
});

void main() {
  runApp(const ProviderScope(child: MainApp()));
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
