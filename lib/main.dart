import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/presentation/auth/login/login.dart';
import 'package:online_market/presentation/base_screen/base.dart';
import 'package:online_market/presentation/cart/cart_provider.dart';
import 'package:online_market/routes/routing.gr.dart';
import 'package:online_market/util/theme.dart';
import 'package:provider/provider.dart';

import 'presentation/app_start/app_start_cubit.dart';
import 'presentation/auth/complete_profile/complete_profile.dart';
import 'presentation/favourites/favourites_provider.dart';
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
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartHelper(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesHelper(),
        )
      ],
      child: MaterialApp.router(
        title: 'Emarket',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: customDarkTheme(),
        theme: customLightTheme(),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        key: _appRouter.key,
      ),
    );
  }

  // return ;
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String route = '/splashScreen';
  static String routeName = 'splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBlocConsumer<AppStartCubit, AppStartState>(
      listener: (context, state) {
        if (state is CompleteProfile) {
          context.router.push(CompleteProfileRoute());
        }
        if (state is LoggedIn) {
          if (state.isUser) {
            context.router.push(const Base());
          } else {
            context.router.push(const SellerBase());
          }
        }
        if (state is LoggedOut) {
          context.router.push(LoginRoute());
        }
      },
      builder: (context, state) {
        return const LoadingScreen();
      },
    ));
  }
}
