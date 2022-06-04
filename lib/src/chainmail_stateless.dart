import 'package:chainmail/chainmail.dart';
import 'package:flutter/material.dart';

abstract class StatelessChainmail extends StatelessWidget implements ChainmailBase {

  StatelessChainmail({Key? key}) : super(key: key);

  @override
  BuildContext get context => _internalContext;

  late BuildContext _internalContext;

  @override
  Widget build(BuildContext context) {
    _internalContext = context;
    var chainBuilt = chainBuild();
    if (chainBuilt != null) {
      if (chainBuilt.collapse) {
        return chainCollapse(chainBuilt.widget);
      } else {
        return chainBuilt.widget;
      }
    }
    var built = mainBuild();
    var chainReduced = chainCollapse(built);
    return chainReduced;
  }

  @override
  ChainBuildResult? chainBuild() { }

  @override
  Widget chainCollapse(Widget child) => child;
}
