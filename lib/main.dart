import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_event_album_app/app/theme.dart';

import 'app/router.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mini Event Album',
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
