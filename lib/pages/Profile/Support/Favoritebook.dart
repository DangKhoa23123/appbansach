import 'package:flutter/material.dart';

class Favoritebook extends StatefulWidget {
  const Favoritebook({super.key});

  @override
  State<Favoritebook> createState() => _FavoritebookState();
}

class _FavoritebookState extends State<Favoritebook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sách yêu thích'),
      ),
    );
  }
}