import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/config/images_paths.dart';
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
import 'package:pilates/theme/routes/providers/page_state_provider.dart';
import 'package:pilates/theme/routes/routes.dart';
import 'package:pilates/theme/routes/providers/routes_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const AppInitializer());
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => PageStateProvider()),
              ChangeNotifierProvider(create: (_) => RegisterProvider()),
              ChangeNotifierProvider(create: (_) => LoginProvider()),
              ChangeNotifierProvider(create: (_) => PlanProvider()),
              ChangeNotifierProvider(create: (_) => UserPlanProvider()),
              ChangeNotifierProvider(create: (_) => NutritionalInfoProvider()),
              ChangeNotifierProvider(create: (_) => ClassProvider()),
              ChangeNotifierProvider(create: (_) => RecoverPasswordProvider()),
              ChangeNotifierProvider(create: (_) => UserClassProvider()),
              ChangeNotifierProvider(create: (_) => AdminProvider()),
              ChangeNotifierProvider(create: (_) => RoutesProvider()),
            ],
            child: const MyApp(),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.scaleHeight(25)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      height: SizeConfig.scaleHeight(25),
                      child: Image.asset(
                        imagesPaths.logoSquareFill,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(5)),
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(7.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      FlutterNativeSplash.remove();
    });
  }

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
              Locale('en', 'US'),
              Locale('es', 'ES'),
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(.90)),
                child: child!,
              );
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.beige200),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter,
          ),
        );
      });
    });
  }
}
