import 'dart:math';

import 'package:demo/pages/web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:demo/pages/temp_page.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _NewsPageState extends State<NewsPage> {
  //定义一个AppBar 的透明度默认值
  double appBarAlpha = 0;

  List _imgUrls = [
    'http://pic1.nipic.com/2008-12-05/200812584425541_2.jpg',
    'http://pic18.nipic.com/20111129/4155754_234055006000_2.jpg',
    'http://b-ssl.duitang.com/uploads/item/201412/25/20141225204152_aYEc3.jpeg'
  ];

  List<NewsDataModel> _newsDataList = List.generate(
      40,
      (index) => NewsDataModel(
          title: index % 2 == 0
              ? '${index} - 收到货开始就安静上年都就看上的十大科技收到了睡觉啦大时间段是吉安爱是加拿大萨尽可能地卡萨'
              : '${index} - 涉及到快三年大',
          source: '某某网',
          comments: Random().nextInt(10000),
          coverImgUrl: 'http://pic1.nipic.com/2008-12-05/200812584425541_2.jpg',
          url: 'http://www.people.com.cn/n1/2020/0624/c32306-31759131.html'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 使用Stack 的作用就是让AppBar 叠加在上面
        body: Stack(
      children: <Widget>[
        // MediaQuery.removePadding 移除顶部的 padding
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          // 监听列表的滚动
          child: NotificationListener(
            // 滚动的回调
            onNotification: (scrollNotifation) {
              // 判断ListView滚动的效果
              if (scrollNotifation is ScrollUpdateNotification &&
                  scrollNotifation.depth == 0) {
                // 滚动且是列表滚动的的的时候
                double offset = scrollNotifation.metrics.pixels;
                print('offset：${offset} ');
                double alpha = offset / APPBAR_SCROLL_OFFSET;
                if (offset <= 0) {
                  alpha = 0;
                } else if (offset >= APPBAR_SCROLL_OFFSET) {
                  alpha = 1;
                }

                // 更新UI状态
                setState(() {
                  appBarAlpha = alpha;
                });
                print('alpha: ${alpha} ');
              }
              return true;
            },
            // 创建列表UI
            child: buildListView(),
          ),
        ),

        // 创建AppBar
        buildAppBar(),
      ],
    ));
  }

  // 创建一个能够改变透明度的导航栏
  Widget buildAppBar() {
    return Opacity(
      // 当列表滚动的时候 改变其透明度的值
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.orange),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              '资讯',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, appBarAlpha)),
            ),
          ),
        ),
      ),
    );
  }

  // 整个列表视图
  Widget buildListView() {
    return ListView.builder(
      itemCount: _newsDataList.length + 3,
      // 列表采用iOS边缘弹性效果
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // banner列表视图
        if (index == 0) {
          return buildBanner();
        }
        // 热门资讯
        if (index == 1) {
          return hotNewsList();
        }

        // 精彩资讯列表标题
        if (index == 2) {
          return Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 5,
                    color: Colors.deepOrange,
                  ),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    '热门推荐',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ));
        }

        // 精彩资讯列表
        return greatNewsItems(_newsDataList[index-3]);
      },
    );
  }

  // 创建banner
  Widget buildBanner() {
    return Container(
      height: 200,
      child: Swiper(
        itemCount: _imgUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          // 获取图片
          return Image.network(
            _imgUrls[index],
            // 适配方式
            fit: BoxFit.cover,
          );
        },
        // 添加一个页码指示器
        pagination: SwiperPagination(),
      ),
    );
  }

  // 精彩资讯item样式
  Widget greatNewsItems(NewsDataModel model) {
    return InkWell(
      // 设置点击事件
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute<void>(
                maintainState: false, //  是否前一个路由将保留在内存中
                builder: (BuildContext context) {
                  return WebPage(url: model.url);
                }));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '来源: ${model.source}  ${model.comments}人评论',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                Padding(padding: EdgeInsets.only(left: 15)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    model.coverImgUrl,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Divider(
            height: 1.0,
            color: Colors.black45,
          )
        ],
      ),
    );
  }

  // 热门资讯list
  Widget hotNewsList() {
    return InkWell(
      // 设置点击事件
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute<void>(
                maintainState: false, //  是否前一个路由将保留在内存中
                builder: (BuildContext context) {
                  return WebPage(url: _newsDataList[1].url);
                }));
      },
      child: Container(
        height: 120,
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 5,
                    color: Colors.deepOrange,
                  ),
                  Padding(padding: EdgeInsets.only(left: 5)),
                  Text(
                    '热门推荐',
                    textAlign: TextAlign.left,
                    style: TextStyle(
//                        backgroundColor: Colors.orange,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            _newsDataList[index].coverImgUrl,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

// 资讯数据model
class NewsDataModel {
  // 新闻标题
  final String title;

  // 来源
  final String source;

  // 评论数量
  final int comments;

  // 新闻配图
  final String coverImgUrl;

  final String url;

  const NewsDataModel({
    this.url,
    this.title,
    this.source,
    this.comments,
    this.coverImgUrl,
  });
}
