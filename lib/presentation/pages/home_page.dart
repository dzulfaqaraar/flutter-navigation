import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../provider/home_notifier.dart';
import '../provider/profile_notifier.dart';
import 'profile_page.dart';

final locator = GetIt.instance;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider<ProfileNotifier>(
                      create: (_) => ProfileNotifier(getUser: locator()),
                      child: const ProfilePage(),
                    ),
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
