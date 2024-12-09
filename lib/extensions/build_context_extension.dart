import 'package:flutter/material.dart';

extension BuildContextExtenstion on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme  get textTheme => Theme.of(this).textTheme;
  ColorScheme  get colorScheme => Theme.of(this).colorScheme;
  NavigatorState get navigation => Navigator.of(this);
  ModalRoute<Object?>? get modalRoute => ModalRoute.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
