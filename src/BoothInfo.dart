import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoothInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoothInfoPageState();
}

class _BoothInfoPageState extends State<BoothInfoPage> {
  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView(
        controller: controller,
        children: [
          SizedBox.expand(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/Booth_01.png',
                    width: 450, height: 450),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/Booth_02.png',
                    width: 450, height: 450),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/Booth_03.png',
                    width: 450, height: 450),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              child: Center(
                child: Image.asset('assets/images/Booth_04.png',
                    width: 450, height: 450),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
