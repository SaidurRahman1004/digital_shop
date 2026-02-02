import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            Image.asset('assets/images/appLogo.png', width: 32, height: 32),
            const SizedBox(width: 8),
            Text(
              'SubscriptionBD',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.search_normal_1),
          color: theme.colorScheme.onSurface,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification),
          color: theme.colorScheme.onSurface,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
