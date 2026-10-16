import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Shared bottom navigation bar for the 5 primary sections of the app:
/// Home, Analytics, Prediction, Alerts, Profile.
/// Wraps [BottomNavigationBar] and adds an optional unread badge (e.g. Alerts count).
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int alertCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.alertCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Analytics',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.psychology_alt_rounded),
          label: 'Predict',
        ),
        BottomNavigationBarItem(
          icon: _BadgedIcon(icon: Icons.notifications_rounded, count: alertCount),
          label: 'Alerts',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _BadgedIcon extends StatelessWidget {
  final IconData icon;
  final int count;
  const _BadgedIcon({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return Icon(icon);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon),
        Positioned(
          top: -4,
          right: -8,
          child: Container(
            padding: const EdgeInsets.all(3),
            constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
            decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}
