import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'EventInfo.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPagetState createState() => _EventPagetState();
}

class _EventPagetState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 415,
          width: 350,
          child: Image.asset('assets/images/Event.png'),
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
              '이벤트 참여하기',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                //fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              pushPage(context, EventInfoPage());
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
}
