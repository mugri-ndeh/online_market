import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/presentation/auth/login/login.dart';
import 'package:online_market/presentation/base_screen/base.dart';
import 'package:online_market/util/theme.dart';

import 'presentation/app_start/app_start_cubit.dart';
import 'presentation/auth/complete_profile/complete_profile.dart';
import 'presentation/root/index.dart';
import 'services/errors/global_error_handling/custom_consumer.dart';
import 'services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupInitialLocator();

  runApp(BlocProvider(create: (_) => AppStartCubit(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Emarket',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: customDarkTheme(),
        theme: customLightTheme(),
        home: CustomBlocConsumer<AppStartCubit, AppStartState>(
            builder: (context, state) {
          // if (state is AppStartSuccess) {
          //   return const MarketApp();
          // }
          if (state is CompleteProfile) {
            return CompleteProfileScreen();
          }
          if (state is LoggedIn) {
            return const BaseScreen();
          }
          if (state is LoggedOut) {
            return Login();
          }
          return const MaterialApp(
            home: LoadingScreen(),
            debugShowCheckedModeBanner: false,
          );
        }));
  }

  // return ;
}

class MarketApp extends StatelessWidget {
  const MarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emarket',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: customDarkTheme(),
      theme: customLightTheme(),
      home: const AuthRoot(),
    );

    // MaterialApp.router(
    //   routeInformationParser: router.routeInformationParser,
    //   routerDelegate: router.routerDelegate,
    //   routeInformationProvider: router.routeInformationProvider,
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     textTheme: GoogleFonts.montserratTextTheme(),
    //   ),
    // );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static String route = '/splashScreen';
  static String routeName = 'splashScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
