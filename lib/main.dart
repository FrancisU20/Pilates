import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/providers/plan/plan_provider.dart';
import 'package:pilates/providers/recover-password/recover_password_provider.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:pilates/theme/routes/routes.dart';
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
      ChangeNotifierProvider<PageStateProvider>(
          create: (_) => PageStateProvider()),
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<PlanProvider>(create: (_) => PlanProvider()),
      ChangeNotifierProvider<UserPlanProvider>(
          create: (_) => UserPlanProvider()),
      ChangeNotifierProvider<NutritionalInfoProvider>(
          create: (_) => NutritionalInfoProvider()),
      ChangeNotifierProvider<ClassProvider>(create: (_) => ClassProvider()),
      ChangeNotifierProvider<RecoverPasswordProvider>(
          create: (_) => RecoverPasswordProvider()),
      ChangeNotifierProvider<UserClassProvider>(
          create: (_) => UserClassProvider()),
      ChangeNotifierProvider<AdminProvider>(create: (_) => AdminProvider()),
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
        SizeConfig.init(constraints, orientation);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp.router(
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
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.beige200),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: goRouter),
        );
      });
    });
  }
}
