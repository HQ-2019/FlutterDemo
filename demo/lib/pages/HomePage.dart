import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _imageUrlList = [
    'https://img4.mukewang.com/szimg/5d2e7ada09946f6f12000676.jpg',
    'https://img1.mukewang.com/5d3fe66408c059fd06000338-240-135.jpg',
    'https://img2.mukewang.com/szimg/5c8f014a0904310b02700148.jpg',
    'https://img1.mukewang.com/szimg/5d36a6000837a91d06000338.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          '首页',
//          style: TextStyle(
//              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
//        ),
//        backgroundColor: Colors.blue,
//        elevation: 0, // 去掉阴影
//      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Colors.grey,
              child: Swiper(
                itemCount: _imageUrlList.length, // 轮播个数
                duration: 500, // 设置每一次轮播的动画的持续时长(毫秒)
                autoplay: true, // 自动轮播
                autoplayDelay: 3000, // 设置轮播时间间隔(毫秒)
                // 设置轮播的图片
                itemBuilder: (context, index) {
                  return Image.network(
                    _imageUrlList[index],
                    fit: BoxFit.fill, // 设置图片填充模式
                  );
                },
                pagination: SwiperPagination(), // 页码
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  new ListTile(
                    leading: Icon(Icons.label_important),
                    title: Text('label_important'),
                    subtitle: Text('label_important'),
                  ),
                  new ListTile(
                    leading: Icon(Icons.gamepad),
                    title: Text('gamepad'),
                    subtitle: Text('gamepad'),
                  ),
                  new ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('verified_user'),
                    subtitle: Text('verified_user'),
                  ),
                  new ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('dashboard'),
                    subtitle: Text('dashboard'),
                  ),
                  new ListTile(
                    leading: Icon(Icons.security),
                    title: Text('security'),
                    subtitle: Text('security'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}