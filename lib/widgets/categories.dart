import 'package:ecommerce_app/inner_screens/category_feeds.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final int index;
  const Category({Key? key,required this.index}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImagesPath': 'images/CatPhones.png',
    },
    {
      'categoryName': 'Clothes',
      'categoryImagesPath': 'images/CatClothes.jpg',
    },
    {
      'categoryName': 'Shoes',
      'categoryImagesPath': 'images/CatShoes.jpg',
    },
    {
      'categoryName': 'Beauty&Health',
      'categoryImagesPath': 'images/CatBeauty.jpg',
    },
    {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'images/CatLaptops.png',
    },
    {
      'categoryName': 'Furniture',
      'categoryImagesPath': 'images/CatFurniture.jpg',
    },
    {
      'categoryName': 'Watches',
      'categoryImagesPath': 'images/CatWatches.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
        Navigator.of(context).pushNamed(CategoryFeedsScreen.routeName,arguments: "${categories[widget.index]["categoryName"]}" );
        // print(categories[widget.index]["categoryName"]);
      },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(categories[widget.index]['categoryImagesPath'].toString()),
              fit: BoxFit.cover),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
         bottom: 0,
          left: 10,
          right: 10,
          child: 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              
              categories[widget.index]['categoryName'].toString(),
              style: TextStyle(overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
          ),
         ),
      ],
    );
  }
}