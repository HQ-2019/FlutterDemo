import 'package:flutter/material.dart';

class LoanListPage extends StatefulWidget {
  @override
  _LoanListPageState createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '借款',
          style: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
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
      )),
    );
  }
}
