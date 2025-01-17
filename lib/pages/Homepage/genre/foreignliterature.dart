import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';

class Foreignliterature extends StatefulWidget {
  const Foreignliterature({super.key});

  @override
  State<Foreignliterature> createState() => _ForeignliteratureState();
}

class _ForeignliteratureState extends State<Foreignliterature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Văn học nước ngoài'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return BookItem();
              },
            ),
             SizedBox(height: 50),
        ],
      )
    );
  }
}