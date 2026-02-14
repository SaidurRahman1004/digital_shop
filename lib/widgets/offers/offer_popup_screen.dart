import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_shop/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
class OfferPopupScreen extends StatelessWidget {

  final Map<String, String> offerData = {
    'title': 'Exclusive Winter Sale!',
    'subtitle': 'Get up to 40% OFF on all gaming subscriptions.',
    'buttonText': 'Explore Offers',
    'imageUrl': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=2070',

  };

  OfferPopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    Widget content = isDesktop
        ? _buildDesktopContent(context, theme)
        : _buildMobileContent(context, theme);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isDesktop ? 700 : 380),
        child: content,
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button for mobile
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          _buildImageSection(isMobile: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
            child: _buildTextAndButtonSection(context, theme, isMobile: true),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context, ThemeData theme) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildImageSection(isMobile: false),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
                    child: _buildTextAndButtonSection(
                        context, theme, isMobile: false),
                  ),
                ),
              ],
            ),
            // Close button for desktop
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.textGrey),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // image
  Widget _buildImageSection({required bool isMobile}) {
    return ClipRRect(
      borderRadius: isMobile
          ? BorderRadius.zero
          : const BorderRadius.only(
          topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
      child: CachedNetworkImage(
        imageUrl: offerData['imageUrl']!,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(color: Colors.grey.shade200),
        errorWidget: (_, _, _) =>
            Container(
              color: Colors.grey.shade200,
              child: const Icon(Iconsax.gallery_slash),
            ),
      ),
    );
  }

  // Text Button
  Widget _buildTextAndButtonSection(BuildContext context, ThemeData theme,
      {required bool isMobile}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (isMobile) const Spacer(),
        Text(
          offerData['title']!,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          offerData['subtitle']!,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textGrey,
            height: 1.5,
          ),
        ),
        const Spacer(),
        const SizedBox(height: 24),
        SizedBox(
          width: isMobile ? double.infinity : 220,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              offerData['buttonText']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}