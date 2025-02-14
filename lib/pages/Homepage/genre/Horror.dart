import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/GenreBase.dart';


class Horror extends StatefulWidget {
  const Horror({super.key});

  @override
  State<Horror> createState() => _HorrorState();
}

class _HorrorState extends State<Horror> {
  List<dynamic> books = [];
  @override
  Widget build(BuildContext context) {
    return GenreBase(
      title: 'Kinh dị',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tất cả sách kinh dị',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
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
            ),
          ),
        ],
      ),
    );
  }
}
