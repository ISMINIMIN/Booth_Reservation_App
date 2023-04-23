import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  final String title = '회원가입';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
  String _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  // 이름 입력
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '이름',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '이름을 입력하세요';
                      }
                      return null;
                    },
                  ),

                  // SizedBox
                  SizedBox(height: 20),

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

                  // 회원가입
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: SignInButtonBuilder(
                      icon: Icons.person_add,
                      text: '회원가입',
                      backgroundColor: Colors.green,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _register();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //사용자 등록 처리
  void _register() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;
      user.updateProfile(displayName: _nameController.text);

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
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
}
