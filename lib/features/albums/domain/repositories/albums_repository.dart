import '../entities/album.dart';

abstract class AlbumsRepository {
  Future<List<Album>> getAlbumsByEventId(String eventId, {int page, int limit});
}
