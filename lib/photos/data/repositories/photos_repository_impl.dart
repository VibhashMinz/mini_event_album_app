import '../../domain/entities/photo.dart';
import '../../domain/repositories/photos_repository.dart';
import '../sources/photos_api.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  PhotosRepositoryImpl({required PhotosApiBase photosApi}) : _photosApi = photosApi;

  final PhotosApiBase _photosApi;

  @override
  Future<List<Photo>> getPhotosByAlbumId(String albumId) async {
    return await _photosApi.getPhotosByAlbumId(albumId);
  }

  @override
  Future<void> togglePhotoLike(String photoId, bool liked) async {
    return await _photosApi.togglePhotoLike(photoId, liked);
  }
}
