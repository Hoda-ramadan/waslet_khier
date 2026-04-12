import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/changepassword_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/forget_password_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/verifycode_view.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/login_view.dart';
import 'package:waslet_khier/featureAuth/create_acc/create_acc_view.dart';
import 'package:waslet_khier/features/cases_feature/views/case_detatls_veiw.dart';
import 'package:waslet_khier/features/cases_feature/views/cases_view.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_view.dart';
import 'package:waslet_khier/features/home_feature/views/Custom_drawer.dart';
import 'package:waslet_khier/features/home_feature/views/home_page.dart';
import 'package:waslet_khier/features/main_feature/views/main_view.dart';
import 'package:waslet_khier/features/profile_feature/views/profile_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favorite_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

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
              builder: (context, state) => HomePage(),
              routes: [
                GoRoute(
                  path: 'case_detals_view',
                  builder: (context, state) => CaseDetatlsVeiw(),
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
              routes: [
                GoRoute(
                  path: '/chaaritedetelies',
                  builder: (context, state) => CharityDetelsView(),
                ),
              ],
            ),
          ],
        ),

        // CASES
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cases',
              builder: (context, state) => const CasesView(),
              routes: [
                GoRoute(
                  path: '/cases/case_detals_view',
                  builder: (context, state) => CaseDetatlsVeiw(),
                ),
              ],
            ),
          ],
        ),

        // PROFILE
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
              routes: [
                GoRoute(
                  path: '/personInfo',
                  builder: (context, state) => const PersonInfo_view(),
                ),
                GoRoute(
                  path: '/faviorate',
                  builder: (context, state) => const FavoriteView(),
                ),
                GoRoute(
                  path: '/logout',
                  builder: (context, state) => LoginView(),
                  routes: [
                    GoRoute(
                      path: '/createacc',
                      builder: (context, state) => const CreateAccView(),
                    ),
                    GoRoute(
                      path: '/forgetpassword',
                      builder: (context, state) => const ForgetPassword(),
                      routes: [
                        GoRoute(
                          path: '/VerifycodeView',
                          builder: (context, state) => VerifycodeView(),
                          routes: [
                            GoRoute(
                              path: '/ChangepasswordView',
                              builder: (context, state) => ChangepasswordView(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
