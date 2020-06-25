import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
* Flutter项目中使用webView需要注意事项
*
* 1、在iOS工程的info.plist文件中增加网络支持
* <key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
		<key>NSAllowsArbitraryLoadsInWebContent</key>
		<true/>
	</dict>
*
* 2、编译时如果报错Trying to embed a platform view but the PrerollContext does not support embedding
* 需要在iOS工程的info.plist文件中增加
* <key>io.flutter.embedded_views_preview</key>
	<true/>
* */

class WebPage extends StatefulWidget {
  @override
  _WebPage createState() => _WebPage();
}

class _WebPage extends State<WebPage> {
  String _title = '网页';
  WebViewController _viewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 通过修改主题来修改返回按钮的颜色(也可以使用leading定义一下返回按钮如IconButton或BackButton)
        leading: BackButton(
          color: Colors.white,
        ),
//        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          _title,
          style: TextStyle(
              color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: WebView(
        initialUrl: 'https://www.baidu.com',
        // 启用javascipt
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _viewController = controller;
        },
        onPageFinished: (url) {
          // 页面加载完成后读取网页标题显示在导航栏上
          _viewController?.evaluateJavascript('document.title')?.then((value) {
            setState(() {
              _title = value;
            });
          });
        },
        // 监听webView代理
        navigationDelegate: (NavigationRequest request) {
          print('\n 是否允许加载url:${request.url}');
          if (request.url.startsWith('someApp://')) {
            // 拦截url
            // to do something .....

            // 阻止加载web链接页面
            return NavigationDecision.prevent;
          }
          // 允许webView导航
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
