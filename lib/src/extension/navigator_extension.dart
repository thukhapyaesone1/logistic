import 'package:flutter/cupertino.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> pushTo<T>(
      {required String route, Map<String, dynamic>? args}) {
    return Navigator.pushNamed<T>(this, route);
  }

  Future<T?> push<T>({required Route<T> route}){
    return Navigator.push(this, route);
  }

  Future<Map<String, dynamic>?> pushReplace(
      {required String route, Map<String, dynamic>? args}) {
    return Navigator.pushReplacementNamed(this, route, arguments: args);
  }

  void pop<T>() {
    return Navigator.pop<T>(this);
  }
}
