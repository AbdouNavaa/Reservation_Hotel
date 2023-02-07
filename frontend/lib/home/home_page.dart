// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';
import 'package:frontend/pages/login.dart';

import 'HotelsByPlace.dart';
import 'booking.dart';

class Home extends StatefulWidget {
   Home({super.key});
  // final int? UserId;
  @override
  State<Home> createState() => _HomeState();
}
//
class _HomeState extends State<Home> {

  BookService bookService = BookService();
  // late List<Book>? books;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  TextEditingController _controller = TextEditingController();
   late String _searchTerm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
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
        body: Padding(
            padding: EdgeInsets.only(top: 10),
              child: Column(
              children: [
              TextField(
              controller: _controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30)),
              hintText: 'Enter search term',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
              onChanged: (value) {
                  setState(() {
                  _searchTerm = value;
                  });
                },
    ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(350, 40),backgroundColor: Colors.black),
                  onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HotelListScreen( search: _searchTerm,)),
                  );},
                      // bookService.getHotelsByPlace(_searchTerm),
                  child: Text('Search'),
                ),
    Expanded(child:
    FutureBuilder<List>(
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                HomeCard(onPessed: (){},
                                  icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last,
                                    onPressed: () {  }, hotelId:snapshot.data![i]["id"] ,),
                                  title:snapshot.data![i]["name"], place: snapshot.data![i]["place"], hotelId: (snapshot.data![i]["id"]),),
                                SizedBox(width: 15,),
                              ],
                            ),
                          ]
                      ),
                    ),
                  );
                });
          }else{return CircularProgressIndicator();
          }
        })
      ,)
    ])));
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({Key? key, required this.picAdderess, required this.onPressed, required this.hotelId}) : super(key: key);
  final String picAdderess;
  final VoidCallback onPressed;
  final int hotelId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BookingScreen(hotelId: hotelId,)),
        );
      },
      child: Container(
        color: Colors.grey,
        child: Image.asset(picAdderess, width: 290,height: 220,fit: BoxFit.cover,),
      ),
    )
    ;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key, required this.onPessed, required this.icon, required this.title, required this.place, required this.hotelId,
  }) : super(key: key);
  final VoidCallback onPessed;
  final UserPicture icon;
  final String title;
  final int hotelId;
  final String place;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPessed ,
      child: Container(
        // margin: EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width /1.2,
        height: MediaQuery.of(context).size.height/ 2.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
                Text(hotelId.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
                Text(place,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            )


          ],
        ),
      ),
    );
  }
}
