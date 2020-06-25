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
          '网页',
          style: TextStyle(
              color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: WebView(
        initialUrl: 'https://www.baidu.com',
        // 启用javascipt
        javascriptMode: JavascriptMode.unrestricted,
        // 监听webView代理
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.xxxx.com')) {
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
