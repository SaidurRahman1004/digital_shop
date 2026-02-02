import 'package:digital_shop/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  const CategorySelector({super.key, required this.onCategorySelected});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _selectedIndex = 0;

  // Dummy Data
  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Iconsax.category},
    {'name': 'Entertainment', 'icon': Iconsax.video_play},
    {'name': 'Game', 'icon': Iconsax.game},
    {'name': 'Music', 'icon': Iconsax.music},
    {'name': 'Software', 'icon': Iconsax.code},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, index) {
          final category = _categories[index];
          final isSelected = _selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onCategorySelected(category['name']);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.borderLight,
                      ),
                    ),
                    child: Icon(
                      category['icon'],
                      color: isSelected ? Colors.transparent : AppColors.borderLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
