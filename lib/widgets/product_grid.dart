import 'package:digital_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProductGrid extends StatelessWidget {
  final String category;
  const ProductGrid({super.key, required this.category});

  // Dummy Data
  final List<Map<String, dynamic>> _allProducts = const [
    {
      'name': 'Netflix Premium',
      'category': 'Entertainment',
      'price': 12.99,
      'image': 'https://images.unsplash.com/photo-1616469829935-c2f334624b38?q=80&w=1974',
      'badge': 'Popular',
      'status': 'On Sale',
    },
    {
      'name': 'Spotify Family',
      'category': 'Music',
      'price': 9.99,
      'image': 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
      'badge': '20% Off',
      'status': 'In Stock',
    },
    {
      'name': 'Coursera Plus',
      'category': 'Education',
      'price': 49.00,
      'image': 'https://images.unsplash.com/photo-1501504905252-473c47e087f8?q=80&w=1974',
      'status': 'Sold Out',
    },
    {
      'name': 'VS Code Pro',
      'category': 'Software',
      'price': 10.00,
      'image': 'https://images.unsplash.com/photo-1607706189992-eae57192d32d?q=80&w=1974',
      'badge': 'New',
      'status': 'In Stock',
    },
    {
      'name': 'Xbox Game Pass',
      'category': 'Game',
      'price': 14.99,
      'image': 'https://images.unsplash.com/photo-1580327344181-c1163234e5a0?q=80&w=1974',
      'status': 'Coming Soon',
    },
    {
      'name': 'Adobe Photoshop',
      'category': 'Software',
      'price': 20.99,
      'image': 'https://images.unsplash.com/photo-1558153493-a232a03dccc7?q=80&w=1974',
      'badge': '15% Off',
      'status': 'Stock Out',
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
