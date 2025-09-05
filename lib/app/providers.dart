import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dio_client.dart';
import '../features/events/data/source/event_api.dart';
import '../features/events/data/source/events_api_base.dart';
import '../features/events/data/source/mock_events_api.dart';
import '../features/events/data/repositories/events_repository_impl.dart';
import '../features/events/domain/entities/event.dart';
import '../features/events/domain/repositories/events_repository.dart';
import '../features/events/presentation/provider/event_notifier.dart';

final useMockApiProvider = Provider<bool>((ref) => true);

final dioClientProvider = Provider((ref) => DioClient(baseUrl: "https://api.example.com"));

final eventsApiProvider = Provider<EventsApiBase>((ref) {
  final useMock = ref.watch(useMockApiProvider);
  if (useMock) {
    return EventsApiMock();
  } else {
    final dioClient = ref.watch(dioClientProvider);
    return EventsApi(dioClient: dioClient);
  }
});

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final api = ref.watch(eventsApiProvider);
  return EventsRepositoryImpl(eventsApi: api);
});

final eventsProvider = StateNotifierProvider<EventsNotifier, AsyncValue<List<Event>>>(
  (ref) {
    final repository = ref.watch(eventsRepositoryProvider);
    return EventsNotifier(repository);
  },
);
