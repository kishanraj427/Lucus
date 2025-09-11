import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucus/screens/dashboard/dashboardScreen.dart';
import 'package:lucus/screens/profile/profileScreen.dart';
import 'package:lucus/screens/booking/bookingScreen.dart';
import 'package:lucus/screens/search/searchScreen.dart';
import 'package:lucus/utility/appColor.dart';
import 'package:lucus/utility/appSize.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: DashboardScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SearchScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: RecentScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return Scaffold(
            body: navigationShell, // the active branch's navigator
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(index),
              type: BottomNavigationBarType.shifting,
              fixedColor: AppColors.primaryColor,
              selectedLabelStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppSize.base,
                  fontWeight: FontWeight.bold),
              selectedIconTheme: const IconThemeData(
                  size: AppSize.navIconSize, color: AppColors.primaryColor),
              unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded), label: 'Bookings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    ],
  );
});
