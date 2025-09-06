import 'dart:developer';

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
        '/events/$eventId',
      );

      final json = response.data as Map<String, dynamic>;
      final albums = (json['albums'] as List<dynamic>? ?? [])
          .map((e) => Album.fromJson({
                ...e as Map<String, dynamic>,
                'eventId': eventId, // inject eventId manually
              }))
          .toList();

      // Apply manual pagination since MockAPI doesn’t do nested paging
      final start = (page - 1) * limit;
      final end = (start + limit).clamp(0, albums.length);
      //  log('albums: $albums');
      return albums.sublist(start, end);
    } catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
