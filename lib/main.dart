import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_market/auth/complete_profile/complete_profile.dart';
import 'package:online_market/auth/login/login.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/auth/signup/signup.dart';
import 'package:online_market/cart/cart_provider.dart';
import 'package:online_market/favourites/favourites_provider.dart';
import 'package:online_market/firebase_options.dart';
import 'package:online_market/root/index.dart';
import 'package:online_market/seller/home/provider/homeProvider.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => FavouritesHelper()),
        ChangeNotifierProvider(create: (context) => CartHelper()),
        ChangeNotifierProxyProvider<Authentication, SellerHomeProvider>(
            update: (context, auth, previous) {
              return SellerHomeProvider(auth: auth);
            },
            create: (context) => SellerHomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        home: const AuthRoot());
  }
}
