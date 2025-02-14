import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';

class Literature extends StatefulWidget {
  const Literature({super.key});

  @override
  State<Literature> createState() => _LiteratureState();
}

class _LiteratureState extends State<Literature> {
  List<dynamic> books = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Văn học'),
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
                return BookItem(
                  title: books[index]['title'], // Lấy tiêu đề sách
                  imageUrl: books[index]['imageUrl'], // Lấy ảnh sách
                   // Lấy giá sách
                );
              },
            ),
             SizedBox(height: 50),
        ],
      )
    );
  }
}