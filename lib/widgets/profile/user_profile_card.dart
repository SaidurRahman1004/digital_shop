import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../config/colors.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String? phone;
  final String? imageUrl;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.phone,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Profile image
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary.withAlpha(20),
                  backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? CachedNetworkImageProvider(imageUrl!)
                      : null,
                  child: (imageUrl == null || imageUrl!.isEmpty)
                      ? const Icon(
                      Iconsax.user, size: 35, color: AppColors.primary)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.cardColor, width: 2),
                    ),
                    child: const Icon(
                        Iconsax.verify, color: Colors.white, size: 12),
                  ),
                )
              ],
            ),
            const SizedBox(width: 16),
            // User Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Iconsax.direct_right, size: 14,
                          color: AppColors.textGrey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (phone != null && phone!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                            Iconsax.call, size: 14, color: AppColors.textGrey),
                        const SizedBox(width: 6),
                        Text(
                          phone!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}