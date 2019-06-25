import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String name, id,todo;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore CRUD"),
      ),
      body:   Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter some text";
                    }
                  },
                  onSaved: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter some text";
                    }
                  },
                  onSaved: (value) {
                    todo = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'todo',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                )
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    DocumentReference ref = await db.collection('CRUD').add(
                        {'name': '$name','todo': '$todo'});
                    setState(() => id = ref.documentID);
                    print(ref.documentID);
                  }
                },
                child: Text("Create"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Read'),
              ),
            ],
          ),
          Expanded(

            child: StreamBuilder<QuerySnapshot>(
                stream: db.collection("CRUD").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                      //reverse: true,
                      children: snapshot.data.documents.map((item) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${item['name']}',
                            style: TextStyle(fontSize: 24),
                           ),
                          Text(
                            'todo : ${item['todo']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 12),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(width: 8),
                                FlatButton(
                                  onPressed: () {
                                    Firestore.instance.runTransaction((transaction) async{
                                      await transaction.delete(item.reference);
                                    });
                                  },
                                  child: Text('Delete'),
                                  color: Colors.grey[200],
                                )
                              ])
                        ],
                      ),
                    );
                  }).toList());
                }),
          )
        ],
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter some text";
        }
      },
      onSaved: (value) {
        name = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}
