import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:redditech/Screens/Accueil/accueil_screen.dart';
import 'package:redditech/Screens/Welcome/welcome_screen.dart';
import 'package:redditech/Screens/Accueil/settings.dart';

import 'package:redditech/constants.dart';

import 'Screens/Accueil/sub.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  redditAuth.initPrefs(await SharedPreferences.getInstance());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  String _computeInitialRoute() {
    if (redditAuth.loginLocalStorage())
      return '/second';
    return '/';
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      theme: ThemeData(
        primaryColor: PrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: _computeInitialRoute(),
      routes: {
        '/' : (context) => WelcomeScreen(),
        '/second' : (context) => AccueilScreen(),
        '/settings' : (context) => SettingsRoute(),
        '/sub' : (context) => SubRoute(),
      },
    );
  }
}