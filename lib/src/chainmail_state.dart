import 'package:chainmail/chainmail.dart';
import 'package:chainmail/src/chainmail_base.dart';
import 'package:flutter/material.dart';

abstract class ChainmailState<T extends StatefulWidget> extends State<T> implements ChainmailStatefulBase {

  late BuildContext _internalContext;
  BuildContext? _superContext;

  @override
  BuildContext get context {
    if (_superContext == null) {
      _superContext = super.context;
      _internalContext = super.context;
    }
    return _internalContext;
  }

  @protected
  bool isEnabled = false;

  /// Chained method that gets called when the state is initialised. Overriding mixins should call the super method as the first statement.
  @mustCallSuper
  @override
  void chainEnable() {}
  @override
  void enable() {}


  /// Chained method that gets called when the state is disposed. Overriding mixins should call the super method as the first statement.
  @mustCallSuper
  @override
  void chainDisable() {}
  @override
  void disable() {}

  @mustCallSuper
  @override
  void chainDeactivate() {}

  @mustCallSuper
  @override
  void chainActivate() {}

  @mustCallSuper
  @override
  ChainBuildResult? chainBuild() => null;

  @override
  Widget mainBuild();

  @mustCallSuper
  @override
  Widget chainCollapse(Widget child) { return child; }

  @override
  void rebuild([Function() callback = _voidCallback]) {
    setState(callback);
  }

  @override
  void rebuildLater([Function() callback = _voidCallback]) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rebuild(callback);
    });
  }

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
  void initState() {
    if (isEnabled) {
      throw Exception("ChainmailWidget is already enabled");
    }
    isEnabled = true;
    chainEnable();
    enable();
    super.initState();
  }

  @override
  void dispose() {
    if (!isEnabled) {
      throw Exception("ChainmailWidget is not enabled");
    }
    isEnabled = false;
    disable();
    chainDisable();
    super.dispose();
  }

  @override
  void deactivate() {
    chainDeactivate();
    super.deactivate();
  }

  @override
  void activate() {
    chainActivate();
    super.activate();
  }

}

void _voidCallback() {}