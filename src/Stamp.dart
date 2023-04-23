import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StampPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StampPageState();
}

class StampPageState extends State<StampPage> {
  List<String> _qrcode = List<String>(3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('나의 스탬프'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '부스1',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                          height: 95,
                          width: 95,
                          child: _qrcode[0] == 'VEGAN_Booth1'
                              ? Image.asset('assets/images/Booth1_success.png')
                              : Image.asset('assets/images/Booth1_normal.png')),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '부스2',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                          height: 95,
                          width: 95,
                          child: _qrcode[1] == 'VEGAN_Booth2'
                              ? Image.asset('assets/images/Booth2_success.png')
                              : Image.asset('assets/images/Booth2_normal.png')),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '부스3',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                          height: 95,
                          width: 95,
                          child: _qrcode[2] == 'VEGAN_Booth3'
                              ? Image.asset('assets/images/Booth3_success.png')
                              : Image.asset('assets/images/Booth3_normal.png')),
                    ]),
              ]),
          Divider(
            color: Colors.white,
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
                _qrcode[0]=='VEGAN_Booth1'&&_qrcode[1]=='VEGAN_Booth2'&&_qrcode[2]=='VEGAN_Booth3' ? '샐러드 받기' : 'QR 인증하기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                if(_qrcode[0]=='VEGAN_Booth1'&&_qrcode[1]=='VEGAN_Booth2'&&_qrcode[2]=='VEGAN_Booth3') {
                  _onAlert(context);
                } else {
                  _fromPhoto();
                }
              },
            ),
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
                '메인으로 돌아가기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 카메라를 이용해서 읽어들이기
  Future<void> _fromCamera() async {
    String qrcode = await scanner.scan();

    if (qrcode == 'VEGAN_Booth1') {
      setState(() {
        _qrcode[0] = qrcode;
      });
    } else if (qrcode == 'VEGAN_Booth2') {
      setState(() {
        _qrcode[1] = qrcode;
      });
    } else if (qrcode == 'VEGAN_Booth3') {
      setState(() {
        _qrcode[2] = qrcode;
      });
    }
  }

  // 사진으로부터 읽어들이기
  Future<void> _fromPhoto() async {
    print('QRCODE : $_qrcode');
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    Uint8List bytes = file.readAsBytesSync();
    String qrcode = await scanner.scanBytes(bytes);

    if (qrcode == 'VEGAN_Booth1') {
      setState(() {
        _qrcode[0] = qrcode;
      });
    } else if (qrcode == 'VEGAN_Booth2') {
      setState(() {
        _qrcode[1] = qrcode;
      });
    } else if (qrcode == 'VEGAN_Booth3') {
      setState(() {
        _qrcode[2] = qrcode;
      });
    }
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
      style: alertStyle,
      context: context,
      title: '(綠)부스에서 상품과 교환하세요 !',
      image: Image.asset("assets/images/StampSuccess_2.png"),
      buttons: [
        DialogButton(
          child: Text(
            "대단해 !",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 250,
        )
      ],
    ).show();
  }
}
