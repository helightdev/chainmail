import 'package:chainmail/chainmail.dart';
import 'package:flutter/widgets.dart';

mixin Wrapper on ChainmailBase {

  @override
  Widget chainCollapse(Widget child) => super.chainCollapse(
      wrap(child)
  );

  Widget wrap(Widget child);

}