import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/screens/client/contact/contact_page.dart';
import 'package:pilates/screens/client/dashboard/dashboard_page.dart';
import 'package:pilates/screens/client/digital-identification/digital_identification.dart';
import 'package:pilates/screens/client/my-account/my_account_page.dart';
import 'package:pilates/screens/client/nutritional-info/nutritional_info_page.dart';
import 'package:pilates/screens/client/payment-methods/transfer_payment_page.dart';
import 'package:pilates/screens/client/plan/plan_page.dart';
import 'package:pilates/screens/client/user-class/user_class_page.dart';
import 'package:pilates/screens/common/register/register_page.dart';
import 'package:pilates/screens/common/login_page.dart';
import 'package:pilates/screens/common/onboarding/onboarding_page.dart';
import 'package:pilates/screens/common/splash_screen.dart';

final GoRouter goRouter = GoRouter(routes: <GoRoute>[
  //? Splash Screen
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreenPage();
      }),

  //? Onboarding
  GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingPage();
      },
      routes: [
        //? Register
        GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterPage();
            }),
      ]),

  //? Login
  GoRoute(
    path: '/login',
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),

  //? Dashboard
  GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
      routes: [
        //? Plan
        GoRoute(
            path: 'plans',
            builder: (BuildContext context, GoRouterState state) {
              return const PlanPage();
            },
            routes: [
              //? Transfer Payment
              GoRoute(
                  path: 'transfer-payment',
                  builder: (BuildContext context, GoRouterState state) {
                    return const TransferPaymentPage();
                  }),
            ]),

        //? Contact
        GoRoute(
            path: 'contact',
            builder: (BuildContext context, GoRouterState state) {
              return const ContactPage();
            }),

        //? MyAccount
        GoRoute(
            path: 'my-account',
            builder: (BuildContext context, GoRouterState state) {
              return const MyAccountPage();
            }),

        //? Nutritional Information
        GoRoute(
            path: 'nutritional-info',
            builder: (BuildContext context, GoRouterState state) {
              return const NutritionalInfoPage();
            }),

        //? User Class
        GoRoute(
          path: 'user-class',
          builder: (BuildContext context, GoRouterState state) {
            return const ClassPage();
          },
        ),

        //? Digital Identification
        GoRoute(
          path: 'digital-identification',
          builder: (BuildContext context, GoRouterState state) {
            return const DigitalIdentificationPage();
          },
        ),
      ]),
]);
