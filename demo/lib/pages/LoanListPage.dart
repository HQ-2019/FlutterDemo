import 'package:flutter/material.dart';

class LoanListPage extends StatefulWidget {

  @override
  _LoanListPageState createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '借款',
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0, // 去掉阴影
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.label_important),
              title: Text('label_important'),
              subtitle: Text('label_important'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            new ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('gamepad'),
              subtitle: Text('gamepad'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            new ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('verified_user'),
              subtitle: Text('verified_user'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            new ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('dashboard'),
              subtitle: Text('dashboard'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            new ListTile(
              leading: Icon(Icons.security),
              title: Text('security'),
              subtitle: Text('security'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        )
      ),
    );
  }

}