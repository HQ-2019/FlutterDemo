import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:demo/pages/SecondPage.dart';

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
                onNotification: (scrollNotifation){
                  // 判断ListView滚动的效果
                  if (scrollNotifation is ScrollUpdateNotification && scrollNotifation.depth == 0){
                    // 滚动且是列表滚动的的的时候
                    double offset =  scrollNotifation.metrics.pixels;
                    print('offset：${offset} ');
                    double alpha =  offset / APPBAR_SCROLL_OFFSET;
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

        )
    );
  }

  // 创建一个能够改变透明度的导航栏
  Widget buildAppBar() {
    return Opacity(
      // 当列表滚动的时候 改变其透明度的值
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.orange
        ),
        child: Center(
          child: Padding(padding: EdgeInsets.only(top: 20),
            child: Text(
              '热门资讯',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, appBarAlpha)
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {

        // 列表第一个放banner
        if (index == 0) {
          return buildBanner();
        }

        return ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('verified_user'),
          subtitle: Text('verified_user'),
          // 设置点击事件
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    maintainState: false, //  是否前一个路由将保留在内存中
                    builder: (BuildContext context) {
                      return SecondPage(title: 'ssssss');
                    }
                )
            );
          },
        );
      },
    );
  }

  // 创建banner
  Widget buildBanner() {
    return Container(
      height: 200,
      child:Swiper(
        itemCount: _imgUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context,int index){
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
}
