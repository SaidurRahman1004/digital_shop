import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final Map<String, String> data;
  final VoidCallback onTap;
  const OfferCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(data['image']!), fit: BoxFit.cover),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withAlpha(180),
                  Colors.black.withAlpha(50),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data['description']!,
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 14,
                    shadows: const [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
