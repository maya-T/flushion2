import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/categories.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/brands.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var _formKey = GlobalKey<FormState>();
  String _productName;
  String selectedCategory;
  String selectedBrand;
  int _productQuantity;
  CategoryService categoryService = CategoryService();
  BrandService brandService = BrandService();
  List<String> availableSizes = [];
  bool XS = false, S = false, M = false, L = false, XL = false, XXL = false;
  List<String> colors = [
    "white",
    "black",
  ];
  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Color(0x8a000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add a product",
          style: TextStyle(
            color: Color(0x8a000000),
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                ),

                //////////////////////////////////////////////////////////////////

                Expanded(
                  child: Card(
                    elevation: 3,
                    child: MaterialButton(
                      height: 250.0,
                      color: Colors.transparent,
                      elevation: 0.0,
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.gallery);
                      },
                      child: Platform.isAndroid
                          ? FutureBuilder(
                        future: retrieveLostData(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Icon(Icons.add) ;
                            case ConnectionState.waiting:
                              return Icon(Icons.add) ;
                            case ConnectionState.done:
                              return
                                _previewImage();
                            default:
                              if (snapshot.hasError) {
                                return Text(
                                  'Pick image/video error: ${snapshot.error}}',
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                const Icon(Icons.add) ;
                              }
                          }
                        },
                      )
                          : _previewImage(),
                    ),
                  ),
                ),


                ///////////////////////////////////////////////////////////////////


                SizedBox(
                  width: 100.0,
                ),
              ],
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Product name ",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _productName = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field cannot be empty";
                    }
                  },
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 10.0),
                  child: getCategoriesDropDown()),
            ),
            Card(
              elevation: 3,
              child: Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 10.0),
                  child: getBrandsDropDown()),
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    BlacklistingTextInputFormatter(RegExp("[\\.|\\,]"))
                  ],
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _productQuantity = int.tryParse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field cannot be empty";
                    }
                  },
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        child: Text(
                          "Available Sizes",
                          textAlign: TextAlign.start,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Checkbox(
                            value: XS,
                            onChanged: (value) {
                              setState(() {
                                XS = value;
                              });
                              setAvailableSizes("XS", value);
                            },
                          ),
                        ),
                        Text(
                          "XS",
                          style: TextStyle(color: Color(0x8a000000)),
                        ),
                        Expanded(
                          child: Checkbox(
                            value: S,
                            onChanged: (value) {
                              setState(() {
                                S = value;
                              });
                              setAvailableSizes("S", value);
                            },
                          ),
                        ),
                        Text("S", style: TextStyle(color: Color(0x8a000000))),
                        Expanded(
                          child: Checkbox(
                            value: M,
                            onChanged: (value) {
                              setState(() {
                                M = value;
                              });
                              setAvailableSizes("M", value);
                            },
                          ),
                        ),
                        Text("M", style: TextStyle(color: Color(0x8a000000))),
                        Expanded(
                          child: Checkbox(
                            value: L,
                            onChanged: (value) {
                              setState(() {
                                L = value;
                              });
                              setAvailableSizes("L", value);
                            },
                          ),
                        ),
                        Text("L", style: TextStyle(color: Color(0x8a000000))),
                        Expanded(
                          child: Checkbox(
                            value: XL,
                            onChanged: (value) {
                              setState(() {
                                XL = value;
                              });
                              setAvailableSizes("XL", value);
                            },
                          ),
                        ),
                        Text("XL", style: TextStyle(color: Color(0x8a000000))),
                        Expanded(
                          child: Checkbox(
                            value: XXL,
                            onChanged: (value) {
                              setState(() {
                                XXL = value;
                              });
                              setAvailableSizes("XXL", value);
                            },
                          ),
                        ),
                        Text("XXL", style: TextStyle(color: Color(0x8a000000))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Card(
          elevation: 0,
          color: Colors.blue,
          child: FlatButton(
              textColor: Colors.white,
              onPressed: () {},
              child: Text("Add product")),
        ),
      ),
    );
  }



  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  void _onImageButtonPressed(ImageSource source) async {

    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return AddProduct();
      }));
    } catch (e) {
      _pickImageError = e;
    }
    setState(() {});
  }


  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(_imageFile,fit: BoxFit.cover,);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Icon(Icons.add);
    }
  }

  /////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////

  Future retrieveLostData() async {
    print("retrieve lost data");
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
        } else {
          _imageFile = response.file;
        }
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void setAvailableSizes(String size, bool checked) {
    if (checked) {
      availableSizes.add(size);
    } else {
      availableSizes.remove(size);
    }
    print(availableSizes);
  }



  getBrandsDropDown() {
    return StreamBuilder<QuerySnapshot>(
        stream: brandService.getBrands(),
        // Firestore.instance.collection('Brands').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
              default:
                return Theme(
                  data: ThemeData(canvasColor: Colors.grey[800]),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          elevation: 4,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(
                              left: 0.0,
                            ),
                            child: Text(
                              "Product brand",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          value: selectedBrand,
                          items: snapshot.data.documents.map((elmt) {
                            return DropdownMenuItem(
                                value: elmt['name'],
                                child: Container(
                                    child: Text(
                                      elmt['name'],
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedBrand = val;
                              //print(val);
                            });
                          }),
                    ),
                  ),
                );

            }
          }
        }

//
    );
  }






  getCategoriesDropDown() {
    return StreamBuilder<QuerySnapshot>(
        stream: categoryService.getCategories(),
        //Firestore.instance.collection('Categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
              default:
                return Theme(
                  data: ThemeData(canvasColor: Colors.grey[800]),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          elevation: 4,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          hint: Padding(
                            padding: const EdgeInsets.only(
                              left: 0.0,
                            ),
                            child: Text(
                              "Product category",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          value: selectedCategory,
                          items: snapshot.data.documents.map((elmt) {
                            return DropdownMenuItem(
                                value: elmt['name'],
                                child: Text(
                                  elmt['name'],
                                  style: TextStyle(color: Colors.white),
                                ));
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedCategory = val;
                              //print(val);
                            });
                          }),
                    ),
                  ),
                );
            }
          }
        });
  }
}
