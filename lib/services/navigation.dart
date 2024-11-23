import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/user.dart';
import 'package:project_ss/pages/AI_detail.dart';
import 'package:project_ss/pages/auth/authentication.dart';
import 'package:project_ss/pages/before_getting_start_page.dart';
import 'package:project_ss/pages/chefAI_page.dart';
import 'package:project_ss/pages/course_list.dart';
import 'package:project_ss/pages/course_page.dart';
import 'package:project_ss/pages/future_page.dart';
import 'package:project_ss/pages/auth/login_page.dart';
import 'package:project_ss/pages/loading_page.dart';
import 'package:project_ss/pages/result_page.dart';
import 'package:project_ss/pages/schedule_page.dart';
import 'package:project_ss/pages/auth/sign_up.dart';
import 'package:project_ss/pages/futureplanning_page.dart';
import 'package:project_ss/pages/taken_courses_page.dart';
import 'package:project_ss/widgets/Profile_page.dart';
import 'package:project_ss/pages/schedule_page.dart';
import 'package:project_ss/pages/topology_page.dart';
import 'package:project_ss/view_model/me_vm.dart';
import 'package:project_ss/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:project_ss/services/ai.dart';

final routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: LoginPage()),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => NoTransitionPage<void>(child: SignUp()),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final myId = Provider.of<AuthenticationService>(context, listen: false)
            .checkAndGetLoggedInUserId();
        if (myId == null) {
          debugPrint('Warning: ShellRoute should not be built without a user');
          return const SizedBox.shrink();
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MeViewModel>(
              create: (_) => MeViewModel(myId),
            ),
          ],
          child: child,
        );
      },
      routes: [
        GoRoute(
            path: '/aftersignup',
            pageBuilder: (context, state) {
              final meViewModel =
                  Provider.of<MeViewModel>(context, listen: true);
              return NoTransitionPage<void>(
                  child: StreamBuilder<User>(
                stream: meViewModel.meStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active ||
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    debugPrint('Error loading user data: ${snapshot.error}');
                    return const Center(
                      child: Text('Error loading user data'),
                    );
                  }

                  return BeforeGettingStarted();
                },
              ));
            }),
        GoRoute(
            path: '/tab',
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(child: BottomNavBar(currentIndex: 0)),
            routes: [
              GoRoute(
                path: 'schedule',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                    child: BottomNavBar(currentIndex: 0)),
                routes: [
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => ProfilePage(),
                    routes: [
                      GoRoute(
                        path: 'taken',
                        builder: (context, state) => TakenCoursesPage(),
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: 'future',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                    child: BottomNavBar(currentIndex: 2)),
                routes: [
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => ProfilePage(),
                    routes: [
                      GoRoute(
                        path: 'taken',
                        builder: (context, state) => TakenCoursesPage(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'planning',
                    builder: (context, state) => FuturePlanningPage(),
                  ),
                  GoRoute(
                    path: 'topology',
                    builder: (context, state) => TopologyPage(),
                  ),
                ],
              ),
              GoRoute(
                path: 'course',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                    child: BottomNavBar(currentIndex: 1)),
                routes: [
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => ProfilePage(),
                    routes: [
                      GoRoute(
                        path: 'taken',
                        builder: (context, state) => TakenCoursesPage(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'list',
                    builder: (context, state) => const CourseList(),
                  ),
                  GoRoute(
                    path: 'result',
                    builder: (context, state) => ResultPage(),
                  ),
                  GoRoute(
                    path: 'loading',
                    builder: (context, state) => LoadingPage(),
                  ),
                  GoRoute(
                    path: 'form',
                    builder: (context, state) => chefAI_page(),
                  ),
                ],
              ),
            ]),
      ],
    ),
  ],
  initialLocation: '/tab',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final currentPath = state.uri.path;
    final isLoggedIn =
        Provider.of<AuthenticationService>(context, listen: false)
                .checkAndGetLoggedInUserId() !=
            null;
    if (isLoggedIn && currentPath == '/signup') {
      return '/aftersignup';
    }
    if (!isLoggedIn && currentPath != '/signup') {
      // Redirect to auth page if the user is not logged in
      return '/login';
    }
    if (isLoggedIn && currentPath == '/login') {
      return '/tab';
    }
    if (currentPath == '/') {
      return '/tab';
    }
    // No redirection needed for other routes
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);

class NavigationService {
  late final GoRouter _router;

  NavigationService() {
    _router = routerConfig;
  }
  String _currentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }

  void pushProfileOnTab({required BuildContext context}) {
    var path = _currentPath(context);
    switch (path) {
      case '/tab':
        _router.go('/tab/schedule/profile');
        return;
      case '/tab/schedule':
        _router.go('/tab/schedule/profile');
        return;
      case '/tab/future':
        _router.go('/tab/future/profile');
        return;
      case '/tab/course':
        _router.go('/tab/course/profile');
        return;
    }
    throw Exception('Cannot push filters on the path: $path');
  }

  void goToCourseTaken({required BuildContext context}) {
    var path = _currentPath(context);
    switch (path) {
      case '/tab/schedule/profile':
        _router.go('/tab/schedule/profile/taken');
        return;
      case '/tab/course/profile':
        _router.go('/tab/course/profile/taken');
        return;
      case '/tab/future/profile':
        _router.go('/tab/future/profile/taken');
        return;
    }
    throw Exception('Cannot push filters on the path: $path');
  }

  void goToTopologyPage() {
    _router.go('/tab/future/topology');
  }

  void goToFormAI() {
    _router.go('/tab/course/form');
  }

  void goToLoadingPage() {
    _router.go('/tab/course/loading');
  }

  void goToResultPage() {
    _router.go('/tab/course/result');
  }

  void goToFuturePlanningPage() {
    _router.go('/tab/future/planning');
  }

  void goToCourseListPage() {
    _router.go('/tab/course/list');
  }

  void goToSignUpPage() {
    _router.go('/signup');
  }

  void goToLoginPage() {
    _router.go('/login');
  }

  void alrLoginPage() {
    _router.go('/tab');
  }

  void goToSchedulePage() {
    _router.go('/tab/schedule');
  }

  void goToFuturePage() {
    _router.go('/tab/future');
  }

  void goToCoursePage() {
    _router.go('/tab/course');
  }

  void pop(BuildContext context) {
    _router.pop(context);
  }
}
