import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';

class BookItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(bookName: 'Sách')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 120,
              color: Colors.grey[300],
              child: Icon(Icons.book, size: 50),
            ),
            SizedBox(height: 8),
            Text(
              'Tên sách',
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
