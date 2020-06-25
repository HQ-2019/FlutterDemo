import 'package:demo/pages/web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const BANNER_HEIGHT = 200.0; // banner的默认高度

class _HomePageState extends State<HomePage> {
  // banner的默认高度
  double bannerHeight = BANNER_HEIGHT;

  final _imageUrlList = [
    'https://img4.mukewang.com/szimg/5d2e7ada09946f6f12000676.jpg',
    'https://img2.mukewang.com/szimg/5c8f014a0904310b02700148.jpg',
    'https://img1.mukewang.com/szimg/5d36a6000837a91d06000338.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            // 创建banner
            buildBanner(),
            Expanded(
                // MediaQuery.removePadding 移除顶部的 padding
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true, // 移除顶部默认留出的边距
                    child: NotificationListener(
                      onNotification: (scrollNotifation) {
                        // 判断ListView滚动的效果
                        if (scrollNotifation is ScrollUpdateNotification &&
                            scrollNotifation.depth == 0) {
                          // 滚动且是列表滚动的的的时候
                          double offset = scrollNotifation.metrics.pixels;
                          print('offset：${offset} ');

                          double bannerheight = bannerHeight;
                          if (offset <= 0) {
                            bannerheight = BANNER_HEIGHT - offset;
                          } else {
                            bannerheight = BANNER_HEIGHT;
                          }
                          // 更新UI状态
                          setState(() {
                            bannerHeight = bannerheight;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                          itemCount: 50,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.label_important),
                              title: Text('label_important'),
                              subtitle: Text('label_important'),
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                  return WebPage();
                                }));
                              },
                            );
                          }),
                    )))
          ],
        ),
      ),
    );
  }

  // 构建banner
  Widget buildBanner() {
    return Container(
      height: bannerHeight,
      color: Colors.grey,
      child: Swiper(
        itemCount: _imageUrlList.length,
        // 轮播个数
        duration: 500,
        // 设置每一次轮播的动画的持续时长(毫秒)
        autoplay: true,
        // 自动轮播
        autoplayDelay: 3000,
        // 设置轮播时间间隔(毫秒)
        // 设置轮播的图片
        itemBuilder: (context, index) {
          return Image.network(
            _imageUrlList[index],
            fit: BoxFit.cover, // 设置图片填充模式
          );
        },
        pagination: SwiperPagination(),
        // 页码
        onTap: (index) {
          print('点击第 ${index} 个banner');
          Navigator.push(
              context,
              CupertinoPageRoute<void>(
                  maintainState: true,
                  builder: (BuildContext context) {
                    return WebPage();
                  }));
        },
        onIndexChanged: (index) {
          print('切换到第 ${index} 个banner');
        },
      ),
    );
  }
}
