import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neukit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NeukitDemo(),
    );
  }
}

class NeukitDemo extends StatelessWidget {
  const NeukitDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [],
    );
  }
}
