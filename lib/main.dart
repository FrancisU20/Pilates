import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/screens/admin/clients/clients_page.dart';
import 'package:pilates/screens/admin/dashboard/dashboard_admin_page.dart';
import 'package:pilates/screens/client/appointments/appointments_page.dart';
import 'package:pilates/screens/client/contact/contact_us_page.dart';
import 'package:pilates/screens/client/dashboard/dashboard_page.dart';
import 'package:pilates/screens/login/login_page.dart';
import 'package:pilates/screens/onboarding/onboarding_page.dart';
import 'package:pilates/screens/client/payment/transfer_method.dart';
import 'package:pilates/screens/client/plan/plan_page.dart';
import 'package:pilates/screens/client/profile/profile_page.dart';
import 'package:pilates/screens/client/register/register_page.dart';
import 'package:pilates/screens/client/schedule_date/schedule_date_page.dart';
import 'package:pilates/screens/splash_screen.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar Variables de entorno.
  await dotenv.load(fileName: ".env");

  /// Color de la barra de estado en blanco.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
  ));

  /// Orientación del aplicativo en vertical.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializar bdd para control de onboarding.
  await Hive.initFlutter();
  await Hive.openBox('onboardingBox');

  ///Inicialización de Providers.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
      ChangeNotifierProvider<ClientClassProvider>(
          create: (_) => ClientClassProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'), // Inglés
            Locale('es', 'ES'), // Español
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(.90)),
              child: child!,
            );
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreenPage(),
          debugShowCheckedModeBanner: false,
          routes: {
            //Pantallas del cliente
            '/home': (context) => const SplashScreenPage(),
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const DashboardPage(),
            '/schedule_date': (context) => const ScheduleDatePage(),
            '/appointments': (context) => const AppointmentsPage(),
            '/contact_us': (context) => const ContactUsPage(),
            '/profile': (context) => const ProfilePage(),
            '/plans': (context) => const PlanPage(),
            '/onboarding': (context) => const OnboardingPage(),
            '/register': (context) => const RegisterPage(),
            '/transfer': (context) => const TransferMethodPage(),

            //Pantallas del administrador
            '/dashboard_admin': (context) => const DashboardAdminPage(),
            '/clients': (context) => const ClientsPage(),
          },
        );
      });
    });
  }
}
