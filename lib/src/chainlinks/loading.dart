import 'package:chainmail/chainmail.dart';
import 'package:flutter/material.dart';

mixin Loading on ChainmailBase {

  bool _isLoaded = false;

  @override
  void chainEnable() {
    super.chainEnable();
    initialize().then((value) {
      _isLoaded = true;
      rebuild();
    }).catchError((err, trace) {
      if (this is Errors) {
        (this as Errors).throwError((err as dynamic).toString(), trace: trace);
      }
    });
  }

  Future initialize();

  Widget buildPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget? chainBuild() {
    var superValue = super.chainBuild();
    if (superValue != null) return superValue;
    if (!_isLoaded) return buildPlaceholder();
    return null;
  }

  void startLoading() {
    _isLoaded = false;
    rebuild();
  }

  void stopLoading() {
    _isLoaded = true;
    rebuild();
  }

  bool get isLoading => _isLoaded;
}