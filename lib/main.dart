import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_market/firebase_options.dart';
import 'package:online_market/util/theme.dart';
import 'package:provider/provider.dart';

import 'presentation/auth/providers/auth_provider.dart';
import 'presentation/cart/cart_provider.dart';
import 'presentation/favourites/favourites_provider.dart';
import 'presentation/root/index.dart';
import 'presentation/seller/home/provider/homeProvider.dart';

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
