// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'registpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    const Text(
                      'MASUK AKUN',
                      style: TextStyle(
                        color: Color(0xFF005AE1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Silahkan masuk ke akun anda',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      child: const Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF005AE1)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum Punya Akun? ',
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Tambahkan navigasi ke halaman pendaftaran di sini
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const RegistPage(), // Ganti dengan halaman pendaftaran Anda
                            ));
                          },
                          child: const Text(
                            'DAFTAR',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors
                                  .blue, // Warna teks yang membuatnya terlihat seperti tautan
                              decoration: TextDecoration
                                  .underline, // Garis bawah seperti tautan
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // ignore: unused_local_variable
      final currentUserId = userCredential.user?.email;

      if (userCredential.user != null) {
        // Login berhasil, simpan status login
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('currentUserId', currentUserId!);
        prefs.setBool('isLoggedIn', true);

        // Pindah ke halaman utama
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal. Cek kembali email dan password Anda.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
