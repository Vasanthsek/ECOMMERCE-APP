import 'package:backdrop/backdrop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:ecommerce_app/widgets/backlayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../inner_screens/brandnavigation.dart';
import '../widgets/categories.dart';
import '../widgets/popularproducts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
@override
  void initState() {
    getData();
    _getPopularProductsOnRefresh();
    super.initState();
  }
  String? _userImageUrl;
  String? _uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {

        _userImageUrl = userDoc.get('imageUrl');
      });
    }
    // print("name $_name");
  }



  Future<void> _getPopularProductsOnRefresh() async {
    await Provider.of<ProductProvider>(context, listen: false).FetchProducts();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    productsData.FetchProducts(); //*** 

    final popularItems = productsData.popularProducts;
    print("length =${popularItems.length}");
    List carouselimages = [
      "images/carousel1.png",
      "images/carousel2.jpeg",
      "images/carousel3.jpg",
      "images/carousel4.png"
    ];
    List _brandImages = [
      'images/addidas.jpg',
      'images/apple.jpg',
      'images/Dell.jpg',
      'images/h&m.jpg',
      'images/nike.jpg',
      'images/samsung.jpg',
      'images/huawai.png',
    ];
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorsConsts.starterColor,
                ColorsConsts.endColor
              ])),
            ),
            leading: const BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            title: const Text("Home"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon:  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          _userImageUrl?? "https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg"),
                      radius: 13,
                    )),
                padding: const EdgeInsets.all(10),
              )
            ],
          ),
          backLayer:  BackLayerMenu(imageUrl: _userImageUrl ?? "https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg"),
          frontLayer: RefreshIndicator(
            onRefresh: _getPopularProductsOnRefresh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: CarouselSlider.builder(
                      itemCount: carouselimages.length,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          child: Image.asset(
                            carouselimages[index],
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.25,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        // viewportFraction: 0.9,
                        // aspectRatio: 1.0,
                        initialPage: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Category(
                          index: index,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                         Text(
                          'Popular Brands',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                          Spacer(),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.of(context).pushNamed(
                        //     BrandNavigation.routeName,
                        //     arguments: {
                        //       7,
                        //     },
                        //   );
                        //   },
                        //   child: const Text(
                        //     'View all...',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w800,
                        //         fontSize: 15,
                        //         color: Colors.red),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Swiper(
                      autoplay: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      onTap: (index) {
                        Navigator.of(context).pushNamed(
                        BrandNavigation.routeName,
                        arguments: {
                          index,
                        },
                      );
                      },
                      itemCount: _brandImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blueGrey,
                            child: Image.asset(
                              _brandImages[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Popular Products',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(FeedsScreen.routeName,arguments: "popular");
                          },
                          child: const Text(
                            'View all...',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 285,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child:popularItems.isEmpty ? const Center(child: Text("Refresh the screen",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18)) ): ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return ChangeNotifierProvider.value(
                            value: popularItems[index],
                            child: const PopularProducts());
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
