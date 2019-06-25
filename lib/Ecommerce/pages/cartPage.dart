import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/components//cartProducts.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var products = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'price': 110,
      'size':'L',
      'color':'Black',
      'quantity':1
    },
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer2.jpeg',
      'oldPrice': 120,
      'price': 90,
      'size':'L',
      'color':'Blue',
      'quantity':1
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'oldPrice': 39.99,
      'price': 20.99,
      'size':'L',
      'color':'Red',
      'quantity':1
    },
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'price': 110,
      'size':'L',
      'color':'Black',
      'quantity':1
    },
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer2.jpeg',
      'oldPrice': 120,
      'price': 90,
      'size':'L',
      'color':'Blue',
      'quantity':1
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'oldPrice': 39.99,
      'price': 20.99,
      'size':'L',
      'color':'Red',
      'quantity':1
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red.shade900,
        title: Text("Cart"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              return Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
          border: Border(top: BorderSide(style: BorderStyle.solid,color: Colors.grey[200],width: 1.0))
        ),
        height: 50.0,

        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Text("Total : 213 \$"),
                )),
            Expanded(
              child:MaterialButton(
                shape: Border.all(style: BorderStyle.none),
                height: 50.0,
                onPressed: () {},
                color: Colors.red.shade900,
                child: Text("Check out "),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
       body: CartProducts(productList: products,),
    );
  }
}
