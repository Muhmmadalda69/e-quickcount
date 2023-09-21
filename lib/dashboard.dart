// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'tambah_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //REAL TIME
  String wibTime = '';
  String witTime = '';
  String witaTime = '';

  @override
  void initState() {
    super.initState();
    // Mulai timer untuk memperbarui waktu setiap detik.
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      updateTimes();
    });
  }

  void updateTimes() {
    final now = DateTime.now();
    final wit = now.toLocal().add(const Duration(hours: 1)); // WIT
    final wita = now.toLocal().add(const Duration(hours: 2)); // WITA

    setState(() {
      wibTime = DateFormat('HH:mm').format(now);
      witTime = DateFormat('HH:mm').format(wit);
      witaTime = DateFormat('HH:mm').format(wita);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
      ),
      body: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              'REAL TIME',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$wibTime WIB  |',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '  $witTime WIT  |',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '  $witaTime WITA',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const TambahData(
                      title: 'TAMBAH DATA',
                    )),
          );
        },
        hoverColor: Colors.indigo[400],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
