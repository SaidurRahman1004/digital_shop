import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_shop/config/colors.dart';
import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductCard({super.key, required this.product});

  Color _badgeColor(String badge) {
    final b = badge.toLowerCase();
    if (b.contains('new')) return AppColors.success;
    if (b.contains('popular')) return AppColors.primary;
    if (b.contains('%') || b.contains('off') || b.contains('sale')) return AppColors.warning;
    return AppColors.error;
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return AppColors.success;
      case 'on sale':
        return AppColors.primary;
      case 'coming soon':
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }

  bool _isAvailable(String status) {
    final s = status.toLowerCase();
    return !['sold out', 'stock out', 'coming soon'].contains(s);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String name = (product['name'] ?? '').toString();
    final String category = (product['category'] ?? '').toString();
    final double price = (product['price'] ?? 0.0) is num
        ? (product['price'] as num).toDouble()
        : 0.0;
    final String imageUrl = (product['image'] ?? '').toString();

    final String? badgeText = product['badge']?.toString();
    final String statusText = (product['status'] ?? 'Unavailable').toString();
    final bool available = _isAvailable(statusText);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final bool compact = w < 170;

        final double radius = compact ? 14 : 16;
        final EdgeInsets pad = EdgeInsets.all(compact ? 10 : 12);

        final TextStyle titleStyle =
            (compact ? theme.textTheme.titleSmall : theme.textTheme.titleMedium)?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.15,
            ) ??
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

        final TextStyle metaStyle =
            (compact ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium)?.copyWith(
              color: AppColors.textGrey,
              height: 1.1,
            ) ??
            const TextStyle(fontSize: 12);

        final TextStyle priceStyle =
            (compact ? theme.textTheme.titleSmall : theme.textTheme.titleMedium)?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ) ??
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w800);

        return Material(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(radius),
          elevation: 1.5,
          shadowColor: Colors.black.withAlpha(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: () {
              if (!available) {
                mySnkmsg('Product is $statusText', context, isError: true);
              } else {
                // TODO: Navigate to product details
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image
                      AspectRatio(
                        aspectRatio: compact ? 4 / 3 : 16 / 11,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            // subtle gradient to help chips
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.center,
                                    colors: [Colors.black.withAlpha(56), Colors.transparent],
                                  ),
                                ),
                              ),
                            ),
                            if (badgeText != null && badgeText.trim().isNotEmpty)
                              Positioned(
                                top: 10,
                                left: 10,
                                child: _ChipPill(
                                  text: badgeText,
                                  color: _badgeColor(badgeText),
                                  compact: compact,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: pad,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: titleStyle,
                                maxLines: compact ? 1 : 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category,
                                style: metaStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${price.toStringAsFixed(price % 1 == 0 ? 0 : 2)}',
                                      style: priceStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: _StatusPill(
                                        text: statusText,
                                        color: _statusColor(statusText),
                                        compact: compact,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Unavailable overlay
                  if (!available)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            color: Colors.black.withAlpha(51),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: compact ? 10 : 14,
                                vertical: compact ? 6 : 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(140),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                statusText,
                                style:
                                    (compact
                                            ? theme.textTheme.labelMedium
                                            : theme.textTheme.titleSmall)
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ) ??
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChipPill extends StatelessWidget {
  final String text;
  final Color color;
  final bool compact;
  const _ChipPill({required this.text, required this.color, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 10, vertical: compact ? 4 : 5),
      decoration: BoxDecoration(
        color: color.withAlpha(243),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(31), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Text(
        text,
        style:
            (compact
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.labelMedium)
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 0.2) ??
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  final bool compact;
  const _StatusPill({required this.text, required this.color, required this.compact});

  @override
  Widget build(BuildContext context) {
    final bg = color.withAlpha(36);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 10, vertical: compact ? 4 : 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(64)),
      ),
      child: Text(
        text,
        style:
            (compact
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.labelMedium)
                ?.copyWith(color: color, fontWeight: FontWeight.w700) ??
            TextStyle(color: color, fontWeight: FontWeight.w700),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
