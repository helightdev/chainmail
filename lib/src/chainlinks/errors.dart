import 'package:chainmail/chainmail.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';

mixin Errors on ChainmailStatefulBase {

  ErrorDetail? error;

  void throwError(String message, {String? title, StackTrace? trace, dynamic err}) {
    error = ErrorDetail(message: message, trace: trace ?? StackTrace.current, title: title, error: err);
    log(error.toString(), error: error!.error, stackTrace: error!.trace);
    rebuild();
  }

  Widget buildError(ErrorDetail detail) {
    return Column(
      children: [
        if (detail.title != null) Text(detail.title!, style: text.titleLarge,),
        Text(detail.message, style: text.bodyLarge,),
      ],
    );
  }

  @override
  ChainBuildResult? chainBuild() {
    var superValue = super.chainBuild();
    if (superValue != null) return superValue;
    if (error != null) return ChainBuildResult.collapsed(buildError(error!));
    return null;
  }

}

class ErrorDetail {

  String? title;
  String message;
  dynamic error;
  StackTrace trace;

  ErrorDetail({
    this.title,
    this.error,
    required this.message,
    required this.trace
  });

  @override
  String toString() {
    if (title == null) {
      return message;
    } else {
      return '[$title] $message';
    }
  }

}