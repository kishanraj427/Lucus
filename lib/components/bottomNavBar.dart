import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../utility/appColor.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = GoRouter.of(context).state.path;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB))), // border-gray-200
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/',
            isSelected: currentRoute == '/',
            onTap: () => context.go('/'),
          ),
          NavItem(
            icon: Icons.search,
            label: 'Search',
            route: '/search',
            isSelected: currentRoute == '/search',
            onTap: () => context.go('/search'),
          ),
          NavItem(
            icon: Icons.history,
            label: 'Recent',
            route: '/recent',
            isSelected: currentRoute == '/recent',
            onTap: () => context.go('/recent'),
          ),
          NavItem(
            icon: Icons.person,
            label: 'Profile',
            route: '/profile',
            isSelected: currentRoute == '/profile',
            onTap: () => context.go('/profile'),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary600 : Colors.grey[500],
            size: 24,
            weight: isSelected ? 700 : 400,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary600 : Colors.grey[500],
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
