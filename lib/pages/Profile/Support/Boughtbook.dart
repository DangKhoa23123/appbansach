import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';


class Boughtbook extends StatefulWidget {
  const Boughtbook({super.key});

  @override
  State<Boughtbook> createState() => _BoughtbookState();
}


class _BoughtbookState extends State<Boughtbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sách đã mua'),
      ),
      body: purchasedBooks.isEmpty
          ? Center(child: Text('Bạn chưa mua sách nào.'))
          : ListView.builder(
              itemCount: purchasedBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                            'assets/Harry Potter và Hòn đá Phù thủy.png', // Replace with your image asset path
                            fit: BoxFit.cover,
                          ),
                  title: Text('Harry Potter và Hòn đá Phù thủy'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Hiển thị hộp thoại xác nhận
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Xóa sách'),
                          content: Text(
                              'Bạn có chắc chắn muốn xóa "${purchasedBooks[index]}" khỏi danh sách?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Đóng hộp thoại
                              },
                              child: Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  purchasedBooks.removeAt(index); // Xóa sách
                                });
                                Navigator.pop(context); // Đóng hộp thoại
                              },
                              child: Text('Xóa',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => BookDetail(bookName: 'Sách')),
                    // );
                  },
                );
              },
            ),
    );
  }
}
