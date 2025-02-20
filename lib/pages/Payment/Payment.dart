import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ungdungthuetro/api_config.dart';
import 'package:ungdungthuetro/global.dart';  // Giữ nguyên import này
import 'package:http/http.dart' as http;

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
    // Sử dụng globals. để truy cập biến
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
        // Kiểm tra purchasedBooks qua globals
        child: purchasedBooks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 100, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    const Text(
                      'Giỏ hàng trống',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    // Sử dụng globals.purchasedBooks
                    itemCount: purchasedBooks.length,
                    itemBuilder: (context, index) {
                      // Lấy book từ globals.purchasedBooks
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
                            contentPadding: const EdgeInsets.all(12),
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
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/default_book.png',
                                            fit: BoxFit.cover,
                                          ),
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
                          ),
                        ),
                      );
                    },
                  ),
                  // Bottom payment section
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
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
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
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
                              onPressed: _processPayment,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
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

  Future<void> _processPayment() async {
    List<Map<String, dynamic>> selectedBooks = [];
    List<String> selectedBookIds = [];
    for (int i = 0; i < purchasedBooks.length; i++) {
      if (_checkedItems[i]) {
        selectedBooks.add(purchasedBooks[i]);
        selectedBookIds.add(purchasedBooks[i]['id'].toString());
      }
    }

    if (selectedBookIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ít nhất một sách để thanh toán!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final url = Uri.parse("${ApiConfig.baseUrl}/api/payment");

    final body = jsonEncode({
      "username": globalUserName,
      "bookIds": selectedBookIds,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đơn hàng đã được tạo thành công!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Cập nhật history qua globals
        boughtBooksHistory.addAll(selectedBooks);
        
        setState(() {
          final selectedSet = Set<String>.from(selectedBookIds);
          purchasedBooks.removeWhere((book) => selectedSet.contains(book['id']));
          _checkedItems = List.generate(purchasedBooks.length, (index) => false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tạo đơn hàng thất bại!'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print("Error processing payment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lỗi kết nối đến server!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}