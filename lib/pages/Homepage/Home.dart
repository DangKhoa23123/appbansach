import 'package:flutter/material.dart';
import 'package:ungdungthuetro/pages/Homepage/Bookitem.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/Horror.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/Detective.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/foreignliterature.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/literature.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/manga.dart';
import 'package:ungdungthuetro/pages/Homepage/genre/novel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> books = [];
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
        child: Column(
          children: [
            // Banner section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  'assets/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Genre buttons
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildGenreButton(context, 'Kinh dị', Horror()),
                  _buildGenreButton(context, 'Trinh thám', Detective()),
                  _buildGenreButton(context, 'Văn học', Literature()),
                  _buildGenreButton(
                      context, 'Văn học nước ngoài', Foreignliterature()),
                  _buildGenreButton(context, 'Manga', Manga()),
                  _buildGenreButton(context, 'Tiểu thuyết', Novel()),
                ],
              ),
            ),

            // Books grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sách nổi bật',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return BookItem(
                            title: books[index]['title'], // Lấy tiêu đề sách
                            imageUrl: "http://192.168.99.113:3000" + books[index]['thumbnail'], // Lấy ảnh sách
                            // Lấy giá sách
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreButton(BuildContext context, String title, Widget page) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
        ),
        child: Text(title),
      ),
    );
  }
}
