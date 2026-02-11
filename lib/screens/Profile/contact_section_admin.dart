import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/colors.dart';
import '../../widgets/custo_snk.dart';

class AdminContactSection extends StatefulWidget {
  const AdminContactSection({super.key});

  @override
  State<AdminContactSection> createState() => _AdminContactSectionState();
}

class _AdminContactSectionState extends State<AdminContactSection> {
  //launch URLs
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
    //Dummy list
    final List<Map<String, dynamic>> contactItems = [
      {
        'icon': Iconsax.message,
        'title': "WhatsApp",
        'subtitle': "Instant Chat",
        'color': const Color(0xFF25D366),
        'onTap': () => _launchURL(context, "https://wa.me/8801700000000"),
      },
      {
        'icon': Iconsax.send_2,
        'title': "Messenger",
        'subtitle': "Social Support",
        'color': const Color(0xFF1877F2),
        'onTap': () => _launchURL(context, "https://m.me/yourpage"),
      },
      {
        'icon': Iconsax.call,
        'title': "Phone Call",
        'subtitle': "10AM - 10PM",
        'color': AppColors.primary,
        'onTap': () => _launchURL(context, "tel:+8801700000000"),
      },
      {
        'icon': Iconsax.direct_inbox,
        'title': "Email Ticket",
        'subtitle': "24h Response",
        'color': const Color(0xFFFDBC40),
        'onTap': () => _launchURL(context, "mailto:support@example.com"),
      },
    ];

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Direct Support",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.success.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.success,
                    radius: 4,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Agents Online",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppColors.success),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: contactItems.length,
          itemBuilder: (_, index) {
            final item = contactItems[index];
            return _buildContactGridItem(
              context,
              icon: item['icon'],
              title: item['title'],
              subtitle: item['subtitle'],
              color: item['color'],
              onTap: item['onTap'],
            );
          },
        ),
      ],
    );
  }

  //GridCard
  Widget _buildContactGridItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.5,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
