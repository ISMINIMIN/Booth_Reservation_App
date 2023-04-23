import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'DoReservation.dart';
import 'Login.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ReservationPage extends StatefulWidget {
  String userName;
  ReservationPage({Key key, this.userName}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 415,
          width: 350,
          child: Image.asset("assets/images/Reservation.png"),
        ),
        Divider(
          color: Colors.white,
        ),
        Container(
          height: 60,
          width: 350,
          child: DialogButton(
            color: Colors.green,
            child: Text(
              '예약하기',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                //fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              if (_auth.currentUser == null) {
                _onAlert(context);
              } else {
                pushPage(context, DoReservationPage());
              }
            },
          ),
        ),
      ],
    );
  }

  // 화면 교체 함수
  void pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  _onAlert(context) {
    var alertStyle = AlertStyle(
      titleStyle: TextStyle(
        color: Colors.grey,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      image: Image.asset("assets/images/Warning.png"),
      title: "로그인이 필요한 서비스입니다",
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            '확인',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              //fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {
            pushPage(context, loginPage());
          },
        ),
      ],
    ).show();
  }
}