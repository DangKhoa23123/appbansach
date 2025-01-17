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
        backgroundColor: Colors.green,
        title: Text('Thông báo'),
      ),
    );
  }
}