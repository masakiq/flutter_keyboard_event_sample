import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterShortcuts(
      onIncrementDetected: _incrementCounter,
      onDecrementDetected: _decrementCounter,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

final incrementKeySet = LogicalKeySet(
  LogicalKeyboardKey.meta, // Replace with control on Windows
  LogicalKeyboardKey.arrowUp,
);
final decrementKeySet = LogicalKeySet(
  LogicalKeyboardKey.meta, // Replace with control on Windows
  LogicalKeyboardKey.arrowDown,
);

class IncrementIntent extends Intent {}

class DecrementIntent extends Intent {}

class CounterShortcuts extends StatelessWidget {
  const CounterShortcuts({
    Key key,
    @required this.child,
    @required this.onIncrementDetected,
    @required this.onDecrementDetected,
  }) : super(key: key);
  final Widget child;
  final VoidCallback onIncrementDetected;
  final VoidCallback onDecrementDetected;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        incrementKeySet: IncrementIntent(),
        decrementKeySet: DecrementIntent(),
      },
      actions: {
        IncrementIntent:
            CallbackAction(onInvoke: (e) => onIncrementDetected?.call()),
        DecrementIntent:
            CallbackAction(onInvoke: (e) => onDecrementDetected?.call()),
      },
      child: child,
    );
  }
}
