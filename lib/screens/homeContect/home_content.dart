import 'package:digital_shop/widgets/category_selector.dart';
import 'package:digital_shop/widgets/offer_carousel.dart';
import 'package:digital_shop/widgets/product_grid.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = 'All';
  //For catagory Selection
  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //call all Home Custome Widget
          const SizedBox(height: 16),
          const OfferCarousel(),
          const SizedBox(height: 24),
          CategorySelector(onCategorySelected: _onCategorySelected),
          const SizedBox(height: 16),
          SectionHeader(title: 'Popular Products', onSeeAll: () {}),
          const SizedBox(height: 8),
          ProductGrid(category: selectedCategory),
        ],
      ),
    );
  }
}
