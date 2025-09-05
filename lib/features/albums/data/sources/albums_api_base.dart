import '../../domain/entities/album.dart';

abstract class AlbumsApiBase {
  Future<List<Album>> getAlbumsByEventId({
    required String eventId,
    int page = 1,
    int limit = 10,
  });
}
