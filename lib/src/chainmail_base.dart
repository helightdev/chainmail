import 'package:flutter/widgets.dart';

abstract class ChainmailBase {

  BuildContext get context;

  /// Chained method that gets called before the [mainBuild] method which returns an optional [Widget]. Overriding mixins should generally
  /// obey the following structure:
  /// ```dart
  /// @override
  /// Widget? chainBuild() {
  ///   var superValue = super.chainBuild();
  ///   if (superValue != null) return superValue;
  ///   // Your checks
  ///   return null;
  /// }
  /// ```
  /// since this will make the resulting mixin structure more user friendly as the call order will natural i.E:
  /// ```dart
  /// class TestWidget extends ChainmailWidget with A, B, C
  /// ```
  /// Will have the call order A, B and C. You can also use the simpler not recommended variant:
  /// ```dart
  /// @override
  /// Widget? chainBuild() {
  ///   // Your checks
  ///   return super.chainBuild();
  /// }
  /// ```
  /// Using this will result in these chainlinks being executed in reverse order
  /// ```dart
  /// class TestWidget extends ChainmailWidget with A, B, C
  /// ```
  /// Will in this case have the call order C, B and A. If both variants are mixed,
  /// the first variant will always be executed after the second one.
  @mustCallSuper
  ChainBuildResult? chainBuild() => null;

  /// Refer to [State.build]
  Widget mainBuild();

  /// Wraps the build output using all mixins on buildChainCollapse. The first mixin will generate the uppermost widget.
  ///
  /// ```dart
  /// class TestWidget extends ChainmailWidget with A, B, C
  /// ```
  ///
  /// will be reduced into a widget tree representing following structure:
  /// ```dart
  /// A(
  ///   child: B(
  ///     child: C(
  ///       child: build()
  ///     )
  ///   )
  /// )
  /// ```
  ///
  /// a chainlink using this method should call the super method with its own wrapper as a child,
  /// resulting in code looking structurally similar to this example:
  /// ```dart
  /// mixin Wrapper on ChainmailWidget {
  ///
  ///   @override
  ///   Widget chainCollapse(Widget child) => super.chainCollapse(
  ///       Padding(padding: const EdgeInsets.all(1.0), child: child,)
  ///   );
  ///
  /// }
  /// ```
  ///
  @mustCallSuper
  Widget chainCollapse(Widget child) { return child; }

}

abstract class ChainmailStatefulBase extends ChainmailBase {

  /// Chained method that gets called when the state is initialised. Overriding mixins should call the super method as the first statement.
  @mustCallSuper
  void chainEnable() {}
  void enable() {}

  /// Chained method that gets called when the state is disposed. Overriding mixins should call the super method as the first statement.
  @mustCallSuper
  void chainDisable() {}
  void disable() {}

  @mustCallSuper
  void chainDeactivate() {}

  @mustCallSuper
  void chainActivate() {}

  void rebuild([Function() callback = _voidCallback]);

  void rebuildLater([Function() callback = _voidCallback]);

}

class ChainBuildResult {

  Widget widget;
  bool collapse;

  ChainBuildResult(this.widget, this.collapse);

  factory ChainBuildResult.collapsed(Widget widget) {
    return ChainBuildResult(widget, true);
  }

  factory ChainBuildResult.static(Widget widget) {
    return ChainBuildResult(widget, false);
  }

}

void _voidCallback() {}