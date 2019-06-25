//import 'package:flutter/material.dart';
//import 'package:flutterfirebase/hello/signIn.dart';
//import 'package:flutterfirebase/hello/signUpPage.dart';
//
//class WelcomePage extends StatefulWidget {
//  @override
//  _WelcomePageState createState() => _WelcomePageState();
//}
//
//class _WelcomePageState extends State<WelcomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Welcome"),
//      ),
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          RaisedButton(
//            onPressed: toSignIn,
//            padding: EdgeInsets.all(20.0),
//            child: Text("Sign in"),
//          ),
//          SizedBox(
//            height: 10.0,
//          ),
//          RaisedButton(
//            onPressed: toSignUp,
//            padding: EdgeInsets.all(20.0),
//            child: Text("Sign up"),
//          ),
//        ],
//      ),
//    );
//  }
//  void toSignIn(){
//    Navigator.push(context, MaterialPageRoute(builder: (context){
//      return SignInPage();
//    }));
//  }
// void toSignUp(){
//    Navigator.push(context, MaterialPageRoute(builder: (context){
//      return SignUpPage();
//    }));
//  }
//
//}
