import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/changepassword_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/forget_password_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/verifycode_view.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/login_view.dart';
import 'package:waslet_khier/featureAuth/create_acc/create_acc_view.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/views/case_detatls_veiw.dart';
import 'package:waslet_khier/features/cases_feature/views/cases_view.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/categoryView.dart';
import 'package:waslet_khier/features/home_feature/views/home_page.dart';
import 'package:waslet_khier/features/home_feature/views/zakat_view.dart';
import 'package:waslet_khier/features/main_feature/views/main_view.dart';
import 'package:waslet_khier/features/profile_feature/views/profile_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/aboutApp_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favioritCases.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favoriteCharity.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favorite_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/paymentway_view.dart';
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
                  builder: (context, state) {
                    final casee = state.extra as CaseModel;
                    return CaseDetatlsVeiw(casee: casee);
                  },
                  routes: [
                    GoRoute(
                      path: 'chaaritedetelies',
                      builder: (context, state) {
                        final charity = state.extra as CharityModel;

                        return CharityDetelsView(charity: charity);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'charities',
                  builder: (context, state) => const CharityView(),
                ),
                GoRoute(
                  path: 'chaaritedetelies',
                  builder: (context, state) {
                    final charity = state.extra as CharityModel;

                    return CharityDetelsView(charity: charity);
                  },
                  routes: [
                    GoRoute(
                      path: 'category',
                      builder: (context, state) {
                        return Categoryview();
                      },
                    ),
                  ],
                ),

                GoRoute(
                  path: 'zakatView',
                  builder: (context, state) => const ZakatCalculatorScreen(),
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
                  path: 'chaaritedetelies',
                  builder: (context, state) {
                    final charity = state.extra as CharityModel;
                    return CharityDetelsView(charity: charity);
                  },
                  routes: [
                    GoRoute(
                      path: 'categoryview',
                      builder: (context, state) {
                        return Categoryview();
                      },
                    ),
                  ],
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
                  path: 'case_detals_view',
                  builder: (context, state) {
                    final casee = state.extra as CaseModel;
                    return CaseDetatlsVeiw(casee: casee);
                  },
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
                  path: '/AboutappView',
                  builder: (context, state) => const AboutappView(),
                ),
                GoRoute(
                  path: '/PaymentwayView',
                  builder: (context, state) => const PaymentwayView(),
                ),
                GoRoute(
                  path: '/Favoritecharity',
                  builder: (context, state) => const Favoritecharity(),
                ),
                GoRoute(
                  path: '/Favioritcases',
                  builder: (context, state) => const Favioritcases(),
                ),
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
