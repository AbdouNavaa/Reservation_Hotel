import 'package:flutter/material.dart';

import '../HotelsByPlace.dart';
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
