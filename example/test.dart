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
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends ChainmailState<ExampleWidget> {

  late int value;

  @override
  void enable() {
    value = 0;
  }

  @override
  Widget mainBuild() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            value += 1;
            rebuild();
          }, child: const Text("Increment")),
          Text(value.toString())
        ],
      ),
    );
  }
}