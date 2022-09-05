import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static push<T>(Route<T> route) {
    navigatorKey.currentState?.push(route);
  }

  static pushReplacement<T>(Route<T> route) {
    navigatorKey.currentState?.pushReplacement(route);
  }

  static pushAndRemoveUntil<T>(Route<T> route, RoutePredicate predicate) {
    navigatorKey.currentState?.pushAndRemoveUntil(route, predicate);
  }
}
