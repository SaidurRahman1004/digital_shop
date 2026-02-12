import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../screens/auth/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset('assets/images/appLogo.png', width: 32, height: 32),
      ),
      title: Text(
        'SubscriptionBD',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
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
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
          label: Text('Login'),
          icon: Icon(Iconsax.login),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
