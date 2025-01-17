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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Banner(
              location: BannerLocation.topEnd,
              textDirection: TextDirection.ltr,
              message: '', // Leave the message empty
              layoutDirection: TextDirection.ltr,
              color: Colors.transparent, // Make the message area transparent
              child: Image.asset(
                'assets/banner.png', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Horror()),
                            );
                          },
                          child: Text('Kinh dị'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detective()),
                            );
                          },
                          child: Text('Trinh thám'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Literature()),
                            );
                          },
                          child: Text('Văn học'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Foreignliterature()),
                            );
                          },
                          child: Text('Văn học nước ngoài'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Manga()),
                            );
                          },
                          child: Text('Manga'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Novel()),
                            );
                          },
                          child: Text('Tiểu thuyết'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return BookItem();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
