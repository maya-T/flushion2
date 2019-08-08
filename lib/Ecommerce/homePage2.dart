import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/Ecommerce/components/horizontalListview.dart';
import 'package:flutterfirebase/Ecommerce/components/productGrid.dart';
import 'package:flutterfirebase/Ecommerce/pages/cartPage.dart';
import 'package:flutterfirebase/Ecommerce/pages/loginPage.dart';
import 'package:flutterfirebase/Ecommerce/provider/userProvider.dart';
import 'package:provider/provider.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<String> imgList = [
    'images/c1.jpg',
    'images/m1.jpeg',
    'images/m2.jpg',
    'images/w1.jpeg',
    'images/w3.jpeg',
    'images/w4.jpeg'
  ];
  var productList = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'oldPrice': 0,
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
  Widget title = Text(
    "Flushion",
    style: TextStyle(color: Colors.deepOrange),
  );
  //////////////////////////////////////////
  Icon icon = Icon(
    Icons.search,
    color: Colors.deepOrange,
  );
  bool _disable = false;
  bool isSelected = false;
  bool _collapse = false;
  Icon arrow = Icon(Icons.keyboard_arrow_up);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.deepOrange),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: title,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = true;
                  title = null;
                });
              },
              child: _buildItem(Item(
                  icon: Icon(Icons.search),
                  title: Text("Search"),
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.deepOrange)),
            ),
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
                decoration: BoxDecoration(color: Colors.deepOrange),
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
                    color: Colors.deepOrange,
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
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text("My orders"),
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.deepOrange,
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
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text("Favorites"),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.deepOrange,
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
              InkWell(
                onTap: () {
                  user.signOut();
                },
                child: ListTile(
                  title: Text("Log out"),
                  leading: Icon(
                    Icons.transit_enterexit,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _collapse ? 0.0 : 250.0,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 400),
              child: CarouselSlider(
                  autoPlayAnimationDuration: Duration(seconds: 3),
                  height: 250.0,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  autoPlay: true,
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
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              color: Colors.grey[200],
              height: 40.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Recent products"),
                  InkWell(
                    child: arrow,
                    onTap: () {
                      if (!_collapse) {
                        setState(() {
                          _collapse = true;
                          arrow = Icon(Icons.keyboard_arrow_down);
                        });
                      } else {
                        setState(() {
                          _collapse = false;
                          arrow = Icon(Icons.keyboard_arrow_up);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Flexible(
                //height: MediaQuery.of(context).size.height-250.0,
                child: ProductGrid(
              productList: productList,
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Item item) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: AnimatedContainer(
          width: isSelected ? 300 : 50,
          height: double.maxFinite,
          duration: Duration(milliseconds: 600),
          padding: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            color:
                isSelected ? item.activeColor.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: isSelected
              ? TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                      icon: InkWell(
                        child: Icon(
                          Icons.clear,
                          color: Colors.deepOrange,
                        ),
                        onTap: () {
                          setState(() {
                            isSelected = false;
                            title = Text(
                              "Flushion",
                              style: TextStyle(color: Colors.deepOrange),
                            );
                          });
                        },
                      )),
                )
              : Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                )),
    );
  }
}

class Item {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  Item(
      {@required this.icon,
      @required this.title,
      this.activeColor = Colors.blue,
      this.inactiveColor}) {
    assert(icon != null);
    assert(title != null);
  }
}
