import 'package:mini_event_album_app/features/events/data/source/events_api_base.dart';

import '../../../../core/mock_api_service.dart';
import '../../domain/entities/event.dart';

class EventsApiMock implements EventsApiBase {
  @override
  Future<List<Event>> getEvents({int page = 1, int limit = 10}) async {
    return await MockApiService.getEvents(page: page, limit: limit);
  }
}
