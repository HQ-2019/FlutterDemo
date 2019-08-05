import 'package:flutter/material.dart';
import 'package:demo/pages/SecondPage.dart';

class MyPage extends StatefulWidget {

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  // 创建列表数据
  final _todoList = List<Todo>.generate(20, (i) => Todo('Title $i', 'this is a subTitle '));

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
        child: ListView.builder(
          itemCount: _todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.gamepad),
                title: Text(_todoList[index].title),
                subtitle: Text(_todoList[index].subTitle),
                trailing: Icon(Icons.keyboard_arrow_right),
                // 设置点击事件
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondPage(title: _todoList[index].title),
                      ),
                  );
                },
              );
            },
        ),
      ),
    );
  }
}

// 创建一个数据实体类
class Todo {
  final String title;
  final String subTitle;

  // 构造函数
  Todo(this.title, this.subTitle);
}