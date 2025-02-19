// import 'package:flutter/material.dart';
// import 'package:ungdungthuetro/api_config.dart';
// import 'package:ungdungthuetro/pages/Payment/Payment.dart';
//  // Import danh sách sách đã mua

// class Boughtbook extends StatefulWidget {
//   const Boughtbook({super.key});

//   @override
//   State<Boughtbook> createState() => _BoughtbookState();
// }

// class _BoughtbookState extends State<Boughtbook> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('Sách đã mua'),
//       ),
//       body: boughtBooks.isEmpty
//           ? Center(child: Text('Bạn chưa mua sách nào.'))
//           : ListView.builder(
//               itemCount: boughtBooks.length,
//               itemBuilder: (context, index) {
//                 var book = boughtBooks[index];

//                 return ListTile(
//                   leading: Image.network('${ApiConfig.baseUrl}${book['thumbnail']}'),
//                   title: Text(book['title']),
//                   subtitle: Text('${book['price']}đ'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () {
//                       setState(() {
//                         boughtBooks.removeAt(index);
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
