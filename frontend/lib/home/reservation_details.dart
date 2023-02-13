import 'package:flutter/material.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String username;
  final int roomId;
  final double price;
  final int days;
  final DateTime date;

  ReservationDetailsPage({
    required this.username,
    required this.roomId,
    required this.date, required this.price, required this.days,
  });
  double total =0;

  @override
  Widget build(BuildContext context) {
    var total = price * days;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('Username: $username',
              style: TextStyle(fontSize: 20),),
            Text('Room ID: $roomId',style: TextStyle(fontSize: 20),),
            Text('Price : $price',style: TextStyle(fontSize: 20),),
            Text('days : $days',style: TextStyle(fontSize: 20),),
            Text('Total : $total',style: TextStyle(fontSize: 20),),
            Text('Date: $date',style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
