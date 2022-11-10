import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/services/global_method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'order_empty.dart';
import 'order_full.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isOrder = false;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
     GlobalMethods globalMethods = GlobalMethods();
     return FutureBuilder(
       future: ordersProvider.fetchOrders(),
         builder: (context, snapshot) {
         return ordersProvider.getOrders.isEmpty ?
         const Scaffold(body: OrderEmpty()):
         Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              // backgroundColor: Theme.of(context).backgroundColor,
              title:  Text('Orders (${ordersProvider.getOrders.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    // globalMethods.showDialogg(
                    //     'Clear cart!',
                    //     'Your cart will be cleared!',
                    //     () => cartProvider.clearCart(),
                    //     context);
                    
                  },
                  icon: const FaIcon(FontAwesomeIcons.trash,
                )
            )],
            ),
            body:

                Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: ListView.builder(
                      itemCount: ordersProvider.getOrders.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return  ChangeNotifierProvider.value(
                          value: ordersProvider.getOrders[index],
                          child: const OrderFull(

                             // productId: "",

                          ),
                        );
                      }),
                ),

          );
  }
    );
    
  }
}