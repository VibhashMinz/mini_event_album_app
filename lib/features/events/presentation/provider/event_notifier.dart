import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_event_album_app/app/providers.dart';
import 'package:mini_event_album_app/features/events/domain/repositories/events_repository.dart';

import '../../domain/entities/event.dart';

final eventsProvider = StateNotifierProvider<EventsNotifier, AsyncValue<List<Event>>>((ref) {
  final repo = ref.read(eventsRepositoryProvider);
  return EventsNotifier(repo);
});

class EventsNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  EventsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchFirstPage();
  }

  final EventsRepository _repository;
  int _page = 1;
  final int _limit = 10;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  Future<void> fetchFirstPage() async {
    try {
      final events = await _repository.getEvents(page: _page, limit: _limit);
      _hasMore = events.length == _limit;
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchNextPage() async {
    if (_isFetchingMore || !_hasMore) return;
    _isFetchingMore = true;
    _page++;
    try {
      final newEvents = await _repository.getEvents(page: _page, limit: _limit);
      _hasMore = newEvents.length == _limit;

      state.whenData((exisiting) {
        state = AsyncValue.data([...exisiting, ...newEvents]);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetchingMore = false;
    }
  }

  bool get hasMore => _hasMore;
}
