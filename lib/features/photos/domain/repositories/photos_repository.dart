import '../entities/photo.dart';

abstract class PhotosRepository {
  Future<List<Photo>> getPhotosByAlbumId(String albumId);
  Future<void> togglePhotoLike(String photoId, bool liked);
}
