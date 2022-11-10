import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../models/orders_attr.dart';
import '../../providers/cart_provider.dart';
import '../../providers/dark_theme_provider.dart';

class OrderFull extends StatefulWidget {
  // final String productId;
  const OrderFull({Key? key,}) : super(key: key);

  @override
  State<OrderFull> createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final ordersAttrProvider = Provider.of<OrdersAttr>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: ordersAttrProvider.productId),
      child: Container(
        height: 135,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      ordersAttrProvider.imageUrl),
                  //  fit: BoxFit.fill,
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
                            ordersAttrProvider.title,
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
                              globalMethods.showDialogg(
                                  'Remove item!',
                                  'Product will be removed from the Order!',
                                  () =>
                                      FirebaseFirestore.instance.collection('order').doc(ordersAttrProvider.orderId).delete(),
                                  context);

                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: const FaIcon(
                                FontAwesomeIcons.xmark,
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
                        Text("Price:"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${ordersAttrProvider.price}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Quantity:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'x${ordersAttrProvider.quantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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