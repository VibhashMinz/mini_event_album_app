import 'dart:convert';

import '../features/events/domain/entities/event.dart';

class MockApiService {
  //simulate network delay

  static const Duration _networkDelay = Duration(milliseconds: 800);

  //Mock data for events

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
}
