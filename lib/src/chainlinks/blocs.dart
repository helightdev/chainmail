import 'dart:async';

import 'package:chainmail/chainmail.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin Blocs on ChainmailBase {

  List<BlocProperty> get properties;

  @protected
  final StreamController updates = StreamController.broadcast(sync: true);

  late StreamSubscription _subscription;

  @protected
  bool isSubscribed = false;

  @override
  void chainEnable() {
    super.chainEnable();
    for (var value in properties) {
      value._ensureBound(context, updates);
    }
    _subscription = updates.stream.listen((event) {
      rebuild();
    });
  }

  @override
  void chainDisable() {
    super.chainDisable();
    for (var property in properties) {
      property._dispose();
    }
    _subscription.cancel();
  }


  @override
  Widget? chainBuild() {
    // Not using the recommended order since no chain override will occur.
    for (var value in properties) {
      value._ensureBound(context, updates);
    }
    return super.chainBuild();
  }

}

class BlocProperty<B extends BlocBase<S>, S> {

  static int idCounter = 0;

  final int internalId = idCounter++;
  late B bloc;
  late S state;
  late StreamSubscription _subscription;
  bool isBound = false;

  void _subscribe(BuildContext context, StreamController controller) {
    bloc = BlocProvider.of<B>(context, listen: false);
    state = bloc.state;
    _subscription = bloc.stream.listen((event) {
      controller.add(event);
      state = event;
    });
    isBound = true;
  }

  void _ensureBound(BuildContext context, StreamController controller) {
    if (isBound) return;
    _subscribe(context, controller);
  }

  void _dispose() {
    _subscription.cancel();
    isBound = false;
  }

}