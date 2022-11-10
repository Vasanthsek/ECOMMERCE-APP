import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favs_provider.dart';
import '../providers/product_provider.dart';

class PopularProducts extends StatelessWidget {
  
  const PopularProducts({Key? key,}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
      
    final productsAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
     final favsProvider = Provider.of<FavsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius:const BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
           borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),),
            onTap: () {Navigator.pushNamed(context, ProductDetails.routeName,arguments: productsAttributes.id);},
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  productsAttributes.imageUrl),
                              fit: BoxFit.contain)),
                    ),
                  
                    Positioned(
                      right: 10,
                      top: 7,
                      child: FaIcon(FontAwesomeIcons.star,
                        color: favsProvider.getFavsItems.containsKey(productsAttributes.id) ?Colors.red: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${productsAttributes.price}',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding:const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsAttributes.title,
                        maxLines: 1,
                        style:const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Expanded(
                            flex: 5,
                            child:  Text(
                              productsAttributes.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: cartProvider.getCartItems.containsKey(productsAttributes.id)
                              ? (){}
                              :() {
                        cartProvider.addProductToCart(productsAttributes.id, productsAttributes.price, productsAttributes.title, productsAttributes.imageUrl);
                      },
                                borderRadius: BorderRadius.circular(30.0),
                                child:  Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child:  FaIcon(
                                    cartProvider.getCartItems.containsKey(productsAttributes.id)
                              ? FontAwesomeIcons.check:
                                    FontAwesomeIcons.cartShopping,
                                     size: 25,
                                     color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}