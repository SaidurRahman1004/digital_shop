import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../config/colors.dart';
import '../../widgets/AppbarCustom.dart';
import '../../widgets/product_grid.dart';
import '../../widgets/profile/support_contact_bottom_sheet.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  //Dummy data for wishlist items
  final List<Map<String, dynamic>> _wishlistItems =  [
    {
      'name': 'Netflix Premium',
      'category': 'Entertainment',
      'price': 12.99,
      'image':
          'https://images.unsplash.com/photo-1616469829935-c2f334624b38?q=80&w=1974',
      'badge': 'Popular',
      'status': 'On Sale',
    },
    {
      'name': 'VS Code Pro',
      'category': 'Software',
      'price': 10.00,
      'image':
          'https://images.unsplash.com/photo-1607706189992-eae57192d32d?q=80&w=1974',
      'badge': 'New',
      'status': 'In Stock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustomAll(
        title: "My Wishlist",
        showLogo: false,
        showDefaultActions: false,
        actions: [
          if (_wishlistItems.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                //  clear wishlist
                setState(() {
                  _wishlistItems.clear();
                });
              },
              icon: const Icon(Iconsax.trash, color: AppColors.error),
              label: const Text(
                'Clear All',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : ProductGrid(key: UniqueKey(), products: _wishlistItems),
      //contact support button
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showSupportContact(context),
          child: const Icon(Iconsax.call),
        tooltip: "Contact Support",
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // এটিকে মাঝখানে আনার জন্য

    );

  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.heart_slash, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 24),
            Text(
              "Your Wishlist is Empty",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Looks like you haven't added anything to your wishlist yet. Tap the heart icon on products to save them here!",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate  shop screen
                Navigator.pop(context);
              },
              icon: const Icon(Iconsax.shopping_bag),
              label: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );

  }
}
