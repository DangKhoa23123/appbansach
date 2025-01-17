import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _MidState();
}

class _MidState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 50,
              height: 70,
              color: Colors.grey[300],
              child: Icon(Icons.book, size: 30),
            ),
            title: Text('Tên Sách $index'),
            subtitle: Text('Tác giả: Tên tác giả'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetail(bookName: 'Sách $index')),
              );
            },  
          );
        },
      ),
    );
  }
}