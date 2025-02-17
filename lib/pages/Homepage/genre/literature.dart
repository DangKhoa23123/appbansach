import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ungdungthuetro/api_config.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/GenreBase.dart';
import 'package:http/http.dart' as http;


class Literature extends StatefulWidget {
  const Literature({super.key});

  @override
  State<Literature> createState() => _LiteratureState();
}

class _LiteratureState extends State<Literature> {
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Gọi API khi màn hình khởi tạo
  }

  Future<void> fetchBooks() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/books/Văn học"); // API của bạn
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          books = json.decode(response.body); // Lưu danh sách sách vào state
        });
      } else {
        print("Lỗi khi lấy dữ liệu: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenreBase(
      title: ' Văn học',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tất cả sách Văn học',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
          Expanded( // Sửa lỗi body ở đây
            child: books.isEmpty
                ? const Center(child: CircularProgressIndicator()) // Hiển thị loading khi chưa có dữ liệu
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Điều hướng đến trang chi tiết sách
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetail(book: books[index]),
                            ),
                          );
                        },
                        child: BookItem(
                          title: books[index]['title'], // Tiêu đề sách
                          imageUrl: "${ApiConfig.baseUrl}" + books[index]['thumbnail'], // Ảnh sách
                          // price: books[index]['price'].toString(), // Giá sách
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
