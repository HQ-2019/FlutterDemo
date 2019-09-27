import 'package:demo/pages/HomePage.dart';
import 'package:demo/pages/LoanListPage.dart';
import 'package:demo/pages/MyPage.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _TabNavigatorState();
//  }

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  // tabbar默认状态颜色
  final _normalColor = Colors.grey;
  // tabbar选中状态颜色
  final _seletedColor = Colors.yellow.shade900;

  // 当前显示的控制器的索引
  int _currentIndex = 0;

  // tab标题列表
  final _titleList = ['首页', '借款', '我的'];

  // tab图标列表
  var _iconList;

  // 页面列表
  var _pageList;

  // 当前显示的控制器
  final PageController _controller = PageController(
    initialPage: 0, // 默认显示第1个
  );

  /*
   * 初始化数据源
   * @author huangqun by 2019/9/27.
   */
  void initData() {
    _iconList = [
      [
        getImage('images/tab_home_icon_a@3x.png'),
        getImage('images/tab_home_icon_d@3x.png')
      ],
      [
        getImage('images/tab_me_icon_a@3x.png'),
        getImage('images/tab_me_icon_d@3x.png')
      ],
      [
        getImage('images/tab_zhangdan_icon_a@3x.png'),
        getImage('images/tab_zhangdan_icon_d@3x.png')
      ]
    ];

    _pageList = [HomePage(), LoanListPage(), MyPage()];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化数据
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: buildPageView(),  // 构建页面
      bottomNavigationBar: buildBottomNavigationBar(),  // 构建底部导航器
    );
  }

  // 测试代码
  List<Widget> testPageView() {
    return <Widget>[
      Container(
        color: Colors.yellow,
        child: Center(
          child: Text(
            '第一个pageView',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
      Container(
        color: Colors.red,
        child: Center(
          child: Text(
            '第二个pageView',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
      Container(
        color: Colors.green,
        child: Center(
          child: Text(
            '第三个pageView',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      )
    ];
  }

  /*
   * 创建page页面
   * @author huangqun by 2019/9/27.
   */
  Widget buildPageView() {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(), // 禁止滚动
      children: _pageList,
//        children: testPageView(),
      onPageChanged: (index) {
        print('页面切换到 index ${index}');
      },
    );
  }

  /*
   * 创建底部导航器
   * @author huangqun by 2019/9/27.
   */
  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      // 设置tabbar点击
      onTap: (index) {
        _controller.jumpToPage(index);
        setState(() {
          _currentIndex = index;
        });
      },
      items: List.generate(
          3,
          (i) => BottomNavigationBarItem(
              icon: getTabIcon(i), title: getTabTitle(i))),
//          items: [
//            BottomNavigationBarItem(
//              icon: getTabIcon(0), title: getTabTitle(0)
//            ),
//            BottomNavigationBarItem(
//                icon: getTabIcon(1), title: getTabTitle(1)
//            ),
//            BottomNavigationBarItem(
//                icon: Icon(Icons.search, color: _normalColor),
//                activeIcon: Icon(Icons.search, color: _seletedColor),
//                title: Text(
//                  '我的',
//                  style: TextStyle(
//                      color: _currentIndex == 2 ? _seletedColor : _normalColor
//                  ),
//                )
//            )
//          ]
    );
  }

  /*
   * 获取对应索引的tabar文本
   * @author huangqun by 2019-08-14.
   */
  Text getTabTitle(int index) {
    return Text(
      _titleList[index],
      style: TextStyle(
          fontSize: 12,
          color: _currentIndex == index ? _seletedColor : _normalColor),
    );
  }

  /*
   * 获取对应索引的tabar图标
   * @author huangqun by 2019-08-14.
   */
  Image getTabIcon(int index) {
    return _currentIndex == index ? _iconList[index][0] : _iconList[index][1];
  }

  /*
   * 获取对应路径下的图片资源
   * @author huangqun by 2019-08-14.
   */
  Image getImage(String path) {
    return Image.asset(path, width: 30.0, height: 30.0);
  }
}
