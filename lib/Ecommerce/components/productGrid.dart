import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/pages/productDetails.dart';

class ProductGrid extends StatefulWidget {
  var productList;

  ProductGrid({Key key, @required this.productList}) : super(key: key);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ScrollPhysics(),
      semanticChildCount: widget.productList.length,
      primary: false,
      slivers: <Widget>[
        SliverGrid(

          delegate: SliverChildBuilderDelegate((context, i) {
            double oldPrice =
                (widget.productList[i]['oldPrice'] as num).toDouble();
            double price = (widget.productList[i]['price'] as num).toDouble();
            return Product(
              name: widget.productList[i]['name'],
              picture: widget.productList[i]['picture'],
              oldPrice: oldPrice,
              price: price,
            );
          }, childCount: widget.productList.length,),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),

        ),
      ],
    );
//    return GridView.builder(
//        shrinkWrap: true,
//        itemCount: productList.length,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,
//        ),
//        itemBuilder: (BuildContext context, i) {
//          double oldPrice = (productList[i]['oldPrice'] as num).toDouble();
//          double price = (productList[i]['price'] as num).toDouble();
//          return Product(
//            tag: i.toString(),
//            name: productList[i]['name'],
//            picture: productList[i]['picture'],
//            oldPrice: oldPrice,
//            price: price,
//          );
//        });
  }
}

class Product extends StatelessWidget {
  final String name;
  final String picture;
  final double oldPrice;
  final double price;

  const Product(
      {Key key,
      @required this.name,
      @required this.picture,
      this.oldPrice,
      @required this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        color: Colors.black,
        child: InkWell(
          onTap: () {
            return Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ProductDetails(
                  name: name,
                  picture: picture,
                  price: price,
                  oldPrice: oldPrice,
                  );
            }));
          },
          child: GridTile(
            footer: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    "${price.toString()}\$",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  trailing:
                  oldPrice==0?
                  null
                      :Text("${oldPrice.toString()}\$",
                      style: TextStyle(
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      )),
                )),
            child: Image.asset(
              picture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
