import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/usecases/logout_user.dart';
import '../../injection.dart' as di;
import '../pages/login_page.dart';
import 'login_notifier.dart';

class HomeNotifier extends ChangeNotifier {
  final LogoutUser logoutUser;

  HomeNotifier({required this.logoutUser});

  void fetchUserData() async {
    final result = await logoutUser.execute();
    if (result) {}
  }

  Future<void> logout(BuildContext context) async {
    if (await logoutUser.execute()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<LoginNotifier>(
            create: (_) => LoginNotifier(
              checkSession: di.locator(),
              postLogin: di.locator(),
            ),
            child: const LoginPage(isFromLogout: true),
          ),
        ),
        (r) => false,
      );
    }
  }
}
