import 'package:chainmail/chainmail.dart';
import 'package:flutter/widgets.dart';

mixin Clickable on ChainmailBase {

  bool clickEnabled = true;
  String semanticLabel = "Button";

  @override
  Widget chainCollapse(Widget child) => super.chainCollapse(
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Semantics(
          button: true,
          label: semanticLabel,
          enabled: clickEnabled,
          child: GestureDetector(
            onTap: clickEnabled ? onTap : null,
            child: child,
          ),
        ),
      )
  );

  void onTap();

}