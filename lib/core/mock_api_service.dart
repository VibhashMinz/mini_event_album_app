import 'dart:convert';

import '../features/albums/domain/entities/album.dart';
import '../features/events/domain/entities/event.dart';
import '../features/photos/domain/entities/photo.dart';

class MockApiService {
  //simulate network delay

  static const Duration _networkDelay = Duration(milliseconds: 800);

  // Mock data for events
  static const String _eventsJson = '''
  [
    {
      "id": "event_1",
      "name": "Summer Wedding 2024",
      "albumThumbnailUrl": "https://via.placeholder.com/150/FFD700/000000?text=Wedding"
    },
    {
      "id": "event_2", 
      "name": "Corporate Conference",
      "albumThumbnailUrl": "https://via.placeholder.com/150/FFD700/000000?text=Conference"
    },
    {
      "id": "event_3",
      "name": "Birthday Party", 
      "albumThumbnailUrl": "https://via.placeholder.com/150/FFD700/000000?text=Birthday"
    },
    {
      "id": "event_4",
      "name": "Graduation Ceremony",
      "albumThumbnailUrl": "https://via.placeholder.com/150/FFD700/000000?text=Graduation"
    },
    {
      "id": "event_5",
      "name": "Product Launch",
      "albumThumbnailUrl": "https://via.placeholder.com/150/FFD700/000000?text=Launch"
    }
  ]
  ''';

  // Mock data for albums
  static const String _albumsJson = '''
  {
    "event_1": [
      {
        "id": "album_1_1",
        "eventId": "event_1",
        "title": "Ceremony",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Ceremony"
      },
      {
        "id": "album_1_2", 
        "eventId": "event_1",
        "title": "Reception",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Reception"
      },
      {
        "id": "album_1_3",
        "eventId": "event_1",
        "title": "Honeymoon",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Honeymoon"
      }
    ],
    "event_2": [
      {
        "id": "album_2_1",
        "eventId": "event_2", 
        "title": "Keynote Speakers",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Keynotes"
      },
      {
        "id": "album_2_2",
        "eventId": "event_2",
        "title": "Networking", 
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Networking"
      },
      {
        "id": "album_2_3",
        "eventId": "event_2",
        "title": "Workshops",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Workshops"
      }
    ],
    "event_3": [
      {
        "id": "album_3_1",
        "eventId": "event_3",
        "title": "Birthday Photos", 
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Birthday"
      },
      {
        "id": "album_3_2",
        "eventId": "event_3",
        "title": "Cake Cutting",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Cake"
      }
    ],
    "event_4": [
      {
        "id": "album_4_1",
        "eventId": "event_4",
        "title": "Graduation Photos",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Grad"
      }
    ],
    "event_5": [
      {
        "id": "album_5_1",
        "eventId": "event_5",
        "title": "Product Photos",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Product"
      },
      {
        "id": "album_5_2",
        "eventId": "event_5",
        "title": "Team Photos",
        "coverUrl": "https://via.placeholder.com/150/2C2C2C/FFFFFF?text=Team"
      }
    ]
  }
  ''';

