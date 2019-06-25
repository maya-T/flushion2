import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/Ecommerce/homePage2.dart';
import 'package:flutterfirebase/Ecommerce/pages/registerPage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading;
  bool isLoggedIn=false;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _passwd;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

//    preferences = await SharedPreferences.getInstance();
//    isLoggedIn = await googleSignIn.isSignedIn();

    await firebaseAuth.currentUser().then(
        (user){
          if(user!=null) {
            setState(() {
              isLoggedIn=true;
            });
          }
        }
    );
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, "/homePage");
    }
    setState(() {
      loading = false;
    });
  }



  handleEmailSignIn() async {


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

    FirebaseUser firebaseUser =
    await firebaseAuth.signInWithCredential(credential);
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("Users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> user = result.documents;

      if (user.length == 0) {
        Firestore.instance
            .collection("Users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "photo": firebaseUser.photoUrl,
          "email": firebaseUser.email
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("name", firebaseUser.displayName);
        await preferences.setString("photo", firebaseUser.photoUrl);
        await preferences.setString("email", firebaseUser.email);
      } else {
        await preferences.setString("id", user[0]["id"]);
        await preferences.setString("name", user[0]["name"]);
        await preferences.setString("photo", user[0]["photo"]);
        await preferences.setString("email", user[0]["email"]);
      }

      Fluttertoast.showToast(msg: "Loging completeg");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage2();
      }));
    } else {
      Fluttertoast.showToast(msg: "Login failed ");
    }

  }




  handleGoogleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    //GoogleSignInAccount googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser firebaseUser =
        await firebaseAuth.signInWithCredential(credential);
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("Users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> user = result.documents;

      if (user.length == 0) {
        Firestore.instance
            .collection("Users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "photo": firebaseUser.photoUrl,
          "email": firebaseUser.email,
          "gender":"",
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("name", firebaseUser.displayName);
        await preferences.setString("photo", firebaseUser.photoUrl);
        await preferences.setString("email", firebaseUser.email);
      } else {
        await preferences.setString("id", user[0]["id"]);
        await preferences.setString("name", user[0]["name"]);
        await preferences.setString("photo", user[0]["photo"]);
        await preferences.setString("email", user[0]["email"]);
      }

      Fluttertoast.showToast(msg: "Loging completeg");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage2();
      }));
    } else {
      Fluttertoast.showToast(msg: "Login failed ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: <Widget>[
          SafeArea(
              child: Image.asset(
            'images/loginBackground.jpg',
            fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              alignment: Alignment.topLeft,)),
          Container(color: Colors.black.withOpacity(0.65)),
          SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child:
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset('images/lg.png', height: 150.0, width: 150.0,alignment: Alignment.bottomCenter,),
                      ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                                    labelText: "Email",
                                    isDense: true,
                                    border: InputBorder.none,
                                    // labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                    icon: Icon(Icons.alternate_email,
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
                                onSaved: (value){
                                  _email=value;
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
                                obscureText: true,
                                cursorColor: Colors.grey[700],
                                decoration: InputDecoration(

                                    labelText: "Password",
                                    isDense: true,
                                    border: InputBorder.none,
                                    //labelStyle: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.bold),
                                    icon: Icon(Icons.lock_outline,)),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter a password";
                                  } else if (value.length < 6) {
                                    return "The password has to be at least 6 characters long";
                                  }
                                },
                                onSaved: (value){
                                  _passwd=value;
                                },
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
                                onPressed: ()async{
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    try{
                                      FirebaseUser user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _passwd);
                                      Navigator.pushNamed(context, "/homePage" );
                                    }

                                    catch(e){
                                      print(e.message);
                                    }
                                  }
                                },
                                child: Text("Login",style: TextStyle(color: Colors.white),),

                            )
                          ),
                        ),
                        Text("Forgot password ?",style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Dont have an account ?",style: TextStyle(color: Colors.white),),
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return Register();
                                  }));
                                },
                                child: Text("Create one",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.8),),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                              color: Colors.red.shade900.withOpacity(0.9),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(50.0),
                              child: MaterialButton(

                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: (){
                                  handleGoogleSignIn();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset("images/google.png",height: 30.0,width: 30.0,color: Colors.grey,),
                                    Text(" oogle",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 17.0),),
                                  ],
                                ),


                              )
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible:loading??true,
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

//        bottomNavigationBar: BottomAppBar(
//            child: FlatButton(
//                textColor: Colors.white,
//                color: Colors.red.shade900,
//                onPressed: () {
//                  handleSignIn();
//                },
//                child: Padding(
//                  padding: const EdgeInsets.all(15.0),
//                  child: Text("Sign in / Sign up with google"),
//                )))

//      Container(
//
//        child: Padding(
//          padding: const EdgeInsets.only(bottom: 8.0,top: 0.0,left: 12.0,right: 12.0),
//          child: FlatButton(
//
//              textColor: Colors.white,
//              color: Colors.red.shade900,
//              onPressed: () {
//                handleSignIn();
//              },
//              child: Padding(
//                padding: const EdgeInsets.all(15.0),
//                child: Text("Sign in / Sign up with google"),
//              )),
//        ),
//      ),
    );
  }
}
