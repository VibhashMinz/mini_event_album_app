import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/photo.dart';
import '../domain/repositories/photos_repository.dart';

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