  // Mock data for photos
  static const String _photosJson = '''
  {
    "album_1_1": [
      {
        "id": "photo_1_1_1",
        "albumId": "album_1_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Wedding1",
        "liked": false
      },
      {
        "id": "photo_1_1_2",
        "albumId": "album_1_1", 
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Wedding2",
        "liked": true
      },
      {
        "id": "photo_1_1_3",
        "albumId": "album_1_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Wedding3", 
        "liked": false
      },
      {
        "id": "photo_1_1_4",
        "albumId": "album_1_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Wedding4",
        "liked": true
      },
      {
        "id": "photo_1_1_5",
        "albumId": "album_1_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Wedding5",
        "liked": false
      }
    ],
    "album_1_2": [
      {
        "id": "photo_1_2_1",
        "albumId": "album_1_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Reception1",
        "liked": false
      },
      {
        "id": "photo_1_2_2",
        "albumId": "album_1_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Reception2",
        "liked": true
      },
      {
        "id": "photo_1_2_3",
        "albumId": "album_1_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Reception3",
        "liked": false
      }
    ],
    "album_1_3": [
      {
        "id": "photo_1_3_1",
        "albumId": "album_1_3",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Honeymoon1",
        "liked": true
      },
      {
        "id": "photo_1_3_2",
        "albumId": "album_1_3",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Honeymoon2",
        "liked": false
      }
    ],
    "album_2_1": [
      {
        "id": "photo_2_1_1", 
        "albumId": "album_2_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Keynote1",
        "liked": true
      },
      {
        "id": "photo_2_1_2",
        "albumId": "album_2_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Keynote2",
        "liked": false
      },
      {
        "id": "photo_2_1_3",
        "albumId": "album_2_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Keynote3",
        "liked": true
      },
      {
        "id": "photo_2_1_4",
        "albumId": "album_2_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Keynote4",
        "liked": false
      }
    ],
    "album_2_2": [
      {
        "id": "photo_2_2_1",
        "albumId": "album_2_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Networking1",
        "liked": false
      },
      {
        "id": "photo_2_2_2",
        "albumId": "album_2_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Networking2",
        "liked": true
      }
    ],
    "album_2_3": [
      {
        "id": "photo_2_3_1",
        "albumId": "album_2_3",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Workshop1",
        "liked": false
      },
      {
        "id": "photo_2_3_2",
        "albumId": "album_2_3",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Workshop2",
        "liked": true
      },
      {
        "id": "photo_2_3_3",
        "albumId": "album_2_3",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Workshop3",
        "liked": false
      }
    ],
    "album_3_1": [
      {
        "id": "photo_3_1_1",
        "albumId": "album_3_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Birthday1",
        "liked": true
      },
      {
        "id": "photo_3_1_2",
        "albumId": "album_3_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Birthday2",
        "liked": false
      }
    ],
    "album_3_2": [
      {
        "id": "photo_3_2_1",
        "albumId": "album_3_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Cake1",
        "liked": false
      }
    ],
    "album_4_1": [
      {
        "id": "photo_4_1_1",
        "albumId": "album_4_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Grad1",
        "liked": true
      },
      {
        "id": "photo_4_1_2",
        "albumId": "album_4_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Grad2",
        "liked": false
      },
      {
        "id": "photo_4_1_3",
        "albumId": "album_4_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Grad3",
        "liked": true
      }
    ],
    "album_5_1": [
      {
        "id": "photo_5_1_1",
        "albumId": "album_5_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Product1",
        "liked": false
      },
      {
        "id": "photo_5_1_2",
        "albumId": "album_5_1",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Product2",
        "liked": true
      }
    ],
    "album_5_2": [
      {
        "id": "photo_5_2_1",
        "albumId": "album_5_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Team1",
        "liked": false
      },
      {
        "id": "photo_5_2_2",
        "albumId": "album_5_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Team2",
        "liked": true
      },
      {
        "id": "photo_5_2_3",
        "albumId": "album_5_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Team3",
        "liked": false
      },
      {
        "id": "photo_5_2_4",
        "albumId": "album_5_2",
        "url": "https://via.placeholder.com/300/2C2C2C/FFFFFF?text=Team4",
        "liked": true
      }
    ]
  }
  ''';

  // Get events list with pagination
  static Future<List<Event>> getEvents({
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(_networkDelay);

    try {
      final List<dynamic> eventsData = json.decode(_eventsJson);

      // Pagination logic
      final start = (page - 1) * limit;
      final end = start + limit;

      final paginated = eventsData.sublist(
        start,
        end > eventsData.length ? eventsData.length : end,
      );

      return paginated.map((json) => Event.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to parse events data: $e');
    }
  }

  // Get albums for a specific event
  static Future<List<Album>> getAlbumsByEventId(
    String eventId, {
    int page = 1,
    int limit = 2, // default 2 albums per page
  }) async {
    await Future.delayed(_networkDelay);

    try {
      final Map<String, dynamic> albumsData = json.decode(_albumsJson);
      final List<dynamic> eventAlbums = albumsData[eventId] ?? [];

      // Pagination logic
      final start = (page - 1) * limit;
      final end = start + limit;

      final paginated = eventAlbums.sublist(
        start,
        end > eventAlbums.length ? eventAlbums.length : end,
      );

      return paginated.map((json) => Album.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to parse albums data: $e');
    }
  }

  // Get photos for a specific album
  static Future<List<Photo>> getPhotosByAlbumId(String albumId) async {
    await Future.delayed(_networkDelay);

    try {
      final Map<String, dynamic> photosData = json.decode(_photosJson);
      final List<dynamic> albumPhotos = photosData[albumId] ?? [];
      return albumPhotos.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to parse photos data: $e');
    }
  }

  // Toggle photo like status
  static Future<void> togglePhotoLike(String photoId, bool liked) async {
    await Future.delayed(_networkDelay);

    // In a real app, this would update the server
    // For mock purposes, we just simulate success
    // Photo like status changed to: $liked
  }
}
