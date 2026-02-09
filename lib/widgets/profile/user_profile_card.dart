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
    return Container(
      padding: const EdgeInsets.only(
        top: 60.0,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withAlpha(
              (imageUrl != null && imageUrl!.isNotEmpty) ? 0 : 255,
            ),
            backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                ? CachedNetworkImageProvider(imageUrl!)
                : null,
            child: (imageUrl == null || imageUrl!.isEmpty)
                ? const Icon(Iconsax.user, size: 40, color: AppColors.primary)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (phone != null && phone!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    phone!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(150),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
