// ignore_for_file: deprecated_member_use
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_app/consts/theme.dart';
import 'package:ecommerce_app/inner_screens/brandnavigation.dart';
import 'package:ecommerce_app/inner_screens/category_feeds.dart';
import 'package:ecommerce_app/inner_screens/product_details.dart';
import 'package:ecommerce_app/inner_screens/upload_product_form.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/dark_theme_provider.dart';
import 'package:ecommerce_app/providers/favs_provider.dart';
import 'package:ecommerce_app/providers/order_provider.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screens/auth/forget_password.dart';
import 'package:ecommerce_app/screens/auth/login.dart';
import 'package:ecommerce_app/screens/auth/sign_up.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/feeds.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/landing_page.dart';
import 'package:ecommerce_app/screens/orders/order_screen.dart';
import 'package:ecommerce_app/screens/search.dart';
import 'package:ecommerce_app/screens/user.dart';
import 'package:ecommerce_app/screens/user_state.dart';
import 'package:ecommerce_app/widgets/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkThemee =
        await themeChangeProvider.ddarkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return
            const  MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator(),)),
            );

        } else if(snapshot.hasError){
          return
            const  MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator(),)),
            );

        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DarkThemeProvider(), // or themeChangeProvider,
            ),
            ChangeNotifierProvider(
              create: (context) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CartProvider(),
            ),
             ChangeNotifierProvider(
              create: (context) => FavsProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => OrdersProvider(),
            ),
           
          ],
          child: Consumer<DarkThemeProvider>(builder: (context, themeChangeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Ecommerce App',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home:const UserState(), //MainScreen(),
              routes: {
                BrandNavigation.routeName :(context) => BrandNavigation(),
                CartScreen.routeName: (ctx) => const CartScreen(),
                  FeedsScreen.routeName: (ctx) =>const  FeedsScreen(),
                  WishlistScreen.routeName: (ctx) =>const  WishlistScreen(),
                  ProductDetails.routeName:(context) => const ProductDetails(),
                  CategoryFeedsScreen.routeName:(context) => const CategoryFeedsScreen(),
                  LoginScreen.routeName:(context) => const LoginScreen(),
                  SignUpScreen.routeName:(context) => const SignUpScreen(),
                  BottomBarScreen.routeName:(context) => const BottomBarScreen(),
                  UploadProductForm.routeName:(context) => const UploadProductForm(),
                  ForgetPassword.routeName:(context) => const ForgetPassword(),
                  OrderScreen.routeName:(context) => const OrderScreen(),
                  
              },
            );
          }),
        );
      }
    );
  }
}

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  var _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': const HomeScreen(), 'title': 'Home Screen'},
      {'page': const FeedsScreen(), 'title': 'Feeds screen'},
      {'page': const SearchScreen(), 'title': 'Search Screen'},
      {'page': const CartScreen(), 'title': 'CartScreen'},
      {'page': const UserScreen(), 'title': 'UserScreen'}
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 2,
        clipBehavior: Clip
            .antiAlias, // only works if padding is done on floatingactionbutton
        //  elevation: 5,
        shape: const CircularNotchedRectangle(),
        child: Container(
          // height: kBottomNavigationBarHeight * 0.8,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(width: 1, color: Colors.purple),
          )),
          child: BottomNavigationBar(
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                tooltip: 'Home',
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.rss),
                tooltip: 'Feeds',
                label: 'Feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null), // Icon(
                //   Icons.search,
                //   color: Colors.transparent,
                // ),
                tooltip: 'Search',
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.cartShopping),
                tooltip: 'Cart',
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                tooltip: 'User',
                label: 'User',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          tooltip: 'Search',
          elevation: 5,
          child: (const FaIcon(FontAwesomeIcons.magnifyingGlass)),
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
      ),
    );
  }
}
