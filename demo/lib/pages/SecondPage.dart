import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String title;

  const SecondPage({Key key, @required this.title}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // 返回按钮
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 标题
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        elevation: 0, // 去掉阴影
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          iconSize: 50,
          onPressed: () {
            // push到下一个页面
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => SecondPage(title: '北京市')));
            Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    maintainState: false, //  是否前一个路由将保留在内存中
                    builder: (BuildContext context) {
                      return SecondPage(title: '北京市');
                    }));
            // push到下一个页面，并把当前的页面彻底移除
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => SecondPage(title: '北京市')));
          },
        ),
      ),
    );
  }
}
