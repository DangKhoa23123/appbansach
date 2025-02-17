import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const BookItem({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded( // 📌 Sửa đổi ở đây để ảnh không tràn ra ngoài
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 4), // Tạo khoảng cách nhỏ
        SizedBox(
          height: 40, // 📌 Giới hạn chiều cao của tiêu đề để tránh tràn
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
