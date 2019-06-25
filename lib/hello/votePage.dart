import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotePage extends StatefulWidget {
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
//  final snapshot = [
//    {"name": "The toddler pockets", "votes": 15},
//    {"name": "Everybody loves my pants", "votes": 14},
//    {"name": "Mo bunny Mo problems", "votes": 11},
//    {"name": "James and the angry Biscuits", "votes": 10},
//  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Votes")),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('bandNames').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return ListView(
                      children:
                          snapshot.data.documents.map((DocumentSnapshot item) {
                        return ListTile(
                          onTap: (){
                            //item.reference.updateData({'votes':item['votes']+1});
                            Firestore.instance.runTransaction((transaction) async{
                              DocumentSnapshot freshSnap=await transaction.get(item.reference);
                              await transaction.update(freshSnap.reference,{  'votes':freshSnap['votes']+1});
                            });
                          },
                          title: Text(item["name"]),
                          trailing: Text(item["votes"].toString()),
                        );
                      }).toList(),
                    );
                }
              }
            }
//
            ));
  }
}
