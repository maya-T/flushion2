import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/Ecommerce/db/userServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserServices userServices = UserServices();
  SharedPreferences preferences;
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _passwd;
  String _confirmPasswd;
  String gender = "male";
  bool hidePasswd = true, hideConfirmPasswd = true;
  Icon hidePasswdIcon = Icon(Icons.visibility),
      hideConfirmPasswdIcon = Icon(Icons.visibility);
  TextEditingController _passwdController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: <Widget>[
          SafeArea(
              child: Image.asset(
            'images/loginBackground.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
             width: double.infinity,
                alignment: Alignment.topLeft,
          )),
          Container(color: Colors.black.withOpacity(0.65)),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  child:
                      Image.asset('images/lg.png', height: 150.0, width: 150.0,),
                ),
                Form(
                    key: _formKey,
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white.withOpacity(0.7),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, right: 15.0),
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
                              padding: const EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white.withOpacity(0.7),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, right: 15.0),
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

                        Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white.withOpacity(0.7),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text(
                                          "Male",
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        groupValue: gender,
                                        value: "male",
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text(
                                          "Female",
                                          style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        groupValue: gender,
                                        value: "female",
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white.withOpacity(0.7),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                              hidePasswdIcon = Icon(Icons.visibility);
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
                              padding: const EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white.withOpacity(0.7),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, right: 15.0),
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
                                            if (_passwdController.text!=value) {
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
                                color: Colors.blue.withOpacity(0.8),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    validateForm();
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Material(
                                color: Colors.red.shade900.withOpacity(0.9),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(50.0),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    //handleGoogleSignIn();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/google.png",
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        " oogle",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                  ),

              ],
            ),
          ),
          Visibility(
            visible: false, //loading??true,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.9),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }

  void validateForm() async {
    FormState _formstate = _formKey.currentState;
    if (_formstate.validate()) {
      _formstate.save();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        await firebaseAuth
            .createUserWithEmailAndPassword(email: _email, password: _passwd)
            .then((user) =>
                userServices.createUser(_name, _email, "", user.uid, gender));

        Navigator.pushReplacementNamed(context, "/homePage");
        Fluttertoast.showToast(msg: "You have successfully signed up");
      }
    }
  }
}
