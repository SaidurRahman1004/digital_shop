import 'package:digital_shop/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShopSearchFilterBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  const ShopSearchFilterBar({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).focusColor,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Iconsax.search_normal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Filter Button
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(12),
              ),
              onPressed: onFilterTap,
              icon: const Icon(Iconsax.filter, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
