// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'brands_navigation_widget.dart';

class BrandNavigation extends StatefulWidget {
  
  BrandNavigation({Key? key}) : super(key: key);
static const routeName = '/brandnavigation';
  @override
  State<BrandNavigation> createState() => _BrandNavigationState();
}

class _BrandNavigationState extends State<BrandNavigation> {
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

  int? _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs = "";
  String brand = "";

  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(routeArgs.substring(1,2));
    print(routeArgs.toString());
    print(routeArgs);
    
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'Addidas';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Apple';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Dell';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'H&M';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Nike';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Samsung';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Huawei';
      });
    }
    // if (_selectedIndex == 7) {
    //   setState(() {
    //     // brand = 'All';
    //   });
    // }
    print(_selectedIndex);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'Addidas';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'Apple';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'Dell';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brand = 'H&M';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brand = 'Nike';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brand = 'Samsung';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brand = 'Huawei';
                            });
                          }
                          // if (_selectedIndex == 7) {
                          //   setState(() {
                          //     // brand = 'All';
                          //   });
                          // }
                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      backgroundColor: Colors.grey,
                      leading: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  _userImageUrl?? "https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                    
                    destinations: [
                      buildRotatedTextRailDestination('Addidas', padding),
                        buildRotatedTextRailDestination("Apple", padding),
                        buildRotatedTextRailDestination("Dell", padding),
                        buildRotatedTextRailDestination("H&M", padding),
                        buildRotatedTextRailDestination("Nike", padding),
                        buildRotatedTextRailDestination("Samsung", padding),
                        buildRotatedTextRailDestination("Huawei", padding),
                        // buildRotatedTextRailDestination("All", padding),
                    ],
                  ),
                ),
                ),
            );
          },),
          ContentSpace(context, brand, ),
        ],
      ),
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
 
  const ContentSpace(BuildContext context, this.brand, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context,listen: false);
    final productList = productsData.products;
    final productsBrand = productsData.findByBrand(brand);
    // print("${productsBrand[0].imageUrl}");
    //  if(brand!='Dell'&& brand!='Huawei'&& brand!='Samsung'&& brand!='Nike'&& brand!='H&M'&& brand!='Apple'&& brand!='Addidas' ){
    //   for(int i=0; i<productsData.products.length;i++){
    //     productsBrand?.add(productsData.products[i]);
    //   }
    //
    // }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child:productsBrand.isEmpty ? Center(child: Text("No Products Found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)): ListView.builder(
            itemCount: productsBrand.length,
            itemBuilder: (BuildContext context, int index) =>
               ChangeNotifierProvider.value(
            value: productsBrand[index],
            child: BrandNavigationRail()),
          ),
        ),
      ),
    );
  }
}