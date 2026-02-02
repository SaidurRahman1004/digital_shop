import 'package:digital_shop/widgets/offer_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../config/colors.dart';

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({super.key});

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  final _pageController = PageController();
  //Dumy Data to Shoe in Carousel
  final List<Map<String, String>> _offers = [
    {
      'title': 'Netflix Premium',
      'description': '50% Off for 1 Year Plan',
      'image': 'https://images.unsplash.com/photo-1611162617213-6d22e525735c?q=80&w=1974',
    },
    {
      'title': 'Spotify Family',
      'description': 'Get 3 Months Free',
      'image': 'https://images.unsplash.com/photo-1611339555312-e607c8352fd7?q=80&w=1974',
    },
    {
      'title': 'Adobe Creative Cloud',
      'description': 'Student Discount Available',
      'image': 'https://images.unsplash.com/photo-1626908924463-a335737db358?q=80&w=1974',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final double carouselHeight = isMobile ? 180.0 : 300.0;
    return Column(
      children: [
        SizedBox(
          height: carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _offers.length,
            itemBuilder: (_, index) {
              return OfferCard(data: _offers[index], onTap: () {});
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: _offers.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.primary,
            dotColor: AppColors.borderLight,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }
}
