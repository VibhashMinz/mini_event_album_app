import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/dio_client.dart';
import '../features/albums/data/repositories/albums_repository_impl.dart';
import '../features/albums/data/sources/album_api_mock.dart';
import '../features/albums/data/sources/albums_api.dart';
import '../features/albums/data/sources/albums_api_base.dart';
import '../features/albums/domain/entities/album.dart';
import '../features/albums/domain/repositories/albums_repository.dart';
import '../features/albums/presentation/albums_notifier.dart';
import '../features/events/data/source/event_api.dart';
import '../features/events/data/source/events_api_base.dart';
import '../features/events/data/source/mock_events_api.dart';
import '../features/events/data/repositories/events_repository_impl.dart';
import '../features/events/domain/entities/event.dart';
import '../features/events/domain/repositories/events_repository.dart';
import '../features/events/presentation/provider/event_notifier.dart';
import '../photos/data/sources/photos_api.dart';
import '../photos/data/repositories/photos_repository_impl.dart';
import '../photos/domain/entities/photo.dart';
import '../photos/domain/repositories/photos_repository.dart';

final useMockApiProvider = Provider<bool>((ref) => false);

final dioClientProvider = Provider((ref) => DioClient(baseUrl: "https://68bb6fa684055bce63f1ec49.mockapi.io"));

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

/// ALBUMS
final albumsApiProvider = Provider<AlbumsApiBase>((ref) {
  final useMock = ref.watch(useMockApiProvider);
  if (useMock) {
    return AlbumsApiMock();
  } else {
    final dioClient = ref.watch(dioClientProvider);
    return AlbumsApi(dioClient);
  }
});

final albumsRepositoryProvider = Provider<AlbumsRepository>((ref) {
  final albumsApi = ref.watch(albumsApiProvider);
  return AlbumsRepositoryImpl(albumsApi: albumsApi);
});

final albumsNotifierProvider = StateNotifierProvider.family<AlbumsNotifier, AsyncValue<List<Album>>, String>(
  (ref, eventId) {
    final repo = ref.watch(albumsRepositoryProvider);
    return AlbumsNotifier(repository: repo, eventId: eventId);
  },
);

///PHOTO
final photosApiProvider = Provider<PhotosApiBase>((ref) {
  final useMock = ref.watch(useMockApiProvider);
  if (useMock) {
    return PhotosApiMock();
  } else {
    final dioClient = ref.watch(dioClientProvider);
    return PhotosApi(dioClient: dioClient);
  }
});

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  final api = ref.watch(photosApiProvider);
  return PhotosRepositoryImpl(photosApi: api);
});

final photosByAlbumProvider = StateNotifierProvider.family<PhotosNotifier, AsyncValue<List<Photo>>, String>((ref, albumId) {
  final repo = ref.watch(photosRepositoryProvider);
  return PhotosNotifier(repository: repo, albumId: albumId);
});

class PhotosNotifier extends StateNotifier<AsyncValue<List<Photo>>> {
  PhotosNotifier({required this.repository, required this.albumId}) : super(const AsyncLoading()) {
    _loadPhotos();
  }

  final PhotosRepository repository;
  final String albumId;

  Future<void> _loadPhotos() async {
    try {
      final photos = await repository.getPhotosByAlbumId(albumId);
      state = AsyncData(photos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updatePhotoLike(String photoId, bool liked) async {
    final current = state.value ?? [];
    // Optimistic update
    final updated = current.map((p) => p.id == photoId ? p.copyWith(liked: liked) : p).toList();
    state = AsyncData(updated);

    try {
      await repository.togglePhotoLike(photoId, liked);
    } catch (e) {
      // revert if API fails
      state = AsyncData(
        current,
      );
    }
  }
}
