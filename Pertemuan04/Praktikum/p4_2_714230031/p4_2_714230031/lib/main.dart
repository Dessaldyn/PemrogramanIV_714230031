import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Pemograman Pertemuan 4',
      theme: ThemeData.light(useMaterial3: false),
      home: const WidgetLayout(),
    );
  }
}

class WidgetLayout extends StatelessWidget {
  const WidgetLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Pemograman Pertemuan 4'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Box Biru
            Container(
              width: 300,
              height: 100,
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: const Text(
                'Box 1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Box Merah & Hijau
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 200,
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Box 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 200,
                  color: Colors.greenAccent,
                  alignment: Alignment.center,
                  child: const Text(
                    'Box 3',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
