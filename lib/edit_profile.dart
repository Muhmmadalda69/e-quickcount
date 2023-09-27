// ignore_for_file: unused_import, use_build_context_synchronously, avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_quickcount/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.title});

  final String title;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();
  final TextEditingController _tpsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs.getString('currentUserId') ?? '';

    final userData = await getDataFromFirestore('users', currentUserId);

    setState(() {
      _nameController.text = userData['name'];
      _emailController.text = userData['email'];
      _kecamatanController.text = userData['kecamatan'] ?? '';
      _desaController.text = userData['desa'] ?? '';
      _tpsController.text = userData['tps'] ?? '';
    });
  }

  Future<void> _updateProfile() async {
    final firestore = FirebaseFirestore.instance;
    final prefs = await SharedPreferences.getInstance();

    final currentUserId = prefs.getString('currentUserId') ?? '';

    try {
      await firestore.collection('users').doc(currentUserId).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'kecamatan': _kecamatanController.text,
        'desa': _desaController.text,
        'tps': _tpsController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui'),
        ),
      );

      Navigator.of(context)
          .pop(); // Kembali ke halaman profil setelah berhasil memperbarui profil
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memperbarui profil'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF005AE1),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF005AE1),
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kecamatan',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF005AE1),
              ),
            ),
            TextField(
              controller: _kecamatanController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Desa',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF005AE1),
              ),
            ),
            TextField(
              controller: _desaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'TPS',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF005AE1),
              ),
            ),
            TextField(
              controller: _tpsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateProfile();
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF005AE1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
