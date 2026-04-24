import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordcubit.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/repo/forgetpasswordRepo.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/changepassword_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/forget_password_view.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/verifycode_view.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_response_model.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/login_view.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/featureAuth/create_acc/create_acc_view.dart';
import 'package:waslet_khier/features/Donation_feature/views/donation_view%20(1).dart';
import 'package:waslet_khier/features/admin_feature/admin_main_screen.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/views/admin_case_details_view.dart';
import 'package:waslet_khier/features/admin_feature/views/admin_edit_case.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/views/case_detatls_veiw.dart';
import 'package:waslet_khier/features/cases_feature/views/cases_view.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/charity_repo.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_detels_view.dart';
import 'package:waslet_khier/features/charity_feature/views/charity_view.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/categoryView.dart';
import 'package:waslet_khier/features/donation_feature/data/models/donation_model.dart';
import 'package:waslet_khier/features/home_feature/views/home_page.dart';
import 'package:waslet_khier/features/home_feature/views/zakat_view.dart';
import 'package:waslet_khier/features/main_feature/views/main_view.dart';
import 'package:waslet_khier/features/notification_featur/view/notifi_view.dart';
import 'package:waslet_khier/features/profile_feature/views/profile_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/aboutApp_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favioritCases.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/favorite_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/paymentway_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';
import 'package:waslet_khier/features/splash_feature/views/splash_view.dart'; // 👈 add this import

final _rootNavigatorKey = GlobalKey<NavigatorState>();

CharityModel _toCharity(Object? extra) {
  print('>>> extra type: ${extra?.runtimeType}');
  print('>>> extra value: $extra');
  if (extra is CharityModel) return extra;
  if (extra is Map)
    return CharityModel.fromJson(Map<String, dynamic>.from(extra));
  return CharityModel(); // ← this is the silent failure
}

CaseModel _toCase(Object? extra) {
  if (extra is CaseModel) return extra;
  if (extra is Map) return CaseModel.fromJson(Map<String, dynamic>.from(extra));
  return CaseModel();
}

