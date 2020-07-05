import 'package:demo/pages/web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// banner + tabBar + list 的视图结构
/// 当列表往上滑动时 banner会部分变成导航栏，tabBar会固定在顶部
/// 当列表往下滑动时 banner会跟随，直到全部展示后固定在顶部

class NestadSrcollPage extends StatefulWidget {
  @override
  _NestadSrcollPage createState() => _NestadSrcollPage();
}

class _NestadSrcollPage extends State<NestadSrcollPage> with AutomaticKeepAliveClientMixin {
  final List _tabTitleList = ['tab_1', 'tab_2', 'tab_3', 'tab_4', 'tab_5'];
  final _bannerUrl =
      'http://pic18.nipic.com/20111129/4155754_234055006000_2.jpg';

  /// AutomaticKeepAliveClientMixin实现页面保活状态，切换页面时不会被重置
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabTitleList.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                // SliverAppBar包含一个AppBar, AppBar的导航栏效果由floating、pinned、snap组合控制
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true, // 上拉时是否吸附在顶部
                  snap: false,
                  // 设置导航栏的颜色
                  backgroundColor: Colors.orange,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      // 设置background在列表滚动时的运动模式
                      collapseMode: CollapseMode.parallax,
                      title: Text(
                        "导航栏title",
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      background: Image.network(
                        _bannerUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverPersistentHeader(
                  pinned: true, // 列表上拉tabbar是否吸附在顶部
                  delegate: SliverTabBarDelegate(
                    TabBar(
                      tabs: _tabTitleList.map((f) => Tab(text: f)).toList(),
                      indicatorColor: Colors.deepOrangeAccent,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.orange,
                    ),
                    color: Color.fromRGBO(230, 230, 230, 1), // tabBar的背景色
                  ),
                ),
              ];
            },
            body: MediaQuery.removePadding(
                context: context,
                removeTop: true, // 移除TabBarView顶部的padding
                child: TabBarView(
                  children: _tabTitleList
                      .map((i) => ListView.builder(
                            itemCount: 50,
                            itemBuilder: (context, k) => ListTile(
                              leading: Icon(Icons.label_important),
                              title: Text('${i}'),
                              subtitle: Text('s就开始你打开十几年ds_${k}'),
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                  return WebPage(url: 'https://www.baidu.com');
                                }));
                              },
                            ),
                          ))
                      .toList(),
                )),
          ),
        ));
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
