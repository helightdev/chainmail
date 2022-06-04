import 'dart:async';

import 'package:chainmail/chainmail.dart';
import 'package:chainmail/src/chainmail_base.dart';
import 'package:flutter/widgets.dart';

mixin Disposables on ChainmailStatefulBase {

  final List<VoidCallback> _disposables = List<VoidCallback>.empty(growable: true);

  @override
  void chainDisable() {
    super.chainDisable();
    for (var callback in _disposables) {
      callback.call();
    }
  }

  void disposableSubscription(StreamSubscription subscription) {
    _disposables.add(() => subscription.cancel());
  }

  void disposableCallback(VoidCallback callback) => _disposables.add(callback);

}