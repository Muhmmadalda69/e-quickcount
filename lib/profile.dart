// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_quickcount/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

Future<Map<String, dynamic>> getDataFromFirestore(
    String collectionName, String documentId) async {
  final firestore = FirebaseFirestore.instance;
  final document =
      await firestore.collection(collectionName).doc(documentId).get();

  if (document.exists) {
    return document.data() as Map<String, dynamic>;
  } else {
    return {}; // Dokumen tidak ditemukan
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data pengguna dari Firestore
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();

    const collectionName = 'users'; // Ganti dengan nama koleksi yang sesuai
    final currentUserId = prefs.getString('currentUserId') ??
        ''; // Mengambil nilai dengan fallback ke string kosong jika tidak ditemukan

    final data = await getDataFromFirestore(collectionName, currentUserId);

    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EditProfile(title: 'EDIT PROFIL')));
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Menampilkan EMAIL
            const Text('  Nama',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF005AE1),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF005AE1), // Warna garis tepi
                  width: 1.0, // Lebar garis tepi
                ),
                borderRadius: BorderRadius.circular(10), // Bentuk kotak
              ),
              child: Text(
                '${userData['name']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Warna teks
                ),
              ),
            ),

            //Menampilkan EMAIL
            const Text('  Email',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF005AE1),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF005AE1), // Warna garis tepi
                  width: 1.0, // Lebar garis tepi
                ),
                borderRadius: BorderRadius.circular(10), // Bentuk kotak
              ),
              child: Text(
                '${userData['email']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Warna teks
                ),
              ),
            ),

            //Menampilkan Kecamatan
            const Text('  Kecamatan',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF005AE1),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF005AE1), // Warna garis tepi
                  width: 1.0, // Lebar garis tepi
                ),
                borderRadius: BorderRadius.circular(10), // Bentuk kotak
              ),
              child: Text(
                '${userData['kecamatan'] ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Warna teks
                ),
              ),
            ),

            //Menampilkan DESA
            const Text('  Desa',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF005AE1),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF005AE1), // Warna garis tepi
                  width: 1.0, // Lebar garis tepi
                ),
                borderRadius: BorderRadius.circular(10), // Bentuk kotak
              ),
              child: Text(
                '${userData['desa'] ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Warna teks
                ),
              ),
            ),

            //Menampilkan TPS
            const Text('  TPS',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF005AE1),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF005AE1), // Warna garis tepi
                  width: 1.0, // Lebar garis tepi
                ),
                borderRadius: BorderRadius.circular(10), // Bentuk kotak
              ),
              child: Text(
                '${userData['tps'] ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Warna teks
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 200,
        child: FloatingActionButton(
          onPressed: () {
            // Pindah ke halaman utama
            _handleLogout(context);
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void _handleLogout(BuildContext context) async {
  // Hapus 'isLoggedIn' dari SharedPreferences saat logout
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');

  // Pindah ke halaman login setelah logout
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const LoginPage(), // Ganti dengan halaman login
    ),
    (route) => false, // Menghapus semua halaman lain dari tumpukan
  );
}
