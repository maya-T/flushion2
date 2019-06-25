import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/categories.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/products.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/brands.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseStorage storage = FirebaseStorage.instance;
  var _formKey = GlobalKey<FormState>();
  String _productName;
  String selectedCategory;
  String selectedBrand;
  int _productQuantity;
  double _productPrice;
  CategoryService categoryService = CategoryService();
  BrandService brandService = BrandService();
  ProductService productService = ProductService();

  List<String> availableSizes = [];
  bool XS = false, S = false, M = false, L = false, XL = false, XXL = false;
  List<String> availableColors = [];
  File _image;
  var colors = [
    {'name': 'white', 'color': Colors.white},
    {'name': 'black', 'color': Colors.black},
    {'name': 'red', 'color': Colors.red},
    {'name': 'green', 'color': Colors.green},
    {'name': 'blue', 'color': Colors.blueAccent},
    {'name': 'brown', 'color': Colors.brown},
    {'name': 'yellow', 'color': Colors.yellow},
  ];
  var checks = [];

  bool _isLoading = false;
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _isLoading
            ? null
            : IconButton(
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
      body: _isLoading
          ? Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 50.0,
                      percent: _progress,
                    ),
                    Text("Please wait while creating new product...")
                  ],
                ),
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Card(
                                elevation: 3,
                                child: Container(
                                  height: 300,
                                  width: 250,
                                  child: _image == null
                                      ? Icon(
                                          Icons.image,
                                          color: Colors.grey[200],
                                          size: 80.0,
                                        )
                                      : Image.file(
                                          _image,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                child: MaterialButton(
                                  elevation: 0.0,
                                  onPressed: getImage,
                                  height: 40.0,
                                  color: Colors.white,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Color(0x8a000000),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Price",
                            border: InputBorder.none,
                          ),
                          onSaved: (value) {
                            _productPrice = double.tryParse(value);
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
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 12.0),
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
                                Text("S",
                                    style: TextStyle(color: Color(0x8a000000))),
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
                                Text("M",
                                    style: TextStyle(color: Color(0x8a000000))),
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
                                Text("L",
                                    style: TextStyle(color: Color(0x8a000000))),
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
                                Text("XL",
                                    style: TextStyle(color: Color(0x8a000000))),
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
                                Text("XXL",
                                    style: TextStyle(color: Color(0x8a000000))),
                              ],
                            ),
                          ),
                        ],
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
                              "Available colors",
                              textAlign: TextAlign.start,
                            )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                  ),
                                  itemCount: colors.length + 1,
                                  itemBuilder: (context, i) {
                                    if (i < colors.length) {
                                      checks.add(false);
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                checks[i] = !checks[i];
                                              });
                                              if (!checks[i]) {
                                                availableColors
                                                    .remove(colors[i]['name']);
                                              } else {
                                                availableColors
                                                    .add(colors[i]['name']);
                                              }
                                              print(availableColors);
                                            },
                                            shape: new CircleBorder(),
                                            color: colors[i]['color'],
                                            child: Visibility(
                                                visible: checks[i],
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.grey[500],
                                                  size: 20.0,
                                                ))),
                                      );
                                    } else {
                                      // TODO: OPTION : ADD A NEW COLOR//
//                                  return Padding(
//                                  padding: const EdgeInsets.all(5.0),
//                                  child: RaisedButton(
//
//                                    onPressed: () {
//                                      GlobalKey<FormState> key =GlobalKey<FormState>();
//                                      showDialog(context: context,
//                                        builder: (_){
//                                           return AlertDialog(
//                                             content: Form(
//                                               key: key,
//                                               child: Column(
//                                                 children: <Widget>[
//
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                        }
//                                      );
//                                    },
//                                    shape: new CircleBorder(),
//                                    color: Colors.grey[200],
//                                    child: Center(
//                                        child: Icon(
//                                      Icons.add,
//                                      color: Color(0x8a000000),
//                                      size: 20.0,
//                                    )),
//                                  ),
//                                );
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: _isLoading
          ? null
          : BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: Card(
                elevation: 0,
                color: Colors.blue,
                child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      _validateNupload();
                    },
                    child: Text("Add product")),
              ),
            ),
    );
  }

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
            return Container(
              height: 45.0,
            );
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
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
                        value: null,
                        items: [
                          DropdownMenuItem(
                            value: "Downloading...",
                            child: Text("Downloading..."),
                          )
                        ],
                        onChanged: (val) {}),
                  ),
                );
              default:
                return Theme(
                  data: ThemeData(canvasColor: Colors.grey[200]),
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
                                  style: TextStyle(color: Color(0x8a000000)),
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
            return Container(
              height: 45.0,
            );
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return ButtonTheme(
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
                        value: null,
                        items: [
                          DropdownMenuItem(
                            value: "Downloading...",
                            child: Text("Downloading..."),
                          )
                        ],
                        onChanged: (val) {}),
                  ),
                );
              default:
                return Theme(
                  data: ThemeData(canvasColor: Colors.grey[200]),
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
                                  style: TextStyle(color: Color(0x8a000000)),
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _validateNupload() async {
    String _imgURL;

    if (_formKey.currentState.validate()) {
      if (_image != null) {
        if (availableSizes.isNotEmpty) {
          _formKey.currentState.save();
          final String picture =
              "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageReference reference = storage.ref().child(picture);
          StorageUploadTask task = reference.putFile(_image);
          task.events.listen((event) {
            setState(() {
              _isLoading = true;
              _progress = event.snapshot.bytesTransferred.toDouble() /
                  event.snapshot.totalByteCount.toDouble();
            });
          }).onError((error) {
            _scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text(error.toString()),
              backgroundColor: Colors.red,
            ));
          });
          task.onComplete.then((snapshot) {
            setState(() {
              _isLoading = false;
            });
            snapshot.ref.getDownloadURL().then((url) {
              _imgURL = url;
            });
          });
          productService.createProduct(
              name: _productName,
              price: _productPrice,
              brand: selectedBrand,
              category: selectedCategory,
              colors: availableColors,
              image: _imgURL,
              quantity: _productQuantity,
              sizes: availableSizes);
          setState(() {
            _image=null;
            selectedCategory=null;
            selectedBrand=null;
            availableColors=null;
            availableSizes=null;
            XS = false; S = false; M = false; L = false; XL = false; XXL = false;
            checks.setAll(0, List.generate(checks.length,(i)=>false));
          });
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: Text(" Product added "),
          ));

        } else {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text("No selected available sizes"),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text("Product image is missing"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }
  }
}
