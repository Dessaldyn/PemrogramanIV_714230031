import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late SharedPreferences logindata;
  String username = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      // Mengambil username sesi saat ini
      username = logindata.getString('username').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // [Tambahan] Biar di tengah vertikal juga
            children: [
              const Text('Welcome to Home'),
              const SizedBox(height: 20),
              Text(
                username,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // [LOGIKA LOGOUT]
                  // Kita set login menjadi true (artinya user harus login lagi)
                  logindata.setBool('login', true);
                  
                  // Kita hapus username sesi saat ini
                  logindata.remove('username');
                  
                  // CATATAN: Kita TIDAK menghapus 'saved_username' atau 'is_remember'
                  // agar fitur Remember Me tetap berfungsi saat kembali ke Login Screen.

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}