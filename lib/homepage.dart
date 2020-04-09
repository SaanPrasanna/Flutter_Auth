import 'package:flutter/material.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {

  HomePage({this.auth,this.onSignedout});
  final BaseAuth auth;
  final VoidCallback onSignedout;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void _signOut() async {
    try{
      await widget.auth.signOut();
      widget.onSignedout();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Home Page'),
        leading: Icon(Icons.home),
        elevation: 2.0,
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
            onPressed: _signOut,
            child: new Text('Logout')
            ),
        ],
      ),
      body: Center(
        child: new Text(
          'Welcome to Home page',
          style: TextStyle(fontSize: 20.0),
          ),
      ),
    );
  }
}