import 'package:flutter/material.dart';

class HorizListView extends StatelessWidget {
  List < Map<String,String> > imgList=[
    {'url':'images/cats/dress.png','caption':'Dresses'},
    {'url':'images/cats/formal.png','caption':'Formal'},
    {'url':'images/cats/informal.png','caption':'Informal'},
    {'url':'images/cats/jeans.png','caption':'Jeans'},
    {'url':'images/cats/tshirt.png','caption':'Tshirts'},
    {'url':'images/cats/shoe.png','caption':'Shoes'},
    {'url':'images/cats/accessories.png','caption':'Accessories'},
  ] ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imgList.map((item){
          return Category(url: item['url'],caption: item['caption']);
        }).toList(),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String url;
  final String caption;

  const Category({Key key, @required this.url,@required  this.caption}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: 100.0,
        child: ListTile(

          title:Container( padding: EdgeInsets.all(5.0),child: Image.asset(url,color: Colors.deepOrange,)),
          subtitle: Text(caption, textAlign: TextAlign.center,style: TextStyle(fontSize: 11.0),),

        ),
      ),
    );
  }
}

