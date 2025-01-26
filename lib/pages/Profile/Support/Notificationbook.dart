import 'package:flutter/material.dart';

class Notificationbook extends StatefulWidget {
  const Notificationbook({super.key});

  @override
  State<Notificationbook> createState() => _NotificationbookState();
}

class _NotificationbookState extends State<Notificationbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // Xử lý xóa tất cả thông báo
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_none,
                size: 100,
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: 16),
              Text(
                'Không có thông báo mới',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Bạn sẽ nhận được thông báo về các cập nhật mới',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
