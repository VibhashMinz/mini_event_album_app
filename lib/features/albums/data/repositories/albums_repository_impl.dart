import '../../domain/entities/album.dart';
import '../../domain/repositories/albums_repository.dart';

import '../sources/albums_api_base.dart';

class AlbumsRepositoryImpl implements AlbumsRepository {
  AlbumsRepositoryImpl({required AlbumsApiBase albumsApi}) : _albumsApi = albumsApi;

  final AlbumsApiBase _albumsApi;

  @override
  Future<List<Album>> getAlbumsByEventId(
    String eventId, {
    int page = 1,
    int limit = 5,
  }) async {
    return _albumsApi.getAlbumsByEventId(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
