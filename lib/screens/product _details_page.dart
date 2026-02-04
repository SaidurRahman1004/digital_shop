import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_shop/config/colors.dart';
import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:digital_shop/widgets/product_card.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> allProducts;
  const ProductDetailsScreen({super.key, required this.product, required this.allProducts});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isFavorite = false;

  //incriment
  void _incriment() {
    setState(() {
      quantity++;
    });
  }

  //decriment
  void _decriment() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  //toggle favorite
  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    mySnkmsg(isFavorite ? 'Added to wishlist' : 'Removed from wishlist', context);
  }

  //add to cart
  void _addToCart() {
    mySnkmsg('Added to cart', context);
  }

  //bye now
  void _buyNow() {
    mySnkmsg('Proceeding to buy', context);
  }
  //buy via whatsapp

  Future<void> _buyViaWhatsApp() async {
    final String name = widget.product['name'] ?? '';
    final double price = (widget.product['price'] ?? 0.0) is num
        ? (widget.product['price'] as num).toDouble()
        : 0.0;
    final String validity = widget.product['validity'] ?? 'N/A';
    final String message =
        '''
Hello, I want to buy:
** Product: $name
** Price: \$$price
** Validity: $validity
** Quantity: $quantity

Total: \$${(price * quantity).toStringAsFixed(2)}
''';
    final String phoneNumber = '1234567890';
    final Uri whatsappUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          mySnkmsg('Could not open WhatsApp', context, isError: true);
        }
      }
      mySnkmsg('Opening WhatsApp...', context);
    } catch (e) {
      mySnkmsg('Could not open WhatsApp $e', context, isError: true);
    }
  }

  //get Releted Products
  List<Map<String, dynamic>> _getRelatedProducts() {
    final String category = widget.product['category'] ?? '';
    return widget.allProducts
        .where((p) => p['category'] == category && p['name'] != widget.product['name'])
        .take(4)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bp = ResponsiveBreakpoints.of(context);
    final bool isDesktop = bp.largerThan(TABLET);

    final String name = widget.product['name'] ?? '';
    final String category = widget.product['category'] ?? '';
    final String imageUrl = widget.product['image'] ?? '';
    final String description =
        widget.product['description'] ??
        'This is a premium digital product with excellent features and benefits. Get instant access after purchase.';
    final double price = (widget.product['price'] ?? 0.0) is num
        ? (widget.product['price'] as num).toDouble()
        : 0.0;
    final String validity = widget.product['validity'] ?? 'Lifetime';
    return Scaffold(
      appBar: AppbarCustomAll(
        title: name,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.share),
            onPressed: () {
              mySnkmsg('Share functionality coming soon', context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isDesktop
                ? _buildDesktopLayout(theme, imageUrl, name, category, price, validity, description)
                : _buildMobileLayout(theme, imageUrl, name, category, price, validity, description),
            const SizedBox(height: 32),
            //Releted Product List
            if (_getRelatedProducts().isNotEmpty) ...[
              SectionHeader(
                title: 'Related Products $category',
                onSeeAll: () {
                  mySnkmsg('See all related products coming soon', context);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _getRelatedProducts().length,
                  itemBuilder: (_, index) {
                    return SizedBox(
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(product: _getRelatedProducts()[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  //Mobile Layout
  Widget _buildMobileLayout(
    ThemeData theme,
    String imageUrl,
    String name,
    String category,
    double price,
    String validity,
    String description,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //image
        AspectRatio(
          aspectRatio: 1.2,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: Colors.grey.shade200),
            errorWidget: (_, __, ___) =>
                Container(color: Colors.grey.shade200, child: const Icon(Icons.error, size: 60)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      color: isFavorite ? Colors.red : theme.iconTheme.color,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              //Catagory
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //price and validity
              Row(
                children: [
                  Text(
                    '\$$price',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.success.withAlpha(25),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.success.withAlpha(75)),
                    ),
                    child: Text(
                      '⏳ $validity',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Quantity:',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 16),
                  _buildQuantitySelector(theme),
                ],
              ),
              const SizedBox(height: 24),

              // Description
              Text(
                'Description',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textGrey, height: 1.6),
              ),

              const SizedBox(height: 32),
              //Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addToCart,
                      icon: const Icon(Iconsax.shopping_cart),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _buyNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Buy Now'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // WhatsApp Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _buyViaWhatsApp,
                  icon: const Icon(Iconsax.message),
                  label: const Text('Buy via WhatsApp'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Desktop Layout
  Widget _buildDesktopLayout(
    ThemeData theme,
    String imageUrl,
    String name,
    String category,
    double price,
    String validity,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image Left
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey.shade200),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.error, size: 80),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              //Details Right'
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Wishlist
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Iconsax.heart5 : Iconsax.heart,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Price + Validity
                    Row(
                      children: [
                        Text(
                          '\$$price',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.success.withAlpha(25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.success.withAlpha(75)),
                          ),
                          child: Text(
                            '⏳ $validity',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Quantity
                    Row(
                      children: [
                        Text(
                          'Quantity:',
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 20),
                        _buildQuantitySelector(theme),
                      ],
                    ),

                    const SizedBox(height: 32),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _addToCart,
                            icon: const Icon(Iconsax.shopping_cart),
                            label: const Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              side: BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _buyNow,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Buy Now'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _buyViaWhatsApp,
                        icon: const Icon(Iconsax.message),
                        label: const Text('Buy via WhatsApp'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Description Section (Full Width)
          Text(
            'Description',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textGrey, height: 1.7),
          ),
        ],
      ),
    );
  }

  // Quantity Selector Widget
  Widget _buildQuantitySelector(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.remove), onPressed: _decriment),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$quantity',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(onPressed: _incriment, icon: const Icon(Icons.add), color: AppColors.primary),
        ],
      ),
    );
  }
}
