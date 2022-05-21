import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_market/auth/login/login.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/firebase_options.dart';
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
        ChangeNotifierProvider(create: (context) => Authentication())
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
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Theme.of(context).brightness == Brightness.dark) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Emarket',
        debugShowCheckedModeBanner: false,
        darkTheme: customDarkTheme(),
        theme: customLightTheme(),
        home: Login());
  }
}
