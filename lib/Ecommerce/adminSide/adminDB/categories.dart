import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryService{
  Firestore _firestore=Firestore.instance;
  void createCategory(String name){
      _firestore.collection("Categories").add({'name':name});
  }
  getCategories(){
    return _firestore.collection("Categories").snapshots();
  }
}