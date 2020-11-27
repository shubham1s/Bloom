import 'package:flutter/material.dart';
import 'package:BLOOM_BETA/services/auth_service.dart';

class Provider extends InheritedWidget {
  final AuthService auth;
  final db;

  Provider({Key key, Widget child, this.auth, this.db})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}
