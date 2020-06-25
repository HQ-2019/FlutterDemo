import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/temp_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
// 创建列表数据
  final _todoList = [
    Todo('密码管理', Icons.keyboard),
    Todo('银行卡管理', Icons.credit_card),
    Todo('帮助中心', Icons.help),
    Todo('设置', Icons.settings)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 去掉阴影
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 120,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg_me_top@3x.png'),
                    fit: BoxFit.fill),
//                color: Colors.orange,
//                borderRadius: BorderRadius.all(Radius.circular(4.0)), // 设置圆角
//                border: new Border.all(width: 1, color: Colors.green) // 设置边框
              ),
              child: Center(
                  child: Container(
                alignment: Alignment(-0.9, 0.0),
                child: RaisedButton.icon(
                  onPressed: () {},
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  color: Colors.transparent,
                  icon: Icon(Icons.supervised_user_circle, color: Colors.white),
                  label: Text('18600218888',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 25)),
                ),
              ))),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(_todoList[index].icon),
                    title: Text(
                      _todoList[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    // 设置点击事件
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute<void>(
                              maintainState: false, //  是否前一个路由将保留在内存中
                              builder: (BuildContext context) {
                                return TempPage(
                                  title: _todoList[index].title,
                                  onTap: (str) {
                                    print('回调信息是 ${str}');
                                  },
                                );
                              }));
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 创建一个数据实体类
class Todo {
  final String title;
  final IconData icon;

  // 构造函数
  Todo(this.title, this.icon);
}
