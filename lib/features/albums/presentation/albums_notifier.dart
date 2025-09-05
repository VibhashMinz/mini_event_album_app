// lib/features/albums/presentation/state/albums_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/album.dart';
import '../domain/repositories/albums_repository.dart';

class AlbumsNotifier extends StateNotifier<AsyncValue<List<Album>>> {
  final AlbumsRepository repository;
  final String eventId;

  int _page = 1;
  final int _limit = 5;
  bool _hasMore = true;

  AlbumsNotifier({required this.repository, required this.eventId}) : super(const AsyncValue.loading()) {
    fetchAlbums();
  }

  Future<void> fetchAlbums({bool loadMore = false}) async {
    if (loadMore && !_hasMore) return;

    if (!loadMore) {
      state = const AsyncValue.loading();
      _page = 1;
      _hasMore = true;
    }

    try {
      final newAlbums = await repository.getAlbumsByEventId(
        eventId,
        page: _page,
        limit: _limit,
      );

      if (newAlbums.length < _limit) _hasMore = false;

      if (loadMore) {
        state = state.whenData((old) => [...old, ...newAlbums]);
      } else {
        state = AsyncValue.data(newAlbums);
      }

      _page++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  bool get hasMore => _hasMore;
}
