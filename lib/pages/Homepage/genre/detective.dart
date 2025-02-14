import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/GenreBase.dart';

class Detective extends StatefulWidget {
  const Detective({super.key});

  @override
  State<Detective> createState() => _DetectiveState();
}

class _DetectiveState extends State<Detective> {
  List<dynamic> books = [];
  @override
  Widget build(BuildContext context) {
    return GenreBase(
      title: 'Trinh thám',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sách Trinh Thám',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Khám phá những câu chuyện trinh thám hấp dẫn',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Mới nhất'),
                _buildFilterChip('Phổ biến'),
                _buildFilterChip('Đánh giá cao'),
                _buildFilterChip('Giá thấp đến cao'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 12,
          ),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue.shade200),
        ),
        onSelected: (bool selected) {
          // Xử lý lọc sách
        },
      ),
    );
  }
}
