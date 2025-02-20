import 'package:flutter/material.dart';
import 'package:ungdungthuetro/api_config.dart';
import 'package:ungdungthuetro/global.dart'; // Import danh sách lịch sử mua hàng

class Boughtbook extends StatelessWidget {
  const Boughtbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch Sử Mua Hàng'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: boughtBooksHistory.isEmpty
          ? Center(
              child: Text(
                'Chưa có sách nào được mua!',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
            )
          : ListView.builder(
              itemCount: boughtBooksHistory.length,
              itemBuilder: (context, index) {
                var book = boughtBooksHistory[index];
                return ListTile(
                  leading: Image.network(
                    '${ApiConfig.baseUrl}${book['thumbnail']}',
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(book['title']),
                  subtitle: Text('${book['price']}đ'),
                );
              },
            ),
    );
  }
}
