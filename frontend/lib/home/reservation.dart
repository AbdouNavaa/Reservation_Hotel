import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';
import 'package:frontend/home/reservation_details.dart';

class ReservationPage extends StatefulWidget {
  final String username;
  final int id;
  final double price;

  const ReservationPage({super.key, required this.username, required this.id, required this.price});
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _usernameController = TextEditingController();
  final _roomIdController = TextEditingController();
  final _dateController = TextEditingController();
  final _PriceController = TextEditingController();
  final _daysController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.text = widget.username;
  _roomIdController.text = widget.id.toString();
  _PriceController.text = widget.price.toString();
}

  late BookService bookService ;

  // final date = _dateController.text;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Reservation'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),helperText: 'UserName',helperStyle: TextStyle(fontSize: 20)
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _roomIdController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      helperText: 'RoomId',helperStyle: TextStyle(fontSize: 20)
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _PriceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      helperText: 'Price',helperStyle: TextStyle(fontSize: 20)
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _daysController,
                  decoration: InputDecoration(
                    hintText: 'Enter reservation days',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      helperText: 'Days',helperStyle: TextStyle(fontSize: 20),
                  ),
                ),
                // TextField(
                //   controller: _dateController,
                //   decoration: InputDecoration(
                //     hintText: 'Enter reservation date (YYYY-MM-DD)',
                //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                //       helperText: 'Date',helperStyle: TextStyle(fontSize: 20)
                //   ),
                // ),
                // InputDecorator(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20))),
                SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: () {
                    // make reservation using username, room id, and date

                    // call API to make reservation
                    // ...
                    // bookService.createReservation(widget.username, widget.id, DateTime(DateTime.monthsPerYear)),

                    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>ReservationDetailsPage(username: widget.username,
              roomId: widget.id,date:DateTime.now(), price: widget.price, days:int.parse (_daysController.text),)),
    );
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(350, 50),backgroundColor: Colors.black),
                  child: Text('Submit'),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
