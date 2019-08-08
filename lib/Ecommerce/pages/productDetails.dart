import 'package:flutter/material.dart';
import 'package:flutterfirebase/Ecommerce/pages/cartPage.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String picture;
  final double oldPrice;
  final double price;

  const ProductDetails(
      {Key key,
      @required this.name,
      @required this.picture,
      @required this.oldPrice,
      @required this.price})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var similarProducts = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'oldPrice': 140,
      'price': 110
    },
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer2.jpeg',
      'oldPrice': 120,
      'price': 90
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'oldPrice': 39.99,
      'price': 20.99
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange),
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text("Flushion"),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {},
//          ),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ShoppingCart();
                }));
              }),
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              return Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 20.0)
            ]),
            margin: EdgeInsets.all(0.0),
            height: 300.0,
            child: GridTile(
              footer: Container(

                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 60.0),
                    leading: Text(
                      widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    title: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("${widget.oldPrice.toString()}\$",
                              style: TextStyle(
                                fontSize: 14.0,
                                decoration: TextDecoration.lineThrough,
                              )),
                        ),
                        Text(
                          "${widget.price.toString()}\$",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  )),
              child: Image.asset(
                widget.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0.0),
            color: Colors.white,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child: DropDown(
                  elements: ["XS", "S", "M", "L"],
                  hint: "Size",
                )),
                VerticalDivider(),
                Expanded(
                  child: DropDown(
                    elements: ["Black", "Blue", "Brown"],
                    hint: "Color",
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: DropDown(
                    elements: ["1", "2", "3", "4"],
                    hint: "Quantity",
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 40.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                      height: 40.0,
                      elevation: 1.0,
                      onPressed: () {},
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text('Buy now')),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {},
                  color: Colors.deepOrange,
                ),
                VerticalDivider(),
                IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.deepOrange,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text("Product details"),
            subtitle: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod te"
                "mpor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, "
                "quis nostrud exercitati"
                "on ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute "
                "irure dolor in reprehenderit in voluptate velit esse"
                " cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cu"
                "pidatat non proident, sunt in culpa qui officia deserunt mollit anim id"
                " est laborum."),
          ),
          Divider(),
          Container(
            height: 40.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Product name :   ${widget.name} ."),
            ),
          ),
          Container(
            height: 40.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Product brand :   Brand X ."),
            ),
          ),
          Container(
            height: 40.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Product condition :   New ."),
            ),
          ),
          Container(
            color: Colors.grey[100],
            height: 40.0,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Similar Products",
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 120.0,
              child: SimilarProducts(similarProducts: similarProducts))
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final List<String> elements;
  final String hint;
  const DropDown({Key key, @required this.elements, @required this.hint})
      : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var _selected;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          elevation: 0,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          hint: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Text(
              widget.hint,
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
          ),
          value: _selected,
          items: widget.elements.map((elmt) {
            return DropdownMenuItem(value: elmt, child: Text(elmt));
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selected = val;
              //print(val);
            });
          }),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  var similarProducts;
  SimilarProducts({Key key, @required this.similarProducts}) : super(key: key);
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      semanticChildCount: widget.similarProducts.length,
      primary: false,
      slivers: <Widget>[
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, i) {
            return Card(
              child: Material(
                color: Colors.black,
                child: InkWell(
                  onTap: () {
                    return Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductDetails(
                        name: widget.similarProducts[i]['name'],
                        picture: widget.similarProducts[i]['picture'],
                        price: (widget.similarProducts[i]['price'] as num)
                            .toDouble(),
                        oldPrice: (widget.similarProducts[i]['oldPrice'] as num)
                            .toDouble(),
                      );
                    }));
                  },
                  child: GridTile(
                    footer: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Text(
                            widget.similarProducts[i]['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            "${widget.similarProducts[i]['price'].toString()}\$",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                          trailing: Text(
                              "${widget.similarProducts[i]['oldPrice'].toString()}\$",
                              style: TextStyle(
                                fontSize: 10.0,
                                decoration: TextDecoration.lineThrough,
                              )),
                        )),
                    child: Image.asset(
                      widget.similarProducts[i]['picture'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }, childCount: widget.similarProducts.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ],
    );
  }
}
