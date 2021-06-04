import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorLight: Colors.orange,
        brightness: Brightness.light,
        // primarySwatch: Colors.blue,

        primaryColorBrightness: Brightness.light,
      ),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
