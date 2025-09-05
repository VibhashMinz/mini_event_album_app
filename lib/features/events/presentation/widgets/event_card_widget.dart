import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.go('/events/${event.id}/albums'),
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Album thumbnail image (network or fallback asset)
              Positioned.fill(
                child: (event.albumThumbnailUrl.isNotEmpty)
                    ? Image.network(
                        event.albumThumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/logo/image.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/logo/image.png',
                        fit: BoxFit.cover,
                      ),
              ),

              // Dark overlay for readability
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.25),
                ),
              ),

              // Golden bar with event name
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD700),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    event.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
