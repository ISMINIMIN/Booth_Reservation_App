import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:toast/toast.dart';
import './Signup.dart';
import './main.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class loginPage extends StatefulWidget {
  String title = '로그인/회원가입';

  @override
  State<StatefulWidget> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
  String _error;
  String _userID;
  String _userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  // 이메일 입력
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '이메일을 입력하세요';
                      }
                      return null;
                    },
                  ),

                  // SizedBox
                  SizedBox(height: 20),

                  // 비밀번호 입력
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),

                  // SizedBox
                  SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          child: SignInButtonBuilder(
                            icon: Icons.login,
                            text: '로그인',
                            backgroundColor: Colors.green,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
                              }
                            },
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          child: SignInButtonBuilder(
                            icon: Icons.person_add,
                            text: '회원가입',
                            backgroundColor: Colors.green,
                            onPressed: () {
                              pushPage(context, RegisterPage());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox
                  SizedBox(height: 40),
                ],
              )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //이메일, 비밀번호 로그인 처리
  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      _userName = user.displayName;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
        Toast.show(
          '$_userName 님 로그인 완료!',
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
              userEmail : _userEmail,
              user: _auth.currentUser,
              auth: FirebaseAuth.instance,
            ),
          ),
        );
      } else {
        setState(() {
          _success = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _error = e.toString();
        _success = false;
      });
    }
  }

  void pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
