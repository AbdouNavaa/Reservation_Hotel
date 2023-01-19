// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  BookService bookService = BookService();
  late List<Book>? books;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        leading: InkWell(
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            child: const Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.all(12.0)),
          OutlinedButton(
              style: OutlinedButton.styleFrom(),
              onPressed: () {},
              child: const Text(
                "Sing in",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: const TextField(
                  // onChanged: (value) {

                  // },
                  decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      suffixIcon: InkWell(
                          onTap: null,
                          child: Material(
                              color: Colors.blueGrey,
                              child: Icon(Icons.search)))),
                ),
              ),
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text("Single Room"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text("Double Room"),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text("Deluxe Room"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: const Text(
                    "Book",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
              FutureBuilder<ListOfBook?>(
              future: bookService.getBook(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      List<Book>? books = snapshot.data!.books;
                    return Container(
                      margin: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Recently Bookings",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Wrap(
                            children: [
                              ...books!.map((book) {
                                return Container(
                                  margin: EdgeInsets.all(10.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(children: [
                                    Text(book!.type),
                                    Text(book!.descriptionn),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                        child: Text("Book"),
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(),
                                      ),
                                    )
                                  ]),
                                );
                              }).toList(),
                            ],
                          )
                        ],
                      ),
                    );
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
class MyCustomScrollBeeviour extends MaterialScrollBehavior{
  @override
  Set<PointerDeviceKind> get dragDevice => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
// class ViewBooks extends StatelessWidget{
//   const ViewBooks(Key key, this.bookService, this.size)
//   final BookService? bookService;
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }