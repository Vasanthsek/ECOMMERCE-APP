// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/orders/order_screen.dart';
import 'package:ecommerce_app/widgets/empty_cart.dart';
import 'package:ecommerce_app/widgets/full_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../consts/colors.dart';
import '../services/global_method.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();

    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg("Are you Sure", "Clear Cart",
                        () => cartProvider.clearCart(), context);
                    // cartProvider.clearCart();
                  },
                  icon: FaIcon(FontAwesomeIcons.trash),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                          value:
                              cartProvider.getCartItems.values.toList()[index],
                          child: CartFull(
                            productId:
                                cartProvider.getCartItems.keys.toList()[index],
                          ));
                    }),
              ),
            ));
  }

  Widget checkoutSection(BuildContext ctx, double fulltotal) {
    var uuid = Uuid();
    final cartProvider = Provider.of<CartProvider>(ctx,listen: false);
    String? _uid;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: const [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async {


                        User? user = _auth.currentUser;
                         _uid = user!.uid;
                        cartProvider.getCartItems
                            .forEach((key, orderValue) async {
                          final orderId = uuid.v4();
                          try {
                            await FirebaseFirestore.instance
                                .collection('order')
                                .doc(orderId)
                                .set({
                              'orderId': orderId,
                              'userId': _uid,
                              'productId': orderValue.productId,
                              'title': orderValue.title,
                              'price': orderValue.price * orderValue.quantity,
                              'imageUrl': orderValue.imageUrl,
                              'quantity': orderValue.quantity,
                              'orderDate': Timestamp.now(),
                            }).then((value) => Navigator.pushNamed(ctx, OrderScreen.routeName));
                          } catch (err) {
                            print('error occured $err');
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US ${fulltotal.toStringAsFixed(2)}\$',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
