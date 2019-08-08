import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/provider/userProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/Ecommerce/homePage2.dart';
import 'package:flutterfirebase/Ecommerce/pages/registerPage.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading;
  bool isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _passwd;

  final GlobalKey<ScaffoldState> _key=GlobalKey();


//  @override
//  void initState() {
//    super.initState();
//    isSignedIn();
//  }

//  void isSignedIn() async {
//    setState(() {
//      loading = true;
//    });
//
////    preferences = await SharedPreferences.getInstance();
////    isLoggedIn = await googleSignIn.isSignedIn();
//
//    await firebaseAuth.currentUser().then((user) {
//      if (user != null) {
//        setState(() {
//          isLoggedIn = true;
//        });
//      }
//    });
//    if (isLoggedIn) {
//      Navigator.pushReplacementNamed(context, "/homePage");
//    }
//    setState(() {
//      loading = false;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _key,
        extendBody: true,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(70.0),
                      child: Image.asset(
                        'images/cart.png',
                        height: 120.0,
                        width: 150.0,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
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
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Material(
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(50.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: TextFormField(
                                  obscureText: true,
                                  cursorColor: Colors.grey[700],
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      isDense: true,
                                      border: InputBorder.none,
                                      //labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                      icon: Icon(
                                        Icons.lock_outline,
                                      )),
                                  keyboardType: TextInputType.emailAddress,
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline,
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
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      if(! await user.signIn(_email, _passwd)){
                                        _key.currentState.showSnackBar(SnackBar(content: Text("Login failed")));
                                      }
//                                      try {
//                                        AuthResult auth = await FirebaseAuth
//                                            .instance
//                                            .signInWithEmailAndPassword(
//                                                email: _email,
//                                                password: _passwd);
//                                        FirebaseUser user = auth.user;
//                                        Navigator.pushNamed(
//                                            context, "/homePage");
//                                      } catch (e) {
//                                        print(e.message);
//                                      }
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Or sign in with ",
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
                          onPressed: (){
                            handleGoogleSignIn();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Dont have an account ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Register();
                            }));
                          },
                          child: Text(
                            "Create one",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }




  handleGoogleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    AuthResult authResult=await firebaseAuth.signInWithCredential(credential);
    FirebaseUser firebaseUser =authResult.user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("Users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> user = result.documents;

      if (user==null) {
        Firestore.instance
            .collection("Users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "photo": firebaseUser.photoUrl,
          "email": firebaseUser.email,
        });
      }
      Fluttertoast.showToast(msg: "Loging in completed",backgroundColor: Colors.grey);
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage2();
      }));
    } else {
      Fluttertoast.showToast(msg: "Loging in failed ");
    }
  }
}






// old sign in methods

//handleEmailSignIn() async {
//
//
//  preferences = await SharedPreferences.getInstance();
//
//  setState(() {
//    isLoggedIn = true;
//  });
//
//  GoogleSignInAccount googleUser = await googleSignIn.signIn();
//  GoogleSignInAuthentication googleSignInAuthentication =
//  await googleUser.authentication;
//
//  final AuthCredential credential = GoogleAuthProvider.getCredential(
//    accessToken: googleSignInAuthentication.accessToken,
//    idToken: googleSignInAuthentication.idToken,
//  );
//
//  AuthResult authResult=await firebaseAuth.signInWithCredential(credential);
//  FirebaseUser firebaseUser =authResult.user;
//  if (firebaseUser != null) {
//    final QuerySnapshot result = await Firestore.instance
//        .collection("Users")
//        .where("id", isEqualTo: firebaseUser.uid)
//        .getDocuments();
//    final List<DocumentSnapshot> user = result.documents;
//
//    if (user.length == 0) {
//      Firestore.instance
//          .collection("Users")
//          .document(firebaseUser.uid)
//          .setData({
//        "id": firebaseUser.uid,
//        "name": firebaseUser.displayName,
//        "photo": firebaseUser.photoUrl,
//        "email": firebaseUser.email
//      });
//      await preferences.setString("id", firebaseUser.uid);
//      await preferences.setString("name", firebaseUser.displayName);
//      await preferences.setString("photo", firebaseUser.photoUrl);
//      await preferences.setString("email", firebaseUser.email);
//    } else {
//      await preferences.setString("id", user[0]["id"]);
//      await preferences.setString("name", user[0]["name"]);
//      await preferences.setString("photo", user[0]["photo"]);
//      await preferences.setString("email", user[0]["email"]);
//    }
//
//    Fluttertoast.showToast(msg: "Loging completeg");
//    setState(() {
//      loading = false;
//    });
//    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//      return HomePage2();
//    }));
//  } else {
//    Fluttertoast.showToast(msg: "Login failed ");
//  }
//
//}
//
//
//
//

