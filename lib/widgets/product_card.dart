import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_shop/config/colors.dart';
import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product; //product data ,when creating pass map data
  const ProductCard({super.key, required this.product});
  //helper colour For badge color
  Color getBadgeColor(String badge) {
    switch (badge.toLowerCase()) {
      case 'popular':
        return AppColors.primary;
      case 'new':
        return AppColors.success;
      case 'unavailable':
        return AppColors.textGrey;
      default:
        return AppColors.error;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return AppColors.success;
      case 'on sale':
        return AppColors.primary;
      case 'coming soon':
        return AppColors.warning;
      case 'sold out':
      case 'stock out':
        return AppColors.error;
      default:
        return AppColors.textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String? badgeText = product['badge'];
    final String statusText = product['status'] ?? 'Unavailable';
    final bool isAvilabele = ![
      'sold out',
      'stock out',
      'coming soon',
    ].contains(statusText.toLowerCase());
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (isAvilabele) {
                // Navigate to product details or perform desired action
              } else {
                //Reuse
                mySnkmsg('Product is $statusText', context, isError: true);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: CachedNetworkImage(
                          imageUrl: product['image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      //badge optional
                      if (badgeText != null && badgeText.isNotEmpty)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: getBadgeColor(badgeText),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              badgeText,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['category'],
                        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textGrey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product['price']}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Optional validity
                          if (product['validity'] != null)
                            Text('/${product['validity']}', style: theme.textTheme.bodySmall),

                          //status Lable
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: getStatusColor(statusText).withAlpha(25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              statusText,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: getStatusColor(statusText),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Overlay for unavailable products
          if (!isAvilabele) ...[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: Colors.white.withAlpha(77),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(153),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
