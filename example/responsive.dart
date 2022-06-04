import 'package:chainmail/chainmail.dart';
import 'package:chainmail/src/chainlinks/responsive.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ExampleWidget(),
    ),
  ));
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends ChainmailState<ExampleWidget> with Responsive {

  @override
  Widget landscapeBuild() {
    return const Text("Desktop / Horizontal / Landscape Version");
  }

  @override
  Widget portraitBuild() {
    return const Text("Mobile / Vertical / Portrait Version");
  }

}