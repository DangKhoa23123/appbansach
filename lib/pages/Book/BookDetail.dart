import 'package:flutter/material.dart';
import 'package:ungdungthuetro/api_config.dart';

List<Map<String, dynamic>> purchasedBooks = [];

class BookDetail extends StatelessWidget {
  final Map<String, dynamic> book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi Tiết Sách',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh bìa sách
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: book['thumbnail'] != null
                          ? Image.network(
                              '${ApiConfig.baseUrl}' + book['thumbnail'],
                              fit: BoxFit.cover)
                          : Image.asset('assets/default_book.png',
                              fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề và tác giả
                    Text(
                      book['title'],
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tác giả: ${book['author']}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                    ),

                    SizedBox(height: 16),
                    // Đánh giá & lượt xem & số trang
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Text('${book['rating'] ?? '4.5'}/5.0'),
                              Text('Đánh giá',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.book, color: Colors.green),
                              Text('${book['pageCount'] ?? '320'}'),
                              Text('Trang',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.inventory, color: Colors.red),
                              Text('${book['quality'] ?? 'N/A'}'),
                              Text('Số lượng',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),
                    // Mô tả sách
                    Text('Mô tả sách',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900)),
                    SizedBox(height: 12),
                    Text(book['description'] ?? 'Không có mô tả.',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey.shade800)),

                    SizedBox(height: 24),
                    // Giá và nút Mua
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Giá', style: TextStyle(color: Colors.grey)),
                            Text('${book['price'] ?? '200.000'}đ',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade900)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            purchasedBooks.add(
                                book); // Thêm sách vào danh sách thay vì gán lại
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${book['title']} đã được thêm vào giỏ hàng!'),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Mua Sách',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
