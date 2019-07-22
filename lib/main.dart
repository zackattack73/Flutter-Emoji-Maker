import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Emoji Maker V1.0'),
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
  List<String> assetsNames = [
    "1f60a",
    "1f60b",
    "1f60c",
    "1f60d",
    "1f60e",
    "1f60f",
    "1f61a",
    "1f61b",
    "1f61c",
    "1f61d",
    "1f61e",
    "1f61f",
    "1f62a",
    "1f62b",
    "1f62c",
    "1f62d",
    "1f62e",
    "1f62f",
    "1f63a",
    "1f63b",
    "1f63c",
    "1f63d",
    "1f63e",
    "1f63f"
  ];

  String assetName = 'lib/assets/1f60a.svg';
  void _incrementCounter() {
    setState(() {
      var rng = new Random();
      assetName =
          "lib/assets/" + assetsNames[rng.nextInt(assetsNames.length)] + ".svg";
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget svg = new SvgPicture.asset(
      assetName,
      height: 150,
      width: 150,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            svg,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
