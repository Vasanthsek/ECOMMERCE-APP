import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/providers/dark_theme_provider.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/widgets/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import 'orders/order_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  // bool vvalue = false;
  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String? _uid;
  String? _name;
  String? _email;
  String? _joinedAt;
  String? _userImageUrl;
  String? _phoneNumber;
  @override
  void initState() {
    getData();
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   setState(() {});
    // });
  }

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
        _name = userDoc.get('name');
        _email = user.email;
        _joinedAt = userDoc.get('joinedAt');
        _phoneNumber = userDoc.get('phoneNumber');
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
    // print("name $_name");
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 4,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                top = constraints.biggest.height;
                return Container(
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
                  child: FlexibleSpaceBar(
                     
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: top <= 110.0 ? 1.0 : 0,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: kToolbarHeight / 1.8,
                            width: kToolbarHeight / 1.8,
                            decoration:  BoxDecoration(
                              boxShadow:const [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1.0,
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    _userImageUrl ?? "https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                           Text(
                            // 'top.toString()',
                         _name== null ?'Guest': _name.toString(),
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    background:  Image(
                      image: 
                      NetworkImage(
                                    _userImageUrl ?? "https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: titles('User Bag'),
                ),const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                userListTile('Wishlist', '', FontAwesomeIcons.heart, context,Icons.arrow_right,(){Navigator.of(context).pushNamed(WishlistScreen.routeName);}),
                userListTile('Cart', '', FontAwesomeIcons.cartShopping, context,Icons.arrow_right,(){Navigator.of(context).pushNamed(CartScreen.routeName);}),
                userListTile('My Orders', '', FontAwesomeIcons.bagShopping, context,Icons.arrow_right,(){Navigator.of(context).pushNamed(OrderScreen.routeName);}),
             
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: titles('User infomation'),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                userListTile('Email', _email ?? "", FontAwesomeIcons.envelope, context,null,(){}),
                
                
                userListTile('Phone number',_phoneNumber ?? ""   , FontAwesomeIcons.phone, context,null,(){}),
                userListTile(
                    'Shipping address', '', FontAwesomeIcons.truckFast, context,null,(){}),
               userListTile('Joined date', _joinedAt ?? '', FontAwesomeIcons.calendarDays, context,null,(){}),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: titles('User Settings'),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                ListTileSwitch(
                  value: themeChange.darkTheme,
                  leading: const FaIcon(FontAwesomeIcons.moon),
                  onChanged: (value) {
                    setState(() {
                      themeChange.darkThemee = value;
                    });
                  },
                  switchType: SwitchType.material,
                  switchActiveColor: Colors.green,
                  title: const Text('Theme'),
                ),
                Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            // Navigator.canPop(context)? Navigator.pop(context):null;
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Row(
                                      children:const [
                                        
                                        Text('Are you Sure'),
                                      ],
                                    ),
                                    content:const Text('Do you wanna Sign out?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            await _auth.signOut().then((value) => Navigator.pop(context));
                                          },
                                          child: const Text('Ok', style: TextStyle(color: Colors.red),))
                                    ],
                                  );
                                });
                          },
                          title: const Text('Logout'),
                          leading:const FaIcon(FontAwesomeIcons.rightToBracket),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titles(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget userListTile(
      String title, String subTitle, IconData icon, BuildContext context,IconData? iicon, VoidCallback function) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          trailing: FaIcon(iicon),
          onTap: function,
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(icon),
        ),
      ),
    );
  }
}
