import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Book/BookDetail.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<bool> _checkedItems = [];

  @override
  void initState() {
    super.initState();
    _checkedItems = List.generate(purchasedBooks.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh Toán'),
      ),
      body: purchasedBooks.isEmpty
          ? Center(child: Text('Bạn chưa mua sách nào.'))
          : Stack(
              children: [
                ListView.builder(
                  itemCount: purchasedBooks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _checkedItems[index],
                            onChanged: (value) {
                              setState(() {
                                _checkedItems[index] = value ?? false;
                              });
                            },
                          ),
                          Image.asset(
                            'assets/Harry Potter và Hòn đá Phù thủy.png', // Replace with your image asset path
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      title: Text('Harry Potter và Hòn đá Phù thủy'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Xóa sách'),
                              content: Text(
                                  'Bạn có chắc chắn muốn xóa "${purchasedBooks[index]}" khỏi danh sách?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Hủy'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      purchasedBooks.removeAt(index);
                                      _checkedItems.removeAt(index);
                                    });
                                    Navigator.pop(context);
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookDetail(bookName: purchasedBooks[index])),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      final selectedBooks = purchasedBooks
                          .asMap()
                          .entries
                          .where((entry) => _checkedItems[entry.key])
                          .map((entry) => entry.value)
                          .toList();

                      if (selectedBooks.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Vui lòng chọn ít nhất một sách để thanh toán!'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Thanh toán thành công cho: ${selectedBooks.join(', ')}'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.payment, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
