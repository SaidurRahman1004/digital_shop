import 'package:digital_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProductGrid extends StatelessWidget {
  final String category;
  const ProductGrid({super.key, required this.category});

  // Dummy Data
  final List<Map<String, dynamic>> _allProducts = const [
    {
      'name': 'Netflix',
      'category': 'Entertainment',
      'price': 12.99,
      'image': '...url...',
      'badge': 'Popular',
    },
    {
      'name': 'Spotify',
      'category': 'Music',
      'price': 9.99,
      'image': '...url...',
      'badge': '20% Off',
    },
    {'name': 'Coursera', 'category': 'Education', 'price': 49.00, 'image': '...url...'},
    {
      'name': 'VS Code Pro',
      'category': 'Software',
      'price': 10.00,
      'image': '...url...',
      'badge': 'New',
    },
    {'name': 'Xbox Game Pass', 'category': 'Game', 'price': 14.99, 'image': '...url...'},
    {
      'name': 'Adobe Photoshop',
      'category': 'Software',
      'price': 20.99,
      'image': '...url...',
      'badge': '15% Off',
    },
  ];

  @override
  Widget build(BuildContext context) {
    //filter products based on selected category
    final filteredProducts = category == 'All'
        ? _allProducts
        : _allProducts.where((p) => p['category'] == category).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveBreakpoints.of(context).isMobile ? 2 : 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: filteredProducts[index]);
      },
    );
  }
}
