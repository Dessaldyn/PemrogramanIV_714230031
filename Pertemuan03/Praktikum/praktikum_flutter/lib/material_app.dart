import 'package:flutter/material.dart';
import 'package:praktikum_flutter/material_page.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: false
      ),
      home: MyHomePage()
    ); 
  }
}