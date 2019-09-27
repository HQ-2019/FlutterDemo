import 'dart:async';

import 'package:demo/navigator/TabNavigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Timer timer;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyCodeController = TextEditingController();

  bool verifyButtonEnabled = false;

  @override
  void dispose() {
    phoneController.dispose();
    verifyCodeController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 监听键盘的输入
    phoneController.addListener(() {
      print('手机号码输入 ${phoneController.text}');
      setState(() {
        verifyButtonEnabled = phoneController.text.length == 11 ? true : false;
      });
    });
    // 监听键盘的输入
    verifyCodeController.addListener(() {
      print('验证码输入 ${verifyCodeController.text}');
      if (phoneController.text.length == 11 && verifyCodeController.text.length == 6) {
        requestLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止弹出键盘后页面布局超出屏幕
      body: SafeArea(
        // 使用SafeArea来避免iPhoneX刘海覆盖
          child: Container(
            // 上边距对iPhone刘海做兼容也可以使用top: MediaQuery.of(context).padding.top + 30
            padding: EdgeInsets.only(top: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildTitleView(), // 创建标题视图
                buildInputView(), // 创建输入区域视图
                buildAgreementView(), //创建协议区域视图
              ],
            ),
          )
      ),
    );
  }

  /*
   * 重置跟视图,并清空堆栈中的页面
   * @author huangqun by 2019/9/24.
   */
  void resetRootView() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TabNavigator()),
        (route) => route == null);
  }

  /*
   * 创建标题视图
   * @author huangqun by 2019/9/24.
   */
  Widget buildTitleView() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('您好',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text('欢迎使用\"月光侠分期\"',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        )
    );
  }

  /*
   * 创建输入区域视图
   * @author huangqun by 2019/9/24.
   */
  Widget buildInputView() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 手机号码输入
          buildPhoneInputView(),
          // 验证码输入
          buildVerifyCodeIpnputView()
        ],
      ),
    );
  }

  /*
   * 手机输入视图
   * @author huangqun by 2019/9/26.
   */
  Widget buildPhoneInputView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('手机号码', style: TextStyle(fontSize: 15, color: Colors.black54)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // 使用Expanded包裹输入框，使输入框充满剩余的空间
                Expanded(
                  child: buildTextField(controller: phoneController, isPhone: true), // 手机号码输入框
                ),
                buildButton() // 验证码按钮
              ],
            ),
          )
        ],
      ),
    );
  }

  /*
   * 验证码输入视图
   * @author huangqun by 2019/9/26.
   */
  Widget buildVerifyCodeIpnputView() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('验证码', style: TextStyle(fontSize: 15, color: Colors.black54)),
          Container(
            margin: EdgeInsets.only(right: 140),
            child: buildTextField(controller: verifyCodeController, isPhone: false),
          )
        ],
      ),
    );
  }

  /*
   * 协议区域视图
   * @author huangqun by 2019/9/26.
   */
  Widget buildAgreementView() {
    return Container(
      padding: EdgeInsets.only(top: 10,right: 30),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                child: Checkbox(
                  tristate: true,
                  value: true,
                  activeColor: Colors.orange,
                  onChanged: (bool newValue) {
                  },
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '登录即表示同意并接受月光侠分期',
                    style: TextStyle(color: Colors.black54, fontSize: 14.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: '《注册协议》',
                          style: TextStyle(color: Colors.orange),
                          recognizer: TapGestureRecognizer()..onTap = () async {
                            // 点击事件
                          }
                      ),
                      TextSpan(
                          text: '和'
                      ),
                      TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(color: Colors.orange),
                          recognizer: TapGestureRecognizer()..onTap = () async {
                            // 点击事件
                          }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  /* 文本输入框
   *
   * @author huangqun by 2019/9/26.
   */
  Widget buildTextField({bool isPhone, TextEditingController controller}) {
    return TextField(
      controller: controller, // 监听键盘输入
      autofocus: isPhone, // 设置是否自动获取焦点
      style: TextStyle(color: Colors.orange, fontSize: 18), // 设置字体
      keyboardType: TextInputType.number, // 键盘类型为数字
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(isPhone ? 11 : 6)
      ], // 设置输入限制
      cursorColor: Colors.orange, // 设置光标颜色
      decoration: InputDecoration(
        hintText: '请输入',
        hintStyle: TextStyle(color: Colors.black26, fontSize: 15),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 0.5)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 0.5)),
      ),
      onChanged: (value) {
        print('输入值变化  value: ${value}');
      } ,
    );
  }

  /*
   * 构建一个带圆角的按钮
   * @author huangqun by 2019/9/24.
   */
  Widget buildButton() {
    return Container(
      width: 100.0,
      height: 25.0,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: MaterialButton(
        textColor: Colors.white,
        color: Colors.orange.shade700,
        highlightColor: Colors.orange.shade900,
        disabledColor: Colors.black26,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Text('获取验证码', style: TextStyle(color: Colors.white, fontSize: 12)),
        onPressed: null,
      ),
    );
  }

  /*
   * 验证码按钮点击事件，为null时按钮为不可点击状态
   * @author huangqun by 2019/9/27.
   */
  verifyButtonAction() {
    if (verifyButtonEnabled) {
      return null; // 返回null时，按钮为禁止点击状态
    }
    return () {
      // 执行点击事件
    };
  }

  /*
   * 发送登录请求
   * @author huangqun by 2019/9/26.
   */
  void requestLogin() {
    timer = new Timer(const Duration(milliseconds: 1500), () {
      try {
        // 重置根视图
        resetRootView();
      } catch (e) {
      }
    });
  }
}
