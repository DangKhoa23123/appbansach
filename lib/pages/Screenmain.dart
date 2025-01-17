import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Home.dart';
import 'package:ungdungthuetro/pages/Book/Book.dart';
import 'package:ungdungthuetro/pages/Payment/Payment.dart';
import 'package:ungdungthuetro/pages/Profile/Profile.dart';

class Mainscreen extends StatefulWidget {

  const Mainscreen({super.key,});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int chonTab = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> screens = [
    
    Home(),
    Book(),
    Payment(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text('Tree book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Xử lý tìm kiếm
            },
          ),
        ],
      ),
      body: screens[chonTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: chonTab,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            chonTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cửa hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Thanh toán',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
      ),
    );
  }
}
