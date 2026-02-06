import 'package:digital_shop/screens/home_screen.dart';
import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/order_tracker.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSuccessSummary extends StatelessWidget {
  final String orderId;
  final String paymentId;
  final List<Map<String, dynamic>> items;
  final double totalAmount;

  const PaymentSuccessSummary({
    super.key,
    required this.orderId,
    required this.paymentId,
    required this.items,
    required this.totalAmount,
  });

  // WhatsAppSocial Integration Logic
  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const AppbarCustomAll(
        title: "Order Summary",
        showLogo: false,
        showDefaultActions: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                const Icon(Iconsax.tick_circle5, size: 80, color: Colors.green),
                const SizedBox(height: 16),
                const Text(
                  "Payment Submitted!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    "Payment ID: $paymentId",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Text(
                  "Please save this Payment ID for future reference",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),

                const SizedBox(height: 32),
                // Order Tracking
                const SectionHeader(title: "Delivery Status"),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OrderTracker(
                      currentStep: 1,
                    ), // Step 1 means Paid/Pending Admin verification
                  ),
                ),
                const SizedBox(height: 24),
                //order Details
                const SectionHeader(title: "Order Details"),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Order ID"),
                        trailing: Text(
                          orderId,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...items.map(
                            (item) =>
                            ListTile(
                              title: Text(item['name']),
                              subtitle: Text("Validity: ${item['validity']}"),
                              trailing: Text("৳${item['price']}"),
                            ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          "Total Paid",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          "৳$totalAmount",
                          style: TextStyle(
                            fontSize: 18,
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                //note Card
                _buildNotesCard(theme),
                const SizedBox(height: 32),
                //  sontact & support section
                const SectionHeader(title: "If Any Need Help? Contact Us"),
                Row(
                  children: [
                    Expanded(
                      child: _buildContactButton(
                          "WhatsApp",
                          Iconsax.call,
                          Colors.green,
                              () =>
                              _launchURL(
                                  "https://wa.me/88017XXXXXXXX?text=OrderID:$orderId\nPaymentID:$paymentId")
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildContactButton(
                          "Facebook",
                          Iconsax.message,
                          Colors.blue,
                              () => _launchURL("https://m.me/yourpage")
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Go Home Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false),
                    child: const Text("Go to Home"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //NotesdCard
  Widget _buildNotesCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.info_circle, size: 20, color: Colors.amber),
              SizedBox(width: 8),
              Text("Note:", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Your order request has been sent. Please wait for admin review. Once delivered, you will receive the product details via WhatsApp, Email, and the Message icon on your Profile/Home screen.",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  //Buttons Custom
  Widget _buildContactButton(String label,
      IconData icon,
      Color color,
      VoidCallback onTap,) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
