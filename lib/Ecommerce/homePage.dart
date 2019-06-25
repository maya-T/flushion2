import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutterfirebase/Ecommerce/components/horizontalListview.dart';
import 'package:flutterfirebase/Ecommerce/components/productGrid.dart';
import 'package:flutterfirebase/Ecommerce/pages/cartPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var productList = [

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
    {
      'name': 'Dress',
      'picture': 'images/products/dress2.jpeg',
      'oldPrice': 59.99,
      'price': 40
    },
    {
      'name': 'Hills',
      'picture': 'images/products/hills1.jpeg',
      'oldPrice': 25,
      'price': 20
    },
    {
      'name': 'Hills',
      'picture': 'images/products/hills2.jpeg',
      'oldPrice': 25,
      'price': 20
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants1.jpg',
      'oldPrice': 30,
      'price': 25
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants2.jpeg',
      'oldPrice': 30,
      'price': 25
    },
    {
      'name': 'Shoes',
      'picture': 'images/products/shoe1.jpg',
      'oldPrice': 45,
      'price': 40
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt1.jpeg',
      'oldPrice': 15,
      'price': 12
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt2.jpeg',
      'oldPrice': 15,
      'price': 12
    },
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
    {
      'name': 'Dress',
      'picture': 'images/products/dress2.jpeg',
      'oldPrice': 59.99,
      'price': 40
    },
    {
      'name': 'Hills',
      'picture': 'images/products/hills1.jpeg',
      'oldPrice': 25,
      'price': 20
    },
    {
      'name': 'Hills',
      'picture': 'images/products/hills2.jpeg',
      'oldPrice': 25,
      'price': 20
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants1.jpg',
      'oldPrice': 30,
      'price': 25
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants2.jpeg',
      'oldPrice': 30,
      'price': 25
    },
    {
      'name': 'Shoes',
      'picture': 'images/products/shoe1.jpg',
      'oldPrice': 45,
      'price': 40
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt1.jpeg',
      'oldPrice': 15,
      'price': 12
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt2.jpeg',
      'oldPrice': 15,
      'price': 12
    },
  ];

  List<String> imgList = [
    'images/c1.jpg',
    'images/m1.jpeg',
    'images/m2.jpg',
    'images/w1.jpeg',
    'images/w3.jpeg',
    'images/w4.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red.shade900,
        title: Text("FASHapp"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ShoppingCart();
            }));
          })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Maya Touzari",
              ),
              accountEmail: Text(
                " mayatouzari@gmail.com",
              ),
              decoration: BoxDecoration(color: Colors.red.shade900),
              currentAccountPicture: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeJzOibFtTEAEQH9lyt0Zs8epkaS9GZugkg-Su1O_0jmCQC0dl3A"),
                  )),
            ),
            InkWell(
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(
                  Icons.home,
                  color: Colors.red.shade900,
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My account"),
                leading: Icon(
                  Icons.person,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My orders"),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ShoppingCart();
                }));
              },
              child: ListTile(
                title: Text("Shopping cart"),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Favorites"),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About"),
                leading: Icon(
                  Icons.help,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          CarouselSlider(
              autoPlayAnimationDuration: Duration(seconds: 3),
              height: 250.0,
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              autoPlay: false,
              enableInfiniteScroll: true,
              items: imgList.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    item,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList()),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            color: Colors.grey[200],
            height: 40.0,
            child: Text("Categories"),
          ),
          HorizListView(),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            color: Colors.grey[200],
            height: 40.0,
            child: Text("Recent products"),
          ),
          Flexible(
              //height: MediaQuery.of(context).size.height-250.0,
              child: ProductGrid(productList: productList,)
          )
        ],
      ),
    );
  }
}
