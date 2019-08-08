import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfirebase/Ecommerce/db/userServices.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum Status {
UNINITIALIZED,AUTHENTICATED,AUTHENTICATING,UNAUTHENTICATED
}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status=Status.UNINITIALIZED;
  Status get status => _status;
  FirebaseUser get user => _user;


  UserProvider.initialize():_auth=FirebaseAuth.instance
  {
  _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email,String password) async{
    try{
      _status=Status.AUTHENTICATING;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      print(e.toString());
      _status=Status.UNAUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email,String password,String name) async{
    try{
      UserServices userServices=UserServices();
      _status=Status.AUTHENTICATING;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((res){
        userServices.createUser(name, email, "", res.user.uid);
      });

      return true;
    }catch(e){
      print(e.toString());
      _status=Status.UNAUTHENTICATED;
      notifyListeners();
      return false;
    }

  }

  Future signOut() async{
    _auth.signOut();
    _status=Status.UNAUTHENTICATED;
    notifyListeners();
    return Future.delayed(Duration.zero);

  }

  Future _onStateChanged(FirebaseUser user) async{
    if(user==null){
      _status=Status.UNAUTHENTICATED;
    }else{
      _user=user;
      _status=Status.AUTHENTICATED;
    }
    notifyListeners();

  }
}