import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef GestureTapCallback = void Function(String str);

class SecondPage extends StatefulWidget {
  final String title;
  final GestureTapCallback onTap;

  const SecondPage({
    Key key,
    @required this.title,
    this.onTap
  }) : super(key: key);

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
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("点击回调事件"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                // 如果有设置事件则回调事件
                if (widget.onTap != null) {
                  widget.onTap(widget.title);
                }
              },
            ),
            FlatButton(
              child: Text("点击PUSH下一个页面"),
              color: Colors.blue,
              textColor: Colors.white,
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
            )
          ],
        ),
      ),
    );
  }
}
