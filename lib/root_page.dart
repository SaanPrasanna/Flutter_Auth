import 'package:flutter/material.dart';
import 'auth.dart';
import 'loginpage.dart';
import 'homepage.dart';

class RootPage extends StatefulWidget {

  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  // void initState() {
  //   super.initState();
  //   widget.auth.currentUser().then((userId){
  //     setState(() {
  //       authStatus = userId == null? AuthStatus.notSignedIn : AuthStatus.signedIn;
  //     });
  //   });
  // }

  void _signIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn : 
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signIn,
          );

      case AuthStatus.signedIn : 
        return HomePage(
          auth: widget.auth,
          onSignedout: _signedOut,
        );
    }
    
  }
}