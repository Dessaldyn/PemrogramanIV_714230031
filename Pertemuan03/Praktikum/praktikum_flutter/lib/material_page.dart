import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: const Color.fromARGB(255, 214, 58, 172),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Homepage"),
            ),
            ListTile(
              title: Text("Settings"),
            ),
            ListTile(
              title: Text("About"),
            ),
          ],
        ),
      ),
      body: Center(
        child: BiggerText(
          text: "Hello Ulbi Ini BiggerText", //ganti heading dengan bigger text untuk stateful
        ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.pinkAccent,
        ),
    );
  }
}

class Heading extends StatelessWidget {
  final String text; //state text bersifat final
  const Heading({Key? key, required this.text}) : super(key: key); //lalu masuk ke konstruktor

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BiggerText extends StatefulWidget {
  final String text;
  const BiggerText({Key? key, required this.text}) : super(key: key);

  @override
  State<BiggerText> createState() =>  _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(fontSize: _textSize),
        ),
        ElevatedButton(
          child: Text(_textSize == 16.0 ? 'Perbesar' : 'Perkecil'),
          onPressed: () {
            setState(() {
              _textSize = _textSize == 16.0 ? 32.0 : 16.0;
            });
          },
        ),
      ],
    );
  }
}