import 'package:chainmail/chainmail.dart';
import 'package:flutter/widgets.dart';

mixin LateRender on ChainmailBase {

  late RenderObject renderObject;
  RenderBox get renderBox => renderObject as RenderBox;

  Rect get painBounds => renderObject.paintBounds;
  Offset get renderPos => renderBox.localToGlobal(Offset.zero);
  Size get renderSize => renderBox.size;

  @override
  Widget? chainBuild() {
    var superValue = super.chainBuild();
    if (superValue != null) return superValue;

    var renderObj = context.findRenderObject();
    if (renderObj == null) {
      rebuildLater();
      return Container();
    }
    renderObject = renderObj;

    return null;
  }

}