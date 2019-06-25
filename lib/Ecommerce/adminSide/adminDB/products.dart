import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;

  void createProduct({String name,String category,String brand,double price,
    int quantity,String image,List<String> sizes,List<String> colors}) {
    print("helloo");
    _firestore.collection("Products").add({
      'name': name,
      'category':category,
      'brand':brand,
      'price':price,
      'quantity':quantity,
      'image':image,
      'sizes':sizes,
      'colors':colors
    });
  }

  getProducts()  {

    return _firestore.collection("Products").snapshots();

  }
}
