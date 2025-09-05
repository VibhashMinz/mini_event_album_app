import 'package:dio/dio.dart';

import '../../../core/api_exceptions.dart';
import '../../../core/dio_client.dart';
import '../../../core/mock_api_service.dart';
import '../../domain/entities/photo.dart';

abstract class PhotosApiBase {
  Future<List<Photo>> getPhotosByAlbumId(String albumId);
  Future<void> togglePhotoLike(String photoId, bool liked);
}

class PhotosApiMock implements PhotosApiBase {
  @override
  Future<List<Photo>> getPhotosByAlbumId(String albumId) async {
    return await MockApiService.getPhotosByAlbumId(albumId);
  }

  @override
  Future<void> togglePhotoLike(String photoId, bool liked) async {
    return await MockApiService.togglePhotoLike(photoId, liked);
  }
}

class PhotosApi implements PhotosApiBase {
  PhotosApi({required DioClient dioClient}) : _dio = dioClient.dio;

  final Dio _dio;

  @override
  Future<List<Photo>> getPhotosByAlbumId(String albumId) async {
    try {
      final response = await _dio.get('/albums/$albumId/photos');
      final data = response.data as List;
      return data.map((e) => Photo.fromJson(e)).toList();
    } catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> togglePhotoLike(String photoId, bool liked) async {
    try {
      await _dio.post(
        '/photos/$photoId/like',
        data: {'liked': liked},
      );
    } catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
