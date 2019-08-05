import 'package:demo/pages/HomePage.dart';
import 'package:demo/pages/LoanListPage.dart';
import 'package:demo/pages/MyPage.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  // tabbar默认状态颜色
  final _normalColor = Colors.grey;
  // tabbar选中状态颜色
  final _seletedColor = Colors.blue;

  // 当前显示的控制器的索引
  int _currentIndex = 0;

  // 当前显示的控制器
  final PageController _controller = PageController(
    initialPage: 0, // 默认显示第1个
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),  // 禁止滚动
        children: <Widget>[
          HomePage(),
          LoanListPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          // 设置tabbar点击
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              // 正常状态下的icon
              icon: Icon(Icons.home, color: _normalColor),
              // 选中状态下的icon
              activeIcon: Icon(Icons.home, color: _seletedColor),
              title: Text(
                '首页',
                style: TextStyle(
                  color: _currentIndex == 0 ? _seletedColor : _normalColor
                ),
              )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm, color: _normalColor),
                activeIcon: Icon(Icons.access_alarm, color: _seletedColor),
                title: Text(
                  '借款',
                  style: TextStyle(
                      color: _currentIndex == 1 ? _seletedColor : _normalColor
                  ),
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _normalColor),
                activeIcon: Icon(Icons.search, color: _seletedColor),
                title: Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex == 2 ? _seletedColor : _normalColor
                  ),
                )
            )
          ]
      ),
    );
  }

}