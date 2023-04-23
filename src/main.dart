import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import 'BoothInfo.dart';
import 'Reservation.dart';
import 'Login.dart';
import 'Event.dart';
import 'MyReservation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'GmarketSans',
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  String userEmail;
  User user;
  FirebaseAuth auth;

  MyHomePage({Key key, this.title, this.userEmail, this.user, this.auth})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  List<Widget> _children = [BoothInfoPage(), ReservationPage(), EventPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비거너겐',
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              child: SizedBox(
                width: 45,
                child: FlatButton(
                  color: Colors.green,
                  child: Icon(
                    Icons.today_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {
                    if (widget.user == null) {
                      _onAlert(context);
                    } else {
                      pushPage(context, MyReservationPage());
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '부스안내',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: '예약하기',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: '이벤트',
          ),
        ],
      ),
      body: _children[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '\n\nMenu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 44,
              ),
              title: Text(
                widget.user == null ? 'USER' : widget.user.displayName,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                widget.user == null ? 'USER Email' : widget.user.email,
              ),
            ),
            Divider(
              color: Colors.green,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.location_on_outlined,
                size: 30,
              ),
              title: Text(
                '부스안내',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                pushPage(context, ReservationPage());
              },
              leading: Icon(
                Icons.date_range_outlined,
                size: 30,
              ),
              title: Text(
                '예약하기',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                pushPage(context, MyReservationPage());
              },
              leading: Icon(
                Icons.today_outlined,
                size: 30,
              ),
              title: Text(
                '나의예약',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.cake_outlined,
                size: 30,
              ),
              title: Text(
                '이벤트',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              color: Colors.lightGreen[200],
              height: 55.0,
              child: FlatButton(
                child: Text(
                  widget.user == null ? '로그인/회원가입' : '로그아웃',
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () async {
                  final FirebaseAuth _auth = widget.auth;
                  if (widget.user == null) {
                    pushPage(context, loginPage());
                  } else {
                    String _userName = widget.user.displayName;
                    await _auth.signOut();
                    final String uid = widget.user.uid;
                    Toast.show(
                      '$_userName 님 로그아웃 완료!',
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.grey,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          userEmail: null,
                          user: null,
                          auth: null,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
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
      style: alertStyle,
      context: context,
      title: "로그인이 필요한 서비스입니다",
      image: Image.asset("assets/images/Warning.png"),
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
