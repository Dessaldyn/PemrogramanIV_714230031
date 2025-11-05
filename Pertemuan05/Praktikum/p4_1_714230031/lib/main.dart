import 'package:flutter/material.dart';
import 'package:p4_1_714230031/main_screen.dart';
// import 'detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung',
      theme: ThemeData.light(
        //userMaterial3 untuk menghilangkan warning
        useMaterial3: false
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    ); // MaterialApp
  }
}
