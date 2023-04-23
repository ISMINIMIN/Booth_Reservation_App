import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class DoReservationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoReservationPageState();
}

class _DoReservationPageState extends State<DoReservationPage> {
  String _boothItem, _timeItem, _pNumItem;
  DateTime dateItem;
  String dateItemFormat;
  final _boothList = ['부스(1) - 비건 음식 조리', '부스(2) - 비건 의류 제작', '부스(3) - 비건 화장품 제작'];
  final _timeList = ['오전 10시', '오전 11시', '오후 1시', '오후 2시', '오후 3시'];
  final _pNumList = ['1인', '2인', '3인', '4인', '5인', '6인', '7인', '8인', '9인', '단체(10인)'];
  var _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initAndroidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIosSetting = IOSInitializationSettings();
    var initSetting = InitializationSettings(initAndroidSetting, initIosSetting);
    FlutterLocalNotificationsPlugin().initialize(initSetting);
  }


  @override
  Widget build(BuildContext context) {
    String userName = _auth.currentUser.displayName;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('예약하기'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 25,
            width: 340,
            alignment: Alignment.centerLeft,
            child: Text(
              'STEP 1  부스 선택하기',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                alignment: Alignment.center,
                child: Text('부스선택', style: TextStyle(fontSize: 20)),
              ),
              Container(
                height: 50,
                width: 220,
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                  value: _boothItem,
                  onChanged: (value) {
                    setState(() {
                      _boothItem = value;
                    });
                  },
                  items: _boothList
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            height: 25,
            width: 340,
            alignment: Alignment.centerLeft,
            child: Text(
              'STEP 2  일시 선택하기',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                alignment: Alignment.center,
                child: Text('날짜선택', style: TextStyle(fontSize: 20)),
              ),
              Container(
                height: 50,
                width: 220,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 0, top: 10,right: 0, bottom: 10),
                    child: Text(
                        dateItemFormat == null ? '날짜를 선택해주세요' : dateItemFormat,
                        style: TextStyle(fontSize: 16)
                    ),
                  ),
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1),
                      maxTime: DateTime(2021, 1, 31),
                      theme: DatePickerTheme(
                          headerColor: Colors.green,
                          itemStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          doneStyle: TextStyle(
                            color: Colors.white,
                          ),
                          cancelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onConfirm: (date) {
                        if (date != null) {
                          setState(() {
                            dateItem = date;
                            dateItemFormat = DateFormat('yyyy년 MM월 dd일').format(dateItem);
                          });
                        }
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.ko,
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                alignment: Alignment.center,
                child: Text('시간선택', style: TextStyle(fontSize: 20)),
              ),
              Container(
                height: 50,
                width: 220,
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                  value: _timeItem,
                  onChanged: (value) {
                    setState(() {
                      _timeItem = value;
                    });
                  },
                  items: _timeList
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            height: 25,
            width: 340,
            alignment: Alignment.centerLeft,
            child: Text(
              'STEP 3  세부사항 선택하기',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                alignment: Alignment.center,
                child: Text('예약자명', style: TextStyle(fontSize: 20)),
              ),
              Container(
                height: 50,
                width: 220,
                alignment: Alignment.centerLeft,
                child: Text('$userName', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                width: 80,
                alignment: Alignment.center,
                child: Text('인원선택', style: TextStyle(fontSize: 20)),
              ),
              Container(
                height: 50,
                width: 220,
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                  value: _pNumItem,
                  onChanged: (value) {
                    setState(() {
                      _pNumItem = value;
                    });
                  },
                  items: _pNumList
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                _pNumItem == '1인' ? '결제금액 : 5,000원       ' :
                (_pNumItem == '2인' ? '결제금액 : 10,000원       ' :
                (_pNumItem == '3인' ? '결제금액 : 15,000원       ' :
                (_pNumItem == '4인' ? '결제금액 : 20,000원       ' :
                (_pNumItem == '5인' ? '결제금액 : 25,000원       ' :
                (_pNumItem == '6인' ? '결제금액 : 30,000원       ' :
                (_pNumItem == '7인' ? '결제금액 : 35,000원       ' :
                (_pNumItem == '8인' ? '결제금액 : 40,000원       ' :
                (_pNumItem == '9인' ? '결제금액 : 45,000원       ' :
                (_pNumItem == '단체(10인)' ? '결제금액 : 50,000원       ' : ''))))))))),
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            )
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
                '결제하기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                showNotification();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);

    await FlutterLocalNotificationsPlugin().show(0, '결제', '결제가 완료되었습니다', platform);
  }
}