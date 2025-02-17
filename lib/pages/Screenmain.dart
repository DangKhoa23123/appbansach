import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Home.dart';
import 'package:ungdungthuetro/pages/Book/Book.dart';
import 'package:ungdungthuetro/pages/Payment/Payment.dart';
import 'package:ungdungthuetro/pages/Profile/Profile.dart';
import 'package:ungdungthuetro/pages/SearchScreen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    super.key,
  });

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
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Tree Book',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: screens[chonTab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: chonTab,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (index) {
            setState(() {
              chonTab = index;
            });
          },
          items: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Thư viện'),
            _buildNavItem(
                Icons.shopping_bag_outlined, Icons.shopping_bag, 'Cửa hàng'),
            _buildNavItem(Icons.payment_outlined, Icons.payment, 'Thanh toán'),
            _buildNavItem(Icons.person_outline, Icons.person, 'Tôi'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData unselectedIcon, IconData selectedIcon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(unselectedIcon),
      activeIcon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(selectedIcon),
      ),
      label: label,
    );
  }
}
