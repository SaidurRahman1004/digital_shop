import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppbarCustomAll extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final List<Widget>? actions;
  final bool showDefaultActions;


  const AppbarCustomAll({
    super.key,
    this.title,
    this.showLogo = true,
    this.actions,
    this.showDefaultActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      leadingWidth: showLogo ? 150 : null,
      leading: showLogo
          ? Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset('assets/images/appLogo.png', width: 32, height: 32),
      )
          : null,

      title: title != null
          ? Text(
        title!,
        style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold),
      )
          : const Text(
        'SubscriptionBD',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      actions: actions ?? (showDefaultActions ? [
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
      ] : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}