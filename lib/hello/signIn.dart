import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/hello/homePage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email,_passwd;
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign in"),),
      body: Form(
          key: _formKey ,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                        fillColor: Colors.grey[200],
                        filled: true,
                      border: InputBorder.none,
                    ),
                    validator: (value){
                       if(value.isEmpty){
                         return 'Please enter your e-mail';
                       }
                    },
                    onSaved: (value){
                      _email=value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(

                      labelText: 'Password',
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true
                    ),
                    validator: (value){
                       if(value.isEmpty){
                         return 'Please enter your password';
                       }
                    },
                    onSaved: (value){
                      _passwd=value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),

                  child: RaisedButton(

                    textColor: Colors.white,
                    child: Text("Sign in"),
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                       try{
                           FirebaseUser user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _passwd);
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                             return HomePage(user: user,);
                           }) );
                       }

                       catch(e){
                         print(e.message);
                       }
                      }
                    },
                    elevation: 10.0,
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
