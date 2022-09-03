import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case '/setting':
            return MaterialPageRoute(builder: (_) => const SettingPage());
          default:
            return MaterialPageRoute(builder: (_) => const Scaffold());
        }
      },
    );
  }
}
