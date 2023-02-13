import 'package:flutter/material.dart';

import '../booking.dart';
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
