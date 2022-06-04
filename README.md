## Features
Chainmail offers a mixin based extension model to improve code quality.
You might already know mixins and their advantages from the infamous
TickerProvider mixins.

The package ships with following features already implemented:
* Extensible mixin based chain model
* Full integrations with the default state class
* `Blocs`: Bind to list of blocs and listen to updated
* `Loading`: Await a future and show a placeholder
* `Errors`: Catch custom or loading errors and show them
* `Disposables`: Register StreamSubscriptions and dispose callbacks
* `LateRender`: Wait for one frame before building to access the RenderBox


## Usage
To use the chainmail extension system, just change your state implementations
type to ChainmailState and implement the `mainBuild` method instead of `build`.

```dart
class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => ExampleState();
}

class ExampleState extends ChainmailState<ExampleWidget> {
  @override
  Widget mainBuild() => const Text("Hello World");
}
```

You can use the BuildContext as usual with the `context` variable, which in
this case is declared at class level and is accessible from everywhere inside
the class and always up-to-date. You can also use one of the numerous
quality of life getters for common scenarios, like getting MediaQueries or
accessing the nearest Theme and TextTheme.

To use an extension (from now on referred to as chainlinks), just use the `with`
keyword followed by the mixin class. You then possibly have to implement
required methods.

```dart
class ExampleState extends ChainmailState<ExampleWidget> with Loading {
  @override
  Widget mainBuild() => const Text("Test!");
  
  @override
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
```

The chainlinks will be applied in natural order, contrary to the "common"
reverse order, because of readability.
