import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 100);
  String? _selectedCategory;
  String? _selectedStatus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.titleLarge),
              TextButton(onPressed: () {}, child: const Text('Reset')),
            ],
          ),
          const Divider(height: 30),
          //price Range
          Text('Price Range', style: Theme.of(context).textTheme.titleMedium),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 500,
            divisions: 100,
            labels: RangeLabels('\$${_priceRange.start.round()}', '\$${_priceRange.end.round()}'),
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          // Category
          Text('Category', style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: 8.0,
            children: ['Entertainment', 'Music', 'Game', 'Software']
                .map(
                  (cat) => ChoiceChip(
                    label: Text(cat),
                    selected: _selectedCategory == cat,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = selected ? cat : null);
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          //status
          Text('Status', style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: 8.0,
            children: ['In Stock', 'On Sale', 'Sold Out', 'Coming Soon']
                .map(
                  (status) => ChoiceChip(
                    label: Text(status),
                    selected: _selectedStatus == status,
                    onSelected: (selected) {
                      setState(() => _selectedStatus = selected ? status : null);
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 30),
          // Apply Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Implement apply filter logic here
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
