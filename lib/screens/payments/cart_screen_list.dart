import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/cart_item_tile.dart';

class CartScreenList extends StatefulWidget {
  const CartScreenList({super.key});

  @override
  State<CartScreenList> createState() => _CartScreenListState();
}

class _CartScreenListState extends State<CartScreenList> {
  // Dummy Data
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Netflix Premium',
      'price': 12.99,
      'validity': '1 Month',
      'image':
          'https://images.unsplash.com/photo-1616469829935-c2f334624b38?q=80&w=1974',
    },
    {
      'name': 'Spotify Family',
      'price': 9.99,
      'validity': '1 Month',
      'image':
          'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Scaffold(
      appBar: AppbarCustomAll(
        title: "My Cart",
        showLogo: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Chip(label: Text('Cart (${_cartItems.length})')),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Expanded(
                child: _cartItems.isEmpty
                    ? const Center(child: Text("Your cart is empty!"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          return CartItemTile(
                            item: _cartItems[index],
                            onRemove: () {
                              setState(() {
                                _cartItems.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
              ),
              //bottom CheakOut
              _buildCheckoutSection(theme, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(ThemeData theme, bool isMobile) {
    double total = _cartItems.fold(0, (sum, item) => sum + item['price']);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // navigate
                  mySnkmsg('Comming...', context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
