import 'package:flutter/material.dart';

List<String> purchasedBooks = [];

class BookDetail extends StatelessWidget {
  final String bookName;

  BookDetail({required this.bookName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết Sách'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 200,
                color: Colors.grey[300],
                child: Image.asset(
                'assets/Harry Potter và Hòn đá Phù thủy.png', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Harry Potter và Hòn đá Phù thủy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tác giả: J.K. Rowling',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Mô tả sách:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Khi một lá thư được gởi đến cho cậu bé Harry Potter bình thường và bất hạnh, cậu khám phá ra một bí mật đã được che giấu suốt cả một thập kỉ. Cha mẹ cậu chính là phù thủy và cả hai đã bị lời nguyền của Chúa tể Hắc ám giết hại khi Harry mới chỉ là một đứa trẻ, và bằng cách nào đó, cậu đã giữ được mạng sống của mình. Thoát khỏi những người giám hộ Muggle không thể chịu đựng nổi để nhập học vào trường Hogwarts, một trường đào tạo phù thủy với những bóng ma và phép thuật, Harry tình cờ dấn thân vào một cuộc phiêu lưu đầy gai góc khi cậu phát hiện ra một con chó ba đầu đang canh giữ một căn phòng trên tầng ba. Rồi Harry nghe nói đến một viên đá bị mất tích sở hữu những sức mạnh lạ kì, rất quí giá, vô cùng nguy hiểm, mà cũng có thể là mang cả hai đặc điểm trên.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text('Đọc Thử'),
                // ),
                Text('Giá: 200.000 '),
                ElevatedButton(
                  onPressed: () {
                    purchasedBooks.add(bookName);

                    // Hiển thị thông báo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$bookName đã được thêm vào giỏ hàng!'),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Text('Mua Sách'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}