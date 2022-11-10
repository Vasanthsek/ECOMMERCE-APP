import 'package:ecommerce_app/inner_screens/upload_product_form.dart';
import 'package:ecommerce_app/widgets/wishlist.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../consts/colors.dart';
import '../screens/cart.dart';
import '../screens/feeds.dart';

class BackLayerMenu extends StatelessWidget {
  final String imageUrl;
  const BackLayerMenu({Key? key,required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  ColorsConsts.starterColor,
                  ColorsConsts.endColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      //   clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image:  DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context,  FeedsScreen.routeName);
                }, 'Feeds', FontAwesomeIcons.rss),
                const SizedBox(height: 10.0),
                content(context, () {
                   navigateTo(context,  CartScreen.routeName);
                }, 'Cart', FontAwesomeIcons.cartShopping),
                const SizedBox(height: 10.0),
                content(context, () {
                 navigateTo(context,  WishlistScreen.routeName);
                }, 'Wishlist', FontAwesomeIcons.heart),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context,  UploadProductForm.routeName);
                }, 'Upload a new product', FontAwesomeIcons.cloudArrowUp),
              ],
            ),
          ),
        ),
      ],
    );
  }

   void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

  Widget content(BuildContext ctx, Function fct, String text, IconData icon) {
    return InkWell(
      onTap: (){fct();},  // That (){} is very important...
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          FaIcon(icon)
        ],
      ),
    );
  }
}
