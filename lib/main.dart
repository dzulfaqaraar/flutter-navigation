import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;
import 'presentation/pages/login_page.dart';
import 'presentation/provider/login_notifier.dart';

void main() {
  di.init();
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
      home: ChangeNotifierProvider<LoginNotifier>(
        create: (_) => LoginNotifier(
          checkSession: di.locator(),
          postLogin: di.locator(),
        ),
        child: const LoginPage(isFromLogout: false),
      ),
    );
  }
}
