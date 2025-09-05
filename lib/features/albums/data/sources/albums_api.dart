import 'package:mini_event_album_app/core/dio_client.dart';

import '../../../../core/api_exceptions.dart';
import '../../domain/entities/album.dart';
import 'albums_api_base.dart';

class AlbumsApi implements AlbumsApiBase {
  AlbumsApi(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<Album>> getAlbumsByEventId({
    required String eventId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/events/$eventId/albums',
        queryParameters: {'_page': page, '_limit': limit},
      );

      final data = response.data as List;
      return data.map((e) => Album.fromJson(e)).toList();
    } catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
