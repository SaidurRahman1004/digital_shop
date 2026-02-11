import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/custom_text_field.dart';
import 'package:digital_shop/widgets/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/colors.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final TextEditingController _paymentIdController = .new();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? _foundOrder;
  bool _isLoading = false;
  bool _searched = false;

  //Dummy order data
  final Map<String, dynamic> _dummyOrder = {
    'orderId': 'ORD745812',
    'paymentId': 'PAY998123',
    'items': [
      {'name': 'Netflix Premium', 'price': 12.99},
    ],
    'totalAmount': 12.99,
    'status': 2, // 0: Created, 1: Paid, 2: Delivered
    'isCanceled': false,
  };

  //Order status Finding
  void _findOrder() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _searched = true;
        _foundOrder = null;
      });
      //Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      //simulate finding order by payment ID
      if (_paymentIdController.text.trim().toUpperCase() ==
              _dummyOrder['paymentId'] ||
          _paymentIdController.text.trim().toUpperCase() ==
              _dummyOrder['orderId']) {
        setState(() {
          _foundOrder = _dummyOrder;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      appBar: const AppbarCustomAll(
        title: "Order Tracking",
        showLogo: false,
        showDefaultActions: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isDesktop) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  //Mobile layout
  Widget _buildMobileLayout() {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              _buildSearchCard(),
              const SizedBox(height: 24),
              _buildResultContent(),
            ],
          ),
        ),
      ),
    );
  }

  //Desktop layout with two columns
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),

      child: Row(
        crossAxisAlignment: .start,

        children: [
          Expanded(
            flex: 2,

            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSearchCard(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 3,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildResultContent(),
            ),
          ),
        ],
      ),
    );
  }

  //dynamically Show Results
  Widget _buildResultContent() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (!_searched) {
      return _buildEmptyStateCard();
    }
    if (_foundOrder != null) {
      return _buildOrderStatusCard();
    } else {
      return _buildNotFoundCard();
    }
  }

  //// Card for searching order
  Widget _buildSearchCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Find Your Order",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your Payment ID or Order ID to see the delivery status of your product.",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textGrey),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _paymentIdController,
                labelText: 'Payment ID / Order ID',
                prefixIcon: Iconsax.receipt_search,
                hintText: 'e.g., ORD745812',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter an ID'
                    : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _findOrder,
                  icon: const Icon(Iconsax.search_normal_1),
                  label: const Text("Find Order"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card to show when an order is found
  Widget _buildOrderStatusCard() {
    final theme = Theme.of(context);
    return Card(
      key: const ValueKey('order_found'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "Order Status",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            OrderTracker(
              currentStep: _foundOrder!['status'],
              isCanceled: _foundOrder!['isCanceled'],
            ),
            const Divider(height: 24),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: const Text("Order ID"),
              trailing: Text(
                _foundOrder!['orderId'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(_foundOrder!['items'][0]['name']),
              trailing: Text(
                "\$${_foundOrder!['totalAmount']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card to show when no order is found
  Widget _buildNotFoundCard() {
    return Card(
      key: const ValueKey('order_not_found'),
      color: AppColors.error.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Iconsax.search_zoom_out,
              size: 50,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              "No Order Found",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "We couldn't find any order with that ID. Please check the ID and try again, or contact support for help.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // A default card to show instructions on the right side on desktop
  Widget _buildEmptyStateCard() {
    return Card(
      key: const ValueKey('empty_state'),
      color: Theme.of(context).primaryColor.withAlpha(10),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.search_status,
                size: 50,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                "Track Your Order",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter your order or payment ID in the form on the left to see your order status and product delivery details here.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
