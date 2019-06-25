import 'package:cloud_firestore/cloud_firestore.dart';
class UserServices{
 Firestore _db=Firestore.instance;

  createUser(String name,String email,String photo, String id,String gender) async {
     await _db.collection('Users').document(id).setData(
        {'name': '$name','email': '$email','photo':'$photo','id': '$id','gender':'$gender'}
        );
  }

}