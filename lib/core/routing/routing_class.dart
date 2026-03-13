import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/features/cases_feature/views/cases_view.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_view.dart';
import 'package:waslet_khier/features/home_feature/views/home_detals_view.dart';
import 'package:waslet_khier/features/home_feature/views/home_page.dart';
import 'package:waslet_khier/features/main_feature/views/main_view.dart';
import 'package:waslet_khier/features/profile_feature/views/profile_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/personinfo_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/profile_view_body.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // HOME
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const HomeDetalsView(),
                ),
              ],
            ),
          ],
        ),

        // CHARITIES
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/charities',
              builder: (context, state) => const CharityView(),
            ),
          ],
        ),

        // CASES
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cases',
              builder: (context, state) => const CasesView(),
            ),
          ],
        ),

        // PROFILE
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
            ),
            GoRoute(
              path: '/personInfo',
              builder: (context, state) => const PersonInfo_view(),
            ),
          ],
        ),
      ],
    ),
  ],
);
