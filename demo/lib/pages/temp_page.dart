import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef GestureTapCallback = void Function(String str);

class TempPage extends StatefulWidget {
  final String title;
  final GestureTapCallback onTap;

  const TempPage({Key key, @required this.title, this.onTap}) : super(key: key);

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // 自定义返回按钮(需要实现返回事件)
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 返回按钮（有默认返回事件）
//        leading: BackButton(color: Colors.white),
        // 标题
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        elevation: 0, // 去掉阴影
      ),
      body: Container(
        // 设置一个渐变色的背景装饰
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffedeef0), Colors.black12],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
              ),
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
                            return TempPage(title: '北京市');
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
      ),
    );
  }
}
