import 'package:flutter_test/flutter_test.dart';
import 'package:mini_event_album_app/features/photos/domain/entities/photo.dart';
import 'package:mini_event_album_app/features/photos/domain/repositories/photos_repository.dart';
import 'package:mini_event_album_app/features/photos/presentation/photo_notifier.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {}

void main() {
  late MockPhotosRepository mockRepo;
  late PhotosNotifier notifier;

  final albumId = 'alb_001';
  final photo1 = Photo(id: 'ph_001', albumId: albumId, url: 'url1', liked: false);
  final photo2 = Photo(id: 'ph_002', albumId: albumId, url: 'url2', liked: false);

  setUp(() {
    mockRepo = MockPhotosRepository();
    when(() => mockRepo.getPhotosByAlbumId(albumId)).thenAnswer((_) async => [photo1, photo2]);
    notifier = PhotosNotifier(repository: mockRepo, albumId: albumId);
  });

  test('initial load sets state to AsyncData', () async {
    await Future.delayed(Duration.zero); // wait for _loadPhotos
    expect(notifier.state.value, [photo1, photo2]);
  });

  test('toggle like updates state optimistically', () async {
    await Future.delayed(Duration.zero);

    when(() => mockRepo.togglePhotoLike(photo1.id, true)).thenAnswer((_) async {});

    await notifier.updatePhotoLike(photo1.id, true);

    final updatedPhoto = notifier.state.value!.firstWhere((p) => p.id == photo1.id);
    expect(updatedPhoto.liked, true);

    verify(() => mockRepo.togglePhotoLike(photo1.id, true)).called(1);
  });

  test('reverts if API fails', () async {
    await Future.delayed(Duration.zero);

    when(() => mockRepo.togglePhotoLike(photo1.id, true)).thenThrow(Exception('API error'));

    await notifier.updatePhotoLike(photo1.id, true);

    // Should revert to original state
    final revertedPhoto = notifier.state.value!.firstWhere((p) => p.id == photo1.id);
    expect(revertedPhoto.liked, false);
  });
}
