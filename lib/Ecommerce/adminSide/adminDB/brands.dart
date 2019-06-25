import 'package:cloud_firestore/cloud_firestore.dart';

class BrandService {
  Firestore _firestore = Firestore.instance;

  void createBrand(String name) {
    _firestore.collection("Brands").add({'name': name});
  }

  getBrands()  {

    return _firestore.collection("Brands").snapshots();

  }
}
