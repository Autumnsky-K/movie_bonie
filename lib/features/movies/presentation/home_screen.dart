import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Bonie'),
      ),
      body: const Center(
        child: Text('인기 영화 목록이 여기에 표시됩니다.'),
      ),
    );
  }
}
