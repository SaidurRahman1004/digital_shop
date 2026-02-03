import 'package:digital_shop/widgets/filter_bottom_sheet.dart';
import 'package:digital_shop/widgets/product_grid.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:digital_shop/widgets/shop_search_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  void _showFilterBottomSheet(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const FilterBottomSheet(),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => Dialog(child: SizedBox(width: 400, child: const FilterBottomSheet())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: const Text('Shop'), centerTitle: true, floating: true, snap: true),
          //Serch Feild sticky
          SliverPersistentHeader(
            delegate: _SliverHeaderDelegate(
              child: ShopSearchFilterBar(onFilterTap: () => _showFilterBottomSheet(context)),
            ),
            pinned: true,
          ),
          //Product Grid
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 24),
                SectionHeader(title: 'All Products'),
                const SizedBox(height: 8),
                const ProductGrid(category: 'All'),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _SliverHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: maxExtent, child: child);
  }

  @override
  double get maxExtent => 68.0;

  @override
  double get minExtent => 68.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
