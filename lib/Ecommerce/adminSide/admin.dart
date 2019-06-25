import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/categories.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/adminDB/brands.dart';
import 'package:flutterfirebase/Ecommerce/adminSide/addProduct.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  TabController tabController;
  String _category, _brand;
  BrandService brandService = BrandService();
  CategoryService categoryService = CategoryService();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          title: Text("Admin side app",style: TextStyle(color:Color(0x8a000000),fontSize: 18.0,),),
          elevation: 0.9,
          backgroundColor: Colors.grey[100],
          bottom: TabBar(

            labelPadding: EdgeInsets.only(top: 15.0,bottom: 15.0),
            controller: tabController,
            tabs: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.dashboard,
                    ),
                  ),
                  Expanded(child: Text("Dashboard")),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.sort,
                    ),
                  ),
                  Expanded(child: Text("Manage")),
                ],
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Color(0x8a000000),
            labelColor: Colors.blue,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: ListTile(
                    subtitle: Text("12 000 \$",
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                        textAlign: TextAlign.center),
                    title: Text(
                      'Revenue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0, color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.people_outline),
                                  label: Text("Users")),
                              subtitle: Text(
                                '7',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.category),
                                  label: Text("Categories")),
                              subtitle: Text(
                                '23',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.track_changes),
                                  label: Text("Products")),
                              subtitle: Text(
                                '120',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.tag_faces),
                                  label: Text("Sold")),
                              subtitle: Text(
                                '13',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.shopping_cart),
                                  label: Text("Orders")),
                              subtitle: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                              title: FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.close),
                                  label: Text("Returns")),
                              subtitle: Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 60.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Add product"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return AddProduct();
                      }));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.change_history),
                    title: Text("Products list"),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.add_circle),
                    title: Text("Add category"),
                    onTap: () {
                      _categoryAlert();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text("Category list"),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.add_circle_outline),
                    title: Text("Add brand"),
                    onTap: () {
                      _brandAlert();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text("Brand list"),
                    onTap: () {},
                  ),
                  Divider(),

                ],
              ),
            )
          ],
        ),
      )
    ;
  }

  void _categoryAlert() {
    var _formKey = GlobalKey<FormState>();
    var alert = AlertDialog(
      content: Form(
          key: _formKey,
          child: TextFormField(
            onSaved: (value) {
              _category = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "This field cannot be empty";
              }
            },
            decoration: InputDecoration(
              labelText: "Category name",
              //border: InputBorder.none
            ),
          )),
      actions: <Widget>[
        FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text("CANCEL")),
        FlatButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                categoryService.createCategory(_category);
                Fluttertoast.showToast(msg: "Category added");
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.add),
            label: Text("ADD")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var _formKey = GlobalKey<FormState>();
    var alert = AlertDialog(
      content: Form(
          key: _formKey,
          child: TextFormField(
            onSaved: (value) {
              _brand = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "This field cannot be empty";
              }
            },
            decoration: InputDecoration(
              labelText: "Brand name",
              //border: InputBorder.none
            ),
          )),
      actions: <Widget>[
        FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text("CANCEL")),
        FlatButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                brandService.createBrand(_brand);
                Fluttertoast.showToast(msg: "Brand added");
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.add),
            label: Text("ADD")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
