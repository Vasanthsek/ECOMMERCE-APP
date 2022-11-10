import 'package:ecommerce_app/widgets/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';


class CategoryFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoryFeedsScreen';
  const CategoryFeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  categoryName = ModalRoute.of(context)!.settings.arguments as String; // *as String* is important or else the print statement will not work and it will not read by system
    print(categoryName);
    final productsProvider = Provider.of<ProductProvider>(context,listen: false);
    List<Product> productsList= productsProvider.findByCategory(categoryName); // we can use either final or List<Product>
    return  Scaffold(
        body:
        productsList.isEmpty ? const Center(child: Text("No Products Found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)):
        GridView.count( //we can also implement staggered gridview with flutter_staggered_grid package
          
          mainAxisSpacing:3,
          crossAxisSpacing: 3,
          childAspectRatio: 240/420,   //290,
          crossAxisCount: 2,
          children: [...List.generate(productsList.length, (index) => ChangeNotifierProvider.value(
            value: productsList[index],
            child: const FeedProducts(),
          ))],
          ),
    );
  }
}