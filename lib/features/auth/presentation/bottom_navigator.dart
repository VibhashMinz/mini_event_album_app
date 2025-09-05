import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigatorWidget extends StatelessWidget {
  const BottomNavigatorWidget({
    super.key,
    required this.child,
    this.appBar,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: Container(
        height: 80,
        color: const Color(0xFF2C2C2C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              icon: Icons.star,
              label: 'EVENTS',
              route: '/events',
              isSelected: location.startsWith('/events'),
            ),
            _buildNavItem(
              context: context,
              icon: Icons.person,
              label: 'PROFILE',
              route: '/profile',
              isSelected: location.startsWith('/profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFFFD700) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFFFD700) : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
