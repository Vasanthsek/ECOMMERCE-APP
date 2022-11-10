
//OPTIONAL ONLY

import 'package:ecommerce_app/screens/landing_page.dart';
import 'package:flutter/material.dart';

import '../inner_screens/upload_product_form.dart';
import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
     
      children:const [ BottomBarScreen(),  UploadProductForm()],
    );
  }
}