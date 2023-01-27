// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';
import 'package:frontend/pages/login.dart';

import 'booking.dart';

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
        title: Text('Hotel Booking', style: TextStyle(fontSize: 27, fontStyle: FontStyle.italic),),
        centerTitle: true,
        actions: [

          const Padding(padding: EdgeInsets.all(12.0)),

          IconButton(
            onPressed: () {     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ); },
            icon:  const Icon(
              Icons.logout_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List>(
                  future: bookService.getBook(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                          itemBuilder: (context, i){
                        return SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Row(
                                  children: [
                                    HomeCard(onPessed: (){},
                                      icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last, onPressed: () {  },),
                                      title:snapshot.data![i]["type"],),
                                    SizedBox(width: 15,),
                                    HomeCard(onPessed: (){},
                                      icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last, onPressed: () {  },),
                                      title:snapshot.data![i]["type"],),
                                  ],
                                ),
                            ]
                            )),
                        );
                      });
                    }else{return CircularProgressIndicator();};
                  })
      ),
    );
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({Key? key, required this.picAdderess, required this.onPressed}) : super(key: key);
  final String picAdderess;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BookingScreen()),
        );
      },
      child: CircleAvatar(
        minRadius: 50.0,
        maxRadius: 70.0,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(picAdderess),
      ),
    )
    ;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key, required this.onPessed, required this.icon, required this.title,
  }) : super(key: key);
  final VoidCallback onPessed;
  final UserPicture icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPessed ,
      child: Container(
        // margin: EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width /2.4,
        height: MediaQuery.of(context).size.height/ 3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
              ),),

            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingScreen()),
              );
            }, child: Text("Book"))
          ],
        ),
      ),
    );
  }
}
