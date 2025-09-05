import 'package:mini_event_album_app/features/events/domain/entities/event.dart';

abstract class EventsRepository {
  Future<List<Event>> getEvents({int page = 1, int limit = 10});
}
