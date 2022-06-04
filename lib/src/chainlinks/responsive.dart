import 'package:chainmail/chainmail.dart';
import 'package:flutter/material.dart';

mixin Responsive on ChainmailBase {

  @override
  Widget mainBuild() {
    if (isVertical) {
      return portraitBuild();
    } else {
      return landscapeBuild();
    }
  }

  Widget landscapeBuild();
  Widget portraitBuild();

}