import 'package:chainmail/chainmail.dart';
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
  State<ExampleWidget> createState() => ExampleState();
}

class ExampleState extends ChainmailState<ExampleWidget> with Loading {

  @override
  Widget mainBuild() {
    return const Text("Test!");
  }

  @override
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}