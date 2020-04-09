import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {

  LoginPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;
  final _formkey = GlobalKey<FormState>();
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = _formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if(validateAndSave()){
      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.signInWithEmailAndPasswod(_email, _password);
          print('User ID: $userId');
        }else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('User ID: $userId'); 
        }
        widget.onSignedIn();
      }catch(e){
        print('Error : $e');
      }
    }
  }

  void moveToRegister(){
    _formkey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    _formkey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Login Application'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:  builInput() + buildButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> builInput() {
    return [
      TextFormField(
        decoration: InputDecoration(hintText: 'E-mail'),
        validator: (value) => value.isEmpty ? 'E-mail can\'t be empty !' : null,
        onSaved: (value) => _email = value.toString().trim(),
      ),
      SizedBox(height: 20.0,),
      TextFormField(
        decoration: InputDecoration(hintText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty !' : null,
        onSaved: (value) => _password = value.toString().trim(),
        obscureText: true,
      ),
      SizedBox(height: 20.0,),
    ];
  }

  List<Widget> buildButtons() {
    if(_formType == FormType.login){
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text('Login'),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        FlatButton(
          onPressed: moveToRegister,
          child: new Text('Create an Account'),
          color: Colors.green,
          textColor: Colors.white,
        )
      ];
    }else{
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text('Create an Account'),
          color: Colors.green,
          textColor: Colors.white,
        ),
        FlatButton(
          onPressed: moveToLogin,
          child: new Text('Login'),
          color: Colors.blue,
          textColor: Colors.white,
        )
      ];      
    }
  }
}