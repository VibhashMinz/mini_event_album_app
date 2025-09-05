import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_event_album_app/app/providers.dart';
import 'package:mini_event_album_app/features/auth/presentation/bottom_navigator.dart';

import '../domain/entities/album.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(albumsNotifierProvider(eventId));
    final albumsNotifier = ref.read(albumsNotifierProvider(eventId).notifier);

    final eventsAsync = ref.watch(eventsProvider);

    return BottomNavigatorWidget(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/events'),
        ),
        title: eventsAsync.when(
          data: (events) {
            final event = events.firstWhere((e) => e.id == eventId);
            return Text(event.name);
          },
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Event'),
        ),
        centerTitle: true,
      ),
      child: albumsAsync.when(
        data: (albums) => _AlbumsGrid(
          albums: albums,
          hasMore: albumsNotifier.hasMore,
          onLoadMore: () => albumsNotifier.fetchAlbums(loadMore: true),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 3),
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _AlbumsGrid extends StatefulWidget {
  const _AlbumsGrid({
    required this.albums,
    required this.hasMore,
    required this.onLoadMore,
  });

  final List<Album> albums;
  final bool hasMore;
  final VoidCallback onLoadMore;

  @override
  State<_AlbumsGrid> createState() => _AlbumsGridState();
}

class _AlbumsGridState extends State<_AlbumsGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.albums.isEmpty) {
      return const Center(
        child: Text(
          'No albums found for this event',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8, // Dense grid as shown in Figma
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: widget.albums.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.albums.length) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 2),
          );
        }
        final album = widget.albums[index];
        return _AlbumGridItem(album: album);
      },
    );
  }
}

class _AlbumGridItem extends StatelessWidget {
  const _AlbumGridItem({required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = album.coverUrl;

    return InkWell(
      onTap: () => context.go('/events/${album.eventId}/albums/${album.id}/photos'),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: thumbnailUrl.isNotEmpty
            ? Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/logo/image.png',
                  fit: BoxFit.cover,
                ),
              )
            : Image.asset(
                'assets/logo/image.png',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
