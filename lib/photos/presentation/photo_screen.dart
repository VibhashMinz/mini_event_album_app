import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_event_album_app/app/providers.dart';
import 'package:mini_event_album_app/features/auth/presentation/bottom_navigator.dart';

import '../domain/entities/photo.dart';

class PhotoScreen extends ConsumerWidget {
  const PhotoScreen({super.key, required this.eventId, required this.albumId});
  final String eventId;
  final String albumId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photosByAlbumProvider(albumId));

    return BottomNavigatorWidget(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/events/$eventId/albums'),
        ),
        title: const Text('Photos'),
        centerTitle: true,
      ),
      child: photosAsync.when(
        data: (photos) => _PhotosDetailView(photos: photos, ref: ref),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFFFD700), strokeWidth: 3),
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _PhotosDetailView extends ConsumerStatefulWidget {
  const _PhotosDetailView({required this.photos, required this.ref});

  final List<Photo> photos;
  final WidgetRef ref;

  @override
  ConsumerState<_PhotosDetailView> createState() => _PhotosDetailViewState();
}

class _PhotosDetailViewState extends ConsumerState<_PhotosDetailView> {
  late PageController _pageController;
  int _currentPhotoIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(photoLikeStateProvider.notifier).setInitialLikes(widget.photos);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photos.isEmpty) {
      return const Center(
        child: Text(
          'No photos found in this album',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      children: [
        // Counter right under "Photos"
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Text(
            "#${_currentPhotoIndex + 1}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Main photo viewer
        Expanded(
          child: _SwipeablePhotoViewer(
            photos: widget.photos,
            pageController: _pageController,
            currentIndex: _currentPhotoIndex,
            onPageChanged: (index) {
              setState(() {
                _currentPhotoIndex = index;
              });
            },
            ref: ref,
          ),
        ),

        // Like button under the photo
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _LikeButton(
            photo: widget.photos[_currentPhotoIndex],
            ref: ref,
          ),
        ),

        // Navigation controls at the bottom
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF2C2C2C),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Counter with total
              Text(
                '${_currentPhotoIndex + 1} / ${widget.photos.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Navigation arrows
              Row(
                children: [
                  IconButton(
                    onPressed: _currentPhotoIndex > 0
                        ? () => _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            )
                        : null,
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: _currentPhotoIndex > 0 ? const Color(0xFFFFD700) : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _currentPhotoIndex < widget.photos.length - 1
                        ? () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            )
                        : null,
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: _currentPhotoIndex < widget.photos.length - 1 ? const Color(0xFFFFD700) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwipeablePhotoViewer extends StatelessWidget {
  const _SwipeablePhotoViewer({
    required this.photos,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
    required this.ref,
  });

  final List<Photo> photos;
  final PageController pageController;
  final int currentIndex;
  final Function(int) onPageChanged;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return _LargePhotoDisplay(photo: photo);
      },
    );
  }
}

class _LargePhotoDisplay extends StatelessWidget {
  const _LargePhotoDisplay({required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: photo.url.isNotEmpty
          ? Image.network(
              photo.url,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildPlaceholder(),
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/logo/image.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _LikeButton extends ConsumerWidget {
  const _LikeButton({required this.photo, required this.ref});

  final Photo photo;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeState = ref.watch(photoLikeStateProvider);
    final isLiked = likeState[photo.id] ?? photo.liked;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black, // always black background
        shape: BoxShape.circle,
        border: Border.all(
          color: isLiked ? Colors.amber : Colors.grey.shade500,
          width: 2,
        ),
        boxShadow: [
          if (isLiked)
            BoxShadow(
              color: Colors.amber.withValues(alpha: 0.5),
              blurRadius: 12,
              spreadRadius: 2,
            ),
        ],
      ),
      child: IconButton(
        onPressed: () => _toggleLike(ref, isLiked),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
          child: Icon(
            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            key: ValueKey<bool>(isLiked),
            color: isLiked ? Colors.amber : Colors.grey.shade400,
            size: 28,
          ),
        ),
      ),
    );
  }

  void _toggleLike(WidgetRef ref, bool currentStatus) async {
    // Optimistic UI update
    ref.read(photoLikeStateProvider.notifier).toggleLike(photo.id, currentStatus);

    try {
      final photosRepository = ref.read(photosRepositoryProvider);
      await photosRepository.togglePhotoLike(photo.id, !currentStatus);
    } catch (e) {
      // revert if failed
      ref.read(photoLikeStateProvider.notifier).toggleLike(photo.id, !currentStatus);
    }
  }
}
