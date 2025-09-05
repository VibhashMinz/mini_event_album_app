import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_event_album_app/features/events/presentation/screen/event_screen.dart';

import '../features/auth/presentation/auth_screen.dart';

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthScreen()),
    GoRoute(
      path: '/events',
      builder: (context, state) => const EventsScreen(),
    )
  ]);
});
