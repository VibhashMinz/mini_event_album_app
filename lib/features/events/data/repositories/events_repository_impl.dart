import '../../domain/entities/event.dart';
import '../../domain/repositories/events_repository.dart';
import '../source/events_api_base.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl({required EventsApiBase eventsApi}) : _eventsApi = eventsApi;

  final EventsApiBase _eventsApi;

  @override
  Future<List<Event>> getEvents({int page = 1, int limit = 10}) {
    return _eventsApi.getEvents(page: page, limit: limit);
  }
}
