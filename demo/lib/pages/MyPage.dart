import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 0, // 去掉阴影
      ),
      body: Center(
        child: Text('我的'),
      ),
    );
  }

}