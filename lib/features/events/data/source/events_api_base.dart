import '../../domain/entities/event.dart';

abstract class EventsApiBase {
  Future<List<Event>> getEvents({int page = 1, int limit = 10});
}
