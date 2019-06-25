import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  var productList;
  CartProducts({Key key, @required this.productList}) : super(key: key);
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 130.0,
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return CartProduct(
            name: widget.productList[index]['name'],
            picture: widget.productList[index]['picture'],
            price: (widget.productList[index]['price'] as num).toDouble(),
            size: widget.productList[index]['size'],
            color: widget.productList[index]['color'],
            quantity: widget.productList[index]['quantity'],
          );
        });
  }
}

 class CartProduct extends StatefulWidget {
   final String name;
   final String picture;
   final double price;
   final String size;
   final String color;
   int quantity;

   CartProduct(
       {Key key,
         @required this.name,
         @required this.picture,
         @required this.price,
         @required this.size,
         @required this.color,
         @required this.quantity})
       : super(key: key);

   @override
   _CartProductState createState() => _CartProductState();
 }

 class _CartProductState extends State<CartProduct> {
   @override
   Widget build(BuildContext context) {
     return Card(
       child: Row(
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Image.asset(
               widget.picture,
               height: 100.0,
               width: 100,
               fit: BoxFit.cover,
             ),
           ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Expanded(
                     child: Padding(
                       padding: const EdgeInsets.only(top: 12.0),
                       child: Text(
                         widget.name,
                         style:
                         TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                       ),
                     )),
                 Expanded(
                   child: Row(
                     children: <Widget>[
                       Expanded(child: Text("Size : ${widget.size}")),
                       Expanded(child: Text("Color : ${widget.color}")),
                     ],
                   ),
                 ),
                 Expanded(
                   child: Text(
                     "${widget.price}\$",
                     style: TextStyle(
                       fontSize: 17.0,
                       fontWeight: FontWeight.bold,
                       color: Colors.red.shade900,
                     ),
                   ),
                 ),
               ],
             ),
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               IconButton(
                 padding: EdgeInsets.all(0.0),
                 icon: Icon(
                   Icons.keyboard_arrow_up,
                 ),
                 onPressed: () {
                   setState(() {
                     widget.quantity ++ ;
                   });
                 },
               ),
               Text(
                 widget.quantity.toString(),
               ),
               IconButton(
                 padding: EdgeInsets.all(0.0),
                 icon: Icon(
                   Icons.keyboard_arrow_down,
                 ),
                 onPressed: () {
                   setState(() {
                     if(widget.quantity>1) {
                       widget.quantity -- ;
                     }
                   });
                 },
               ),
             ],
           ),
         ],
       ),
     );
   }
 }

