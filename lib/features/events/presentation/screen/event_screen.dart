import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_event_album_app/app/providers.dart';

import '../../../auth/presentation/bottom_navigator.dart';
import '../../domain/entities/event.dart';
import '../widgets/event_card_widget.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(eventsProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsProvider);

    return BottomNavigatorWidget(
      appBar: AppBar(
        title: const Text('Assignment App'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      child: eventsAsync.when(
        data: (events) => _EventsList(
          events: events,
          controller: _scrollController,
          hasMore: ref.read(eventsProvider.notifier).hasMore,
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 3),
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  const _EventsList({
    required this.events,
    required this.controller,
    required this.hasMore,
  });

  final List<Event> events;
  final ScrollController controller;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(16),
      itemCount: events.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < events.length) {
          final event = events[index];
          return EventCard(event: event);
        } else {
          // Loader at bottom
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFD700),
                strokeWidth: 3,
              ),
            ),
          );
        }
      },
    );
  }
}
