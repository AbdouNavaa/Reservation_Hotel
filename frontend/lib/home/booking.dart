import 'package:flutter/material.dart';

import '../data_service/book_service.dart';

class BookingScreen extends StatefulWidget {
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // const BookingScreen({Key? key}) : super(key: key);
  BookService bookService = BookService();
  late List<Book>? books;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details'),),
      body: Container(
        color: Colors.white,
          // child: FutureBuilder<List>(
          //     future: bookService.getBook(),
          //     builder: (context, snapshot) {
          //       print(snapshot.data);
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //             itemCount: snapshot.data?.length,
          //             itemBuilder: (context, i){
          //               return SingleChildScrollView(
          //                 child: Container(
          //                     margin: EdgeInsets.all(20),
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(20)
          //                     ),
          //                     child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.start,
          //                         children:[
          //                           Row(
          //                             children: [
          //                               CircleAvatar(ch Ima('images/'+ snapshot.data![i]["image"].split('/').last)),
          //
          //                                 Text(snapshot.data![i]["type"],),
          //                               SizedBox(width: 15,),
          //                               HomeCard(onPessed: (){},
          //                                 icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last, onPressed: () {  },),
          //                                 title:snapshot.data![i]["type"],),
          //                             ],
          //                           ),
          //                         ]
          //                     )),
          //               );
          //             });
          //       }else{return CircularProgressIndicator();};
          //     })
      ),
    );
  }
}
