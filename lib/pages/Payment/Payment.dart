import 'package:flutter/material.dart';
import 'package:ungdungthuetro/api_config.dart'; // Đảm bảo import API config
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: purchasedBooks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 100, color: Colors.grey.shade400),
                    SizedBox(height: 16),
                    Text(
                      'Giỏ hàng trống',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: purchasedBooks.length,
                    itemBuilder: (context, index) {
                      var book = purchasedBooks[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12),
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
                                  activeColor: Colors.blue.shade700,
                                ),
                                Container(
                                  width: 50,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: book['thumbnail'] != null
                                        ? Image.network(
                                            '${ApiConfig.baseUrl}${book['thumbnail']}',
                                            fit: BoxFit.cover)
                                        : Image.asset(
                                            'assets/default_book.png',
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              book['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            subtitle: Text(
                              '${book['price'] ?? '0'}đ',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red.shade400),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Xóa sách'),
                                    content: Text(
                                      'Bạn có chắc muốn xóa "${book['title']}" khỏi giỏ hàng?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text('Hủy',
                                            style: TextStyle(
                                                color: Colors.grey.shade700)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            purchasedBooks.removeAt(index);
                                            _checkedItems.removeAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade400,
                                        ),
                                        child: Text('Xóa'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Tổng tiền',
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    '${_calculateTotalPrice()}đ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final selectedBooks = purchasedBooks
                                    .asMap()
                                    .entries
                                    .where((entry) => _checkedItems[entry.key])
                                    .map((entry) => entry.value)
                                    .toList();

                                if (selectedBooks.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Vui lòng chọn ít nhất một sách để thanh toán!'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Thanh toán thành công!'),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Thanh toán',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < purchasedBooks.length; i++) {
      if (_checkedItems[i]) {
        total += int.tryParse(purchasedBooks[i]['price'].toString()) ?? 0;
      }
    }
    return total;
  }
}
