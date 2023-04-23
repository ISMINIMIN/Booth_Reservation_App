import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReservationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<MyReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 예약'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text('MyReservation'),
        ),
      ),
    );
  }

}