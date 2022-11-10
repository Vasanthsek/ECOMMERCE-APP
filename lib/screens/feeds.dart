import 'package:badges/badges.dart';
import 'package:ecommerce_app/widgets/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favs_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/wishlist.dart';
import 'cart.dart';


class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Future<void> _getProductsOnRefresh() async {
    await Provider.of<ProductProvider>(context, listen: false).FetchProducts();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments.toString();
    final productsProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList= productsProvider.products ;
    if(popular == "popular"){
      productsList = productsProvider.popularProducts;
    }
    return  Scaffold(
      appBar: AppBar(title: Text("Feeds"),
      // backgroundColor: Theme.of(context).cardColor,
      actions: [
        Consumer<FavsProvider>(
                    builder: (context, value, child) =>
                     Badge(
                     
                      badgeColor: Colors.red,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5,end: 7),
                      badgeContent: Text(
                     value.getFavsItems.length.toString(),// or   favsProvider.getFavsItems.length.toString(),
                        style: TextStyle(color: Colors.white),),

                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(WishlistScreen.routeName);
                        },
                      ),
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) =>
                     Badge(
                      badgeColor: Colors.red,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5,end: 7),
                      badgeContent: Text(
                      value.getCartItems.length.toString(), // or cartProvider.getCartItems.length.toString(),
                        style: TextStyle(color: Colors.white),),

                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.cartShopping,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      ),
                    ),
                  ),
      ]),
        body:

        RefreshIndicator(
          onRefresh: _getProductsOnRefresh,
          child: GridView.count( //we can also implement staggered gridview with flutter_staggered_grid package

            mainAxisSpacing:3,
            crossAxisSpacing: 3,
            childAspectRatio: 240/420,   //290,
            crossAxisCount: 2,
            children: [...List.generate(productsList.length, (index) => ChangeNotifierProvider.value(
              value: productsList[index],
              child: const FeedProducts(),
            ))],
            ),
        ),
    );
  }
}