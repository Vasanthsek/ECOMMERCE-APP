// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/models/Fav_attr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../inner_screens/product_details.dart';
import '../providers/favs_provider.dart';
import '../services/global_method.dart';


class WishlistFull extends StatelessWidget {
  final String productId;
  const WishlistFull({Key? key,required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final favsAttr = Provider.of<FavsAttr>(context);
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductDetails.routeName,arguments: productId);
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(
                    favsAttr.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favsAttr.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${favsAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(productId,context),
      ],
    );
    
  }

  
}

Widget positionedRemove(String productId, BuildContext context) {
  GlobalMethods globalMethods = GlobalMethods();
     final favsProvider = Provider.of<FavsProvider>(context);
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: ColorsConsts.favColor,
          child: FaIcon(FontAwesomeIcons.xmark,color: Colors.red),
          onPressed: () {
           globalMethods.showDialogg("Are you sure", "Remove Wish", ()=>favsProvider.removeItem(productId), context); 
             
          },
        ),
      ),
    );
  }