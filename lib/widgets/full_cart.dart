import 'package:ecommerce_app/models/cart_attr.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../inner_screens/product_details.dart';
import '../providers/cart_provider.dart';
import '../providers/dark_theme_provider.dart';

class CartFull extends StatefulWidget {
  final String productId;
  const CartFull({Key? key,required this.productId}) : super(key: key);

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;
    final cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {Navigator.pushNamed(context, ProductDetails.routeName,arguments: widget.productId);},
      child: Container(
        height: 135,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(
           Radius.circular(16.0),
            
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration:  BoxDecoration(
                borderRadius:const BorderRadius.only(
                  topRight:Radius.circular(5), 
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      cartAttr.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Flexible(
                          child: Text(
                            cartAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                            globalMethods.showDialogg("Are you Sure", "Remove Items",()=>cartProvider.removeItem(widget.productId),context);
                              // cartProvider.removeItem(widget.productId);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: const FaIcon(
                                FontAwesomeIcons.trash,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                       const Text('Price:'),
                       const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartAttr.price}\$',
                          style:
                            const  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                     const   Text('Sub Total:'),
                     const   SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            '${subTotal.toStringAsFixed(2)}\$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: themeChange.darkTheme
                                    ? Colors.brown.shade900
                                    : Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Ships Free',
                          style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.brown.shade900
                                  : Theme.of(context).accentColor),
                        ),
                       const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                             cartAttr.quantity<=1 ? null: cartProvider.reduceItemByOne(
                                  widget.productId,
                                  cartAttr.price,
                                  cartAttr.title,
                                  cartAttr.imageUrl);
                            },
                            
                            child:  Container(
                              child: const Padding(
                                padding:  EdgeInsets.all(5.0),
                                child: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ], stops: const [
                                0.0,
                                0.7
                              ]),
                            ),
                            child:  Text(cartAttr.quantity.toString(), textAlign: TextAlign.center,),
                          ),
                        ),
                         Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.addProductToCart(
                                  widget.productId,
                                  cartAttr.price,
                                  cartAttr.title,
                                  cartAttr.imageUrl);
                            },
                            child:  Container(
                              child: const Padding(
                                padding:  EdgeInsets.all(5.0),
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
