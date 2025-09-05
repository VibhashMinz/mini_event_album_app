import 'package:mini_event_album_app/core/mock_api_service.dart';
import 'package:mini_event_album_app/features/albums/data/sources/albums_api_base.dart';
import '../../domain/entities/album.dart';

class AlbumsApiMock implements AlbumsApiBase {
  @override
  Future<List<Album>> getAlbumsByEventId({
    required String eventId,
    int page = 1,
    int limit = 10,
  }) async {
    return MockApiService.getAlbumsByEventId(eventId, page: page, limit: limit);
  }
}
