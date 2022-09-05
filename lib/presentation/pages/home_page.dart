import 'package:app/common/navigation.dart';
import 'package:app/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_notifier.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text('Go to Profile'),
              onPressed: () {
                Navigation.push(
                  MaterialPageRoute(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Go to Setting'),
              onPressed: () {
                Navigation.push(
                  MaterialPageRoute(
                    builder: (_) => const SettingPage(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                Provider.of<HomeNotifier>(context, listen: false).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
