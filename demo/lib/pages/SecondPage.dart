import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String title;

  const SecondPage({Key key,  @required this.title}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState(this.title);
}

class _SecondPageState extends State<SecondPage> {
  final String text;

  _SecondPageState(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // 返回按钮
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 标题
        title: Text(
          this.text,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0, // 去掉阴影
      ),
      body: Center(
        child: Text(this.text),
      ),
    );
  }
}