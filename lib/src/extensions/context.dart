import 'package:chainmail/chainmail.dart';
import 'package:flutter/material.dart';

extension ContextExtension on ChainmailBase {

  ThemeData get theme => Theme.of(context);
  TextTheme get text => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get media => MediaQuery.of(context);
  double get screenWidth => media.size.width;
  double get screenHeight => media.size.height;
  bool get isVertical => screenHeight > screenWidth;
  bool get isHorizontal => screenHeight < screenWidth;

}