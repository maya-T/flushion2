//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutterfirebase/hello/homePage.dart';
//
//class SignUpPage extends StatefulWidget {
//  @override
//  _SignUpPageState createState() => _SignUpPageState();
//}
//
//class _SignUpPageState extends State<SignUpPage> {
//  final GlobalKey<FormState> _formKey1 =GlobalKey<FormState>();
//  String _email;
//  String _passwd;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Sign up"),),
//      body: Form(
//        key: _formKey1,
//          child:Column(
//            crossAxisAlignment: CrossAxisAlignment.end,
//            children: <Widget>[
//              SizedBox(
//                height: 12.0,
//              ),
//              TextFormField(
//                decoration: InputDecoration(
//                  labelText: 'E-mail',
//                  fillColor: Colors.grey[200],
//                  filled: true,
//                  border: InputBorder.none,
//                ),
//                keyboardType: TextInputType.emailAddress,
//                validator: (value){
//                  if(value.isEmpty){
//                    return'Please Enter your e-mail';
//                  }
//                },
//                onSaved: (value){
//                  _email=value;
//                },
//              ),
//              SizedBox(
//               height: 12.0,
//              ),
//              TextFormField(
//                obscureText: true,
//                decoration: InputDecoration(
//
//                    labelText: 'Password',
//                    border: InputBorder.none,
//                    fillColor: Colors.grey[200],
//                    filled: true
//                ),
//                validator: (value){
//                  print('hello');
//                  if(value.length<6){
//                    return'The password is at least 6 letters long';
//                  }
//                },
//                onSaved: (value){
//                  _passwd=value;
//                },
//              ),
//              RaisedButton(
//                textColor: Colors.white,
//                color: Colors.blue,
//                padding: const EdgeInsets.all(12.0),
//                child: Text("Sign up"),
//                onPressed: ()async{
//                  if(_formKey1.currentState.validate()){
//                    _formKey1.currentState.save();
//                    try{
//                      FirebaseUser user=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _passwd);
//                      user.sendEmailVerification();
//                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//                        return HomePage(user:user ,);
//                      }));
//                      print(_email+_passwd);
//                    }catch(e){
//                      print(e.message);
//                    }
//                  }
//                },
//              )
//
//
//            ],
//          )
//      ),
//    );
//  }
//}
