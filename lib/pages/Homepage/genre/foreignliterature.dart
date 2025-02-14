import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/GenreBase.dart';

class Foreignliterature extends StatefulWidget {
  const Foreignliterature({super.key});

  @override
  State<Foreignliterature> createState() => _ForeignliteratureState();
}

class _ForeignliteratureState extends State<Foreignliterature> {
  List<dynamic> books = []; // Danh sách sách

  @override
  void initState() {
    super.initState();
    fetchBooks(); // Gọi API khi màn hình khởi tạo
  }

  Future<void> fetchBooks() async {
    final url = Uri.parse("http://192.168.99.113:3000/books/foreign-literature"); // API của bạn
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
      title: 'Văn học nước ngoài',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tất cả sách Văn học nước ngoài',
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
                      return BookItem(
                        title: books[index]['title'], // Tiêu đề sách
                        imageUrl: "http://192.168.99.113:3000" + books[index]['thumbnail'], // Ảnh sách
                        // price: books[index]['price'].toString(), // Giá sách
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
