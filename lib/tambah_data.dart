import 'package:flutter/material.dart';

class TambahData extends StatefulWidget {
  const TambahData({super.key, required this.title});

  final String title;

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
