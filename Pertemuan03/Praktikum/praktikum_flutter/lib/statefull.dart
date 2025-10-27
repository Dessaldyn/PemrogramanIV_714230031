import 'package:flutter/material.dart';

class MyStatefull extends StatefulWidget {
  const MyStatefull({super.key});

  @override
  State<MyStatefull> createState() => _MyStatefullState();
}

class _MyStatefullState extends State<MyStatefull> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello, Stateful Widget!'),
        ),
      ),
    );
  }
}