import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';

class Detective extends StatefulWidget {
  const Detective({super.key});

  @override
  State<Detective> createState() => _DetectiveState();
}

class _DetectiveState extends State<Detective> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trinh thám'),
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