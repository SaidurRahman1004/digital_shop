import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/colors.dart';
import '../custo_snk.dart';

/// Shows a modal bottom sheet on mobile and a dialog on desktop.
void showSupportContact(BuildContext context) {
  final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
  if (isDesktop) {
    showDialog(
      context: context,
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(width: 450, child: SupportContactBottomSheet()),
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SupportContactBottomSheet(),
    );
  }
}

class SupportContactBottomSheet extends StatelessWidget {
  const SupportContactBottomSheet({super.key});

  // launch URLs
  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        if (context.mounted)
          mySnkmsg('Could not launch URL', context, isError: true);
      }
    } catch (e) {
      if (context.mounted)
        mySnkmsg('An error occurred: $e', context, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final theme = Theme.of(context);
    final borderRadius = isDesktop
        ? BorderRadius.circular(24)
        : const BorderRadius.vertical(top: Radius.circular(24));

    return Container(
      margin: isDesktop ? EdgeInsets.zero : const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          //darg handle
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          // Header
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Support Center",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.success,
                        radius: 4.5,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Admin Online",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              //close button
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(99),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade100,
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionIcon(
                context,
                icon: Iconsax.message,
                label: "WHATSAPP",
                onTap: () => _launchURL(context, "https://wa.me/8801700000000"),
              ),
              _buildActionIcon(
                context,
                icon: Iconsax.send_2,
                label: "MESSENGER",
                onTap: () => _launchURL(context, "https://m.me/yourpage"),
              ),
              _buildActionIcon(
                context,
                icon: Iconsax.call,
                label: "CALL US",
                onTap: () => _launchURL(context, "tel:+8801700000000"),
              ),
              _buildActionIcon(
                context,
                icon: Iconsax.direct,
                label: "EMAIL",
                onTap: () => _launchURL(context, "mailto:support@example.com"),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.clock, size: 16, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  "Typical response time: < 5 mins",
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Button Design
  Widget _buildActionIcon(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary,
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
