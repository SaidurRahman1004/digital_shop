import 'package:digital_shop/screens/homeContect/home_content.dart';
import 'package:digital_shop/screens/payments/cart_screen_list.dart';
import 'package:digital_shop/screens/shop_screen.dart';
import 'package:digital_shop/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ShopScreen(),
    CartScreenList(),
    Center(child: Text('Welcome to the Profile  Screen!')),
  ];

  //tap to Change Icon
  void onItemChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? const CustomAppBar() : null,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onItemChange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
