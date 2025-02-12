import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/screens/admin/dashboard/admin_dashboard_page.dart';
import 'package:pilates/screens/admin/user-class/admin_users_class_page.dart';
import 'package:pilates/screens/admin/user-plans/admin_users_plans_page.dart';
import 'package:pilates/screens/client/contact/contact_page.dart';
import 'package:pilates/screens/client/dashboard/dashboard_page.dart';
import 'package:pilates/screens/client/digital-identification/digital_identification.dart';
import 'package:pilates/screens/client/my-account/my_account_page.dart';
import 'package:pilates/screens/client/nutritional-info/nutritional_info_page.dart';
import 'package:pilates/screens/client/payment-methods/transfer_payment_page.dart';
import 'package:pilates/screens/client/plan/plan_page.dart';
import 'package:pilates/screens/client/recover-password/recover_password_page.dart';
import 'package:pilates/screens/client/class/class_page.dart';
import 'package:pilates/screens/client/user-class/user_class_page.dart';
import 'package:pilates/screens/common/register/register_page.dart';
import 'package:pilates/screens/common/login_page.dart';
import 'package:pilates/screens/common/onboarding/onboarding_page.dart';
import 'package:pilates/screens/common/pdf_viewer/pdf_viewer_page.dart';
import 'package:pilates/theme/routes/page_transitions.dart';

Page<void> buildPageWithFadeTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return PageTransitions.fadeTransition(animation, child);
    },
  );
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return buildPageWithFadeTransition(
          context,
          state,
          const OnboardingPage(),
        );
      },
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) {
        return buildPageWithFadeTransition(
          context,
          state,
          const OnboardingPage(),
        );
      },
      routes: [
        GoRoute(
          path: 'register',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const RegisterPage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return buildPageWithFadeTransition(
          context,
          state,
          const LoginPage(),
        );
      },
      routes: [
        GoRoute(
          path: 'recover-password',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const RecoverPasswordPage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) {
        return buildPageWithFadeTransition(
          context,
          state,
          const DashboardPage(),
        );
      },
      routes: [
        GoRoute(
          path: 'plans',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const PlanPage(),
            );
          },
          routes: [
            GoRoute(
              path: 'transfer-payment',
              pageBuilder: (context, state) {
                return buildPageWithFadeTransition(
                  context,
                  state,
                  const TransferPaymentPage(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'contact',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const ContactPage(),
            );
          },
        ),
        GoRoute(
          path: 'my-account',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const MyAccountPage(),
            );
          },
        ),
        GoRoute(
            path: 'nutritional-info',
            pageBuilder: (context, state) {
              return buildPageWithFadeTransition(
                context,
                state,
                const NutritionalInfoPage(),
              );
            },
            routes: [
              GoRoute(
                path: 'pdf-viewer',
                builder: (context, state) {
                  final filePath = state.extra as String;
                  return PDFViewerPage(
                    filePath: filePath,
                  );
                },
              ),
            ]),
        GoRoute(
          path: 'class',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const ClassPage(),
            );
          },
        ),
        GoRoute(
          path: 'user-class',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const UserClassPage(),
            );
          },
        ),
        GoRoute(
          path: 'digital-identification',
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition(
              context,
              state,
              const DigitalIdentificationPage(),
            );
          },
        ),
      ],
    ),

    //! Rutas del admin
    GoRoute(
      path: '/admin-dashboard',
      pageBuilder: (context, state) {
        return buildPageWithFadeTransition(
          context,
          state,
          const AdminDashboardPage(),
        );
      },
      routes: [
        GoRoute(
            path: 'user-class',
            pageBuilder: (context, state) {
              return buildPageWithFadeTransition(
                context,
                state,
                const AdminUserClassPage(),
              );
            }),
        GoRoute(
            path: 'users',
            pageBuilder: (context, state) {
              return buildPageWithFadeTransition(
                context,
                state,
                const AdminUsersPlansPage(),
              );
            }),
      ],
    ),
  ],
);
