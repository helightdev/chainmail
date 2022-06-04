import 'dart:async';

import 'package:chainmail/src/chainmail_base.dart';
import 'package:flutter/material.dart';

@Deprecated("Unstable workaround which does not fully integrate with the widget lifecycle")
abstract class ChainmailWidget extends StatelessWidget implements ChainmailBase {

  late BuildContext _internalContext;

  @override
  BuildContext get context => _internalContext;

  StreamController controller = StreamController();

  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (ctx, snapshot) {
      _internalContext = context;
      if (!isEnabled) {
        isEnabled = true;
        chainEnable();
        enable();
      }
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
    }, stream: controller.stream,);
  }

  @override
  void chainActivate() { }

  @override
  ChainBuildResult? chainBuild() => null;

  @override
  void chainDeactivate() {}

  @override
  void chainDisable() { }

  @override
  void chainEnable() {}

  @override
  void disable() {}

  @override
  void enable() {}

  @override
  Widget mainBuild();

  @override
  void rebuild([Function() callback = _voidCallback]) {
    controller.add(0);
  }

  @override
  void rebuildLater([Function() callback = _voidCallback]) {
    controller.add(0);
  }

  @override
  Widget chainCollapse(Widget child) => child;

}


void _voidCallback() {}