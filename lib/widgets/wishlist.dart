import 'package:ecommerce_app/providers/favs_provider.dart';
import 'package:ecommerce_app/widgets/wishlist_empty.dart';
import 'package:ecommerce_app/widgets/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/global_method.dart';


class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? const Scaffold(body:  WishlistEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist(${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                   globalMethods.showDialogg("Are you Sure", "Clear Cart",()=>favsProvider.clearFavs(),context);
                    // cartProvider.clearCart();
                  },
                  icon: const FaIcon(FontAwesomeIcons.trash),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: favsProvider.getFavsItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: favsProvider.getFavsItems.values.toList()[index],
                  child: WishlistFull(
                    productId: favsProvider.getFavsItems.keys.toList()[index],
                  ));
              },
            ),
          );
  }
}