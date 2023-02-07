import 'package:flutter/material.dart';
// import 'package:hotel_app/models/hotel.dart';

import '../data_service/book_service.dart';
import 'booking.dart';

class HotelListScreen extends StatelessWidget {
  // final List<Hotel> hotels;

  HotelListScreen({required this.search});
  final String search;
BookService bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hôtels de '+search),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List>(
          future: bookService.getHotelsByPlace(search),
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
      ,);
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
