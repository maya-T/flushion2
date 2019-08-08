import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/db/auth.dart';
import 'package:flutterfirebase/Ecommerce/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/Ecommerce/db/userServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'loginPage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserServices userServices = UserServices();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _passwd;
  String _confirmPasswd;
  //String gender = "male";
  bool hidePasswd = true, hideConfirmPasswd = true;
  Icon hidePasswdIcon = Icon(Icons.visibility),
      hideConfirmPasswdIcon = Icon(Icons.visibility);
  TextEditingController _passwdController = TextEditingController();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _key,
        //resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/cart.png',
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Already have an account ? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>Login()));
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 8.0, top: 12.0),
                          child: Material(
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: TextFormField(
                                cursorColor: Colors.grey[700],
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    isDense: true,
                                    border: InputBorder.none,
                                    // labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                    icon: Icon(
                                      Icons.person_outline,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                },
                                onSaved: (value) {
                                  _name = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 8.0),
                          child: Material(
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: TextFormField(
                                cursorColor: Colors.grey[700],
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    isDense: true,
                                    border: InputBorder.none,
                                    // labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                    icon: Icon(
                                      Icons.alternate_email,
                                    )),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regExp = RegExp(pattern);
                                    if (!regExp.hasMatch(value)) {
                                      return "Please make sure your email adress is valid";
                                    }
                                  } else {
                                    return "Please enter your email adress";
                                  }
                                },
                                onSaved: (value) {
                                  _email = value;
                                },
                              ),
                            ),
                          ),
                        ),
//        chose gender
//                          Padding(
//                            padding: const EdgeInsets.only(
//                                right: 12.0, left: 12.0, bottom: 8.0),
//                            child: Material(
//                              color: Colors.grey.withOpacity(0.2),
//                              elevation: 0.0,
//                              borderRadius: BorderRadius.circular(50.0),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  Expanded(
//                                    child: RadioListTile(
//                                      title: Text(
//                                        "Male",
//                                        style: TextStyle(
//                                          color: Theme.of(context).hintColor,
//                                        ),
//                                      ),
//                                      groupValue: gender,
//                                      value: "male",
//                                      onChanged: (value) {
//                                        setState(() {
//                                          gender = value;
//                                        });
//                                      },
//                                    ),
//                                  ),
//                                  Expanded(
//                                    child: RadioListTile(
//                                      title: Text(
//                                        "Female",
//                                        style: TextStyle(
//                                          color: Theme.of(context).hintColor,
//                                        ),
//                                      ),
//                                      groupValue: gender,
//                                      value: "female",
//                                      onChanged: (value) {
//                                        setState(() {
//                                          gender = value;
//                                        });
//                                      },
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),

                        Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 8.0),
                          child: Material(
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwdController,
                                      obscureText: hidePasswd,
                                      cursorColor: Colors.grey[700],
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          isDense: true,
                                          border: InputBorder.none,
                                          //labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                          icon: Icon(
                                            Icons.lock_outline,
                                          )),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter a password";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        }
                                      },
                                      onSaved: (value) {
                                        _passwd = value;
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: hidePasswdIcon,
                                    onPressed: () {
                                      setState(() {
                                        hidePasswd = !hidePasswd;
                                        if (hidePasswd) {
                                          hidePasswdIcon =
                                              Icon(Icons.visibility);
                                        } else {
                                          hidePasswdIcon =
                                              Icon(Icons.visibility_off);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, left: 12.0, bottom: 8.0),
                          child: Material(
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(50.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      obscureText: hideConfirmPasswd,
                                      cursorColor: Colors.grey[700],
                                      decoration: InputDecoration(
                                          labelText: "Confirm Password",
                                          isDense: true,
                                          border: InputBorder.none,
                                          //labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                          icon: Icon(
                                            Icons.lock_outline,
                                          )),
                                      validator: (value) {
                                        if (_passwdController.text != value) {
                                          return "The passwords do not match";
                                        }
                                      },
                                      onSaved: (value) {
                                        _confirmPasswd = value;
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: hideConfirmPasswdIcon,
                                    onPressed: () {
                                      setState(() {
                                        hideConfirmPasswd = !hideConfirmPasswd;
                                        if (hideConfirmPasswd) {
                                          hideConfirmPasswdIcon =
                                              Icon(Icons.visibility);
                                        } else {
                                          hideConfirmPasswdIcon =
                                              Icon(Icons.visibility_off);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                              color: Colors.deepOrange,
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(50.0),
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  FormState _formstate = _formKey.currentState;
                                  if (_formstate.validate()) {
                                    _formstate.save();
                                    if (! await user.signUp(
                                        _email, _passwd, _name)) {
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Sign up failed")));
                                    }
                                  }
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Or sign up with ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Material(
                              child: MaterialButton(
                                onPressed: () async {
                                  FirebaseUser user = await auth.googleSignIn();
                                  if (user == null) {
                                    userServices.createUser(user.displayName,
                                        user.email, user.photoUrl, user.uid);

                                    Navigator.pushReplacementNamed(
                                        context, "/homePage");
                                  }
                                },
                                child: Image.asset(
                                  "images/colored_google.png",
                                  width: 60.0,
                                ),
                              ),
                            ),
                            Material(
                              child: MaterialButton(
                                child: Image.asset(
                                  "images/fb.png",
                                  width: 60.0,
                                ),
                              ),
                            )
                          ],
                        ),

//   old google sign up button
//                            Padding(
//                              padding: const EdgeInsets.all(12.0),
//                              child: Material(
//                                  color: Colors.red.shade900.withOpacity(0.9),
//                                  elevation: 0.0,
//                                  borderRadius: BorderRadius.circular(50.0),
//                                  child: MaterialButton(
//                                    minWidth: MediaQuery.of(context).size.width,
//                                    onPressed: () {
//                                      //handleGoogleSignIn();
//                                    },
//                                    child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        Image.asset(
//                                          "images/google.png",
//                                          height: 30.0,
//                                          width: 30.0,
//                                          color: Colors.grey,
//                                        ),
//                                        Text(
//                                          " oogle",
//                                          style: TextStyle(
//                                              color: Colors.grey,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 17.0),
//                                        ),
//                                      ],
//                                    ),
//                                  )),
//                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible:user.status==Status.AUTHENTICATING,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//  void validateForm() async {
//    FormState _formstate = _formKey.currentState;
//    if (_formstate.validate()) {
//      _formstate.save();
//      FirebaseUser user = await firebaseAuth.currentUser();
//      if (user == null) {
//        await firebaseAuth
//            .createUserWithEmailAndPassword(email: _email, password: _passwd)
//            .then((user) =>
//                userServices.createUser(_name, _email, "", user.user.uid));
//
//        Navigator.pushReplacementNamed(context, "/homePage");
//        Fluttertoast.showToast(msg: "You have successfully signed up");
//      }
//    }
//  }
}