Widget _caseDetailsWithCubit(CaseModel casee) {
  return BlocProvider(
    create: (ctx) => CharityDetealsCubit(CharityRepo(ApiService(Dio()))),
    child: CaseDetatlsVeiw(casee: casee),
  );
}

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash', // 👈 changed from '/home'

  redirect: (context, state) {
    final auth = Provider.of<AuthProvider_info>(context, listen: false);
    final isLoggedIn = auth.isLoggedIn;
    final loc = state.matchedLocation;

    // ✅ Always allow splash through, no auth check
    if (loc == '/splash') return null;
    if (loc == 'forgetpassword') return null;

    final isOnAuth =
        loc == '/profile/logout' || loc.startsWith('/profile/logout/');
    final isOnAdmin = loc.startsWith('/admin');

    if (isOnAdmin && isLoggedIn) return null;
    if (!isLoggedIn && !isOnAuth) return '/profile/logout';
    if (isLoggedIn && isOnAuth) return '/home';

    return null;
  },

  routes: [
    // ── SPLASH ──────────────────────────────────────────────────────────────
    GoRoute(path: '/splash', builder: (context, state) => const SplashView()),

    // ── ADMIN ─────────────────────────────────────────────────────────────────
    GoRoute(
      path: '/admin/:charityId',
      builder: (context, state) {
        final charityId =
            int.tryParse(state.pathParameters['charityId'] ?? '0') ?? 0;
        print('>>> Router charityId from path: $charityId');
        return AdminMainScreen(charityId: charityId);
      },
      routes: [
        GoRoute(
          path: 'case_details',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final caseId = state.extra as int;
            return AdminCaseDetailsView(caseId: caseId);
          },
        ),
        GoRoute(
          path: 'edit_case',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final charityId =
                int.tryParse(state.pathParameters['charityId'] ?? '0') ?? 0;
            final extra = state.extra as Map<String, dynamic>;
            final caseData = extra['caseData'] as AdminCaseModel;
            final adminId = extra['adminId'] as int;
            return AdminEditCaseView(
              caseData: caseData,
              charityId: charityId,
              adminId: adminId,
            );
          },
        ),
      ],
    ),

    // ── DONOR APP ─────────────────────────────────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainScreen(navigationShell: navigationShell),
      branches: [
        // ── HOME ──────────────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => HomePage(),
              routes: [
                GoRoute(
                  path: 'notification',
                  builder: (context, state) {
                    final donor =
                        state.extra as DonorModel; // ✅ DonorModel كامل
                    return NotificationView(donor: donor);
                  },
                ),
                GoRoute(
                  path: 'case_detals_view',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      _caseDetailsWithCubit(_toCase(state.extra)),
                ),
                GoRoute(
                  path: 'charities',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const CharityView(),
                ),
                GoRoute(
                  path: 'chaaritedetelies',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      CharityDetelsView(charity: _toCharity(state.extra)),
                ),
                GoRoute(
                  path: 'zakatView',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const ZakatCalculatorScreen(),
                ),
              ],
            ),
          ],
        ),

        // ── CHARITIES ─────────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/charities',
              builder: (context, state) => const CharityView(),
              routes: [
                GoRoute(
                  path: 'chaaritedetelies',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      CharityDetelsView(charity: _toCharity(state.extra)),
                  routes: [
                    GoRoute(
                      path: 'Category/:categoryId',
                      parentNavigatorKey: _rootNavigatorKey, // ← أضيفي ده
                      builder: (context, state) {
                        final categoryModel = state.extra as CategoryMadel;
                        return Categoryview(
                          categoryId: categoryModel.id ?? 0,
                          categoryMadel: categoryModel,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ── CASES ─────────────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cases',
              builder: (context, state) => const CasesView(),
              routes: [
                GoRoute(
                  path: 'case_detals_view',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      _caseDetailsWithCubit(_toCase(state.extra)),
                ),
                GoRoute(
                  path: 'donation',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      DonationView(casee: _toCase(state.extra)),
                ),
              ],
            ),
          ],
        ),

        // ── PROFILE ───────────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
              routes: [
                GoRoute(
                  path: 'AboutappView',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const AboutappView(),
                ),
                GoRoute(
                  path: 'PaymentwayView',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const PaymentwayView(),
                ),
                GoRoute(
                  path: 'Faviorite',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const FavoriteView(),
                ),
                GoRoute(
                  path: 'Favioritcases',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const Favioritcases(),
                ),
                GoRoute(
                  path: 'personInfo',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const PersonInfo_view(),
                ),
                GoRoute(
                  path: 'faviorate',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const FavoriteView(),
                ),
                GoRoute(
                  path: 'logout',
                  builder: (context, state) => LoginView(),
                  routes: [
                    GoRoute(
                      path: 'createacc',
                      builder: (context, state) => const CreateAccView(),
                    ),
                    // ✅ بعد - الـ cubit بيتشارك بين الـ 3 شاشات
                    GoRoute(
                      path: 'forgetpassword',
                      builder: (context, state) {
                        return BlocProvider(
                          create: (_) => ResetpasswordCubit(
                            ResetpasswordRepo(ApiService(Dio())),
                          ),
                          child: const ForgetPassword(),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'VerifycodeView',
                          builder: (context, state) {
                            // الـ cubit جاي من الـ extra اللي بعتاه شاشة forgetpassword
                            final cubit = state.extra as ResetpasswordCubit;
                            return BlocProvider.value(
                              value: cubit,
                              child: const VerifycodeView(),
                            );
                          },
                          routes: [
                            GoRoute(
                              path: 'ChangepasswordView',
                              builder: (context, state) {
                                // نفس الـ cubit بيتنقل للشاشة التالتة
                                final cubit = state.extra as ResetpasswordCubit;
                                return BlocProvider.value(
                                  value: cubit,
                                  child: const ChangepasswordView(),
                                );
                              },
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
