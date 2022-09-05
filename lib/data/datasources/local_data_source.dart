import 'package:app/common/navigation.dart';
import 'package:app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/date_time_helper.dart';
import '../../injection.dart' as di;
import '../../presentation/provider/login_notifier.dart';

abstract class LocalDataSource {
  Future<bool> isLoggedIn();
  Future<void> setLoggedIn(String token, String expire);
  Future<String?> getToken();
  Future<bool> clear();
}

class LocalDataSourceImpl implements LocalDataSource {
  static LocalDataSourceImpl? _singleton;
  late SharedPreferences _preferences;

  LocalDataSourceImpl._internal();

  static LocalDataSourceImpl instance() {
    if (_singleton == null) {
      _singleton = LocalDataSourceImpl._internal();
      _singleton?._init();
    }
    return _singleton!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> isLoggedIn() async {
    return _preferences.getBool(keySignedIn) ?? false;
  }

  @override
  Future<void> setLoggedIn(String token, String expire) async {
    await _preferences.setBool(keySignedIn, true);
    await _preferences.setString(keyToken, token);
    await _preferences.setString(keyExpire, expire);
  }

  @override
  Future<String?> getToken() async {
    final expire = _preferences.getString(keyExpire) ?? '';
    if (DateTimeHelper.isExpired(expire)) {
      await clear();
      Navigation.pushAndRemoveUntil(
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
      return null;
    }
    return _preferences.getString(keyToken);
  }

  @override
  Future<bool> clear() async {
    return await _preferences.clear();
  }

  static const String keyToken = 'token';
  static const String keyExpire = 'expire';
  static const String keySignedIn = 'keySignedIn';
}
