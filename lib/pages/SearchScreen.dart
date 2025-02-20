import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ungdungthuetro/api_config.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) return;
    
    setState(() {
      isLoading = true;
    });

    // Sử dụng query parameter "q" cho API của bạn
    final url = Uri.parse("${ApiConfig.baseUrl}/search?q=$query");
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
        });
      } else {
        print("Lỗi khi tìm kiếm: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối API: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Tìm kiếm sách...",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => searchBooks(searchController.text),
            ),
          ),
          onSubmitted: (query) => searchBooks(query),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : searchResults.isEmpty
              ? Center(child: Text("Nhập từ khóa để tìm sách"))
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetail(book: searchResults[index]),
                          ),
                        );
                      },
                      child: BookItem(
                        title: searchResults[index]['title'],
                        imageUrl: "${ApiConfig.baseUrl}" + searchResults[index]['thumbnail'],
                      ),
                    );
                  },
                ),
    );
  }
}
