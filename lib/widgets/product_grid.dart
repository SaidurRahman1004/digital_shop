import 'package:digital_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProductGrid extends StatelessWidget {
  final String category;
  const ProductGrid({super.key, required this.category});

  final List<Map<String, dynamic>> _allProducts = const [
    {
      'name': 'Netflix Premium',
      'category': 'Entertainment',
      'price': 12.99,
      'image': 'https://images.unsplash.com/photo-1616469829935-c2f334624b38?q=80&w=1974',
      'badge': 'Popular',
      'status': 'On Sale',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
    {
      'name': 'Spotify Family',
      'category': 'Music',
      'price': 9.99,
      'image': 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
      'badge': '20% Off',
      'status': 'In Stock',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
    {
      'name': 'Coursera Plus',
      'category': 'Education',
      'price': 49.00,
      'image': 'https://images.unsplash.com/photo-1501504905252-473c47e087f8?q=80&w=1974',
      'status': 'Sold Out',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
    {
      'name': 'VS Code Pro',
      'category': 'Software',
      'price': 10.00,
      'image': 'https://images.unsplash.com/photo-1607706189992-eae57192d32d?q=80&w=1974',
      'badge': 'New',
      'status': 'In Stock',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
    {
      'name': 'Xbox Game Pass',
      'category': 'Game',
      'price': 14.99,
      'image': 'https://images.unsplash.com/photo-1580327344181-c1163234e5a0?q=80&w=1974',
      'status': 'Coming Soon',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
    {
      'name': 'Adobe Photoshop',
      'category': 'Software',
      'price': 20.99,
      'image': 'https://images.unsplash.com/photo-1558153493-a232a03dccc7?q=80&w=1974',
      'badge': '15% Off',
      'status': 'Stock Out',
      'validity': '1 Month',
      'description':
          'Enjoy ad-free music for up to 6 family members living under one roof with Spotify Family plan.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);

    final bool isMobile = bp.isMobile;
    final bool isTablet = bp.isTablet;

    final double maxTileWidth = isMobile
        ? 190
        : (isTablet ? 240 : 310); // desktop tiles look better

    final double childAspectRatio = isMobile ? 0.74 : (isTablet ? 0.82 : 0.95);

    final filteredProducts = category == 'All'
        ? _allProducts
        : _allProducts.where((p) => p['category'] == category).toList();

    if (filteredProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text('No products found', style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxTileWidth,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: filteredProducts[index]);
      },
    );
  }
}
