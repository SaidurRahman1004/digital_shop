import 'package:flutter/material.dart';

class OrderTracker extends StatelessWidget {
  final int currentStep; // 0 Created, 1 Paid, 2 Delivered
  final bool isCanceled;

  const OrderTracker({
    super.key,
    required this.currentStep,
    this.isCanceled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrackStep(
          context,
          "Order Created",
          "Your order has been created",
          false,
          true,
        ),
        _buildLine(currentStep >= 1),
        _buildTrackStep(
          context,
          isCanceled ? "Payment Failed" : "Payment Accepted",
          isCanceled
              ? "Contact support for info"
              : "Admin is verifying payment",
          false,
          currentStep >= 1,
          isError: isCanceled,
        ),
        _buildLine(currentStep >= 2),
        _buildTrackStep(
          context,
          "Product Delivered",
          "Check your Massege Section \non Profile and Cheak WhatsApp/Email",
          true,
          currentStep >= 2,
        ),
      ],
    );
  }

  Widget _buildTrackStep(
    BuildContext context,
    String title,
    String sub,
    bool isLast,
    bool isDone, {
    bool isError = false,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isDone
              ? Colors.green
              : isError
              ? Colors.red
              : Colors.grey,
          child: Icon(
            isDone
                ? Icons.check
                : isError
                ? Icons.close
                : Icons.circle,
            size: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Text(sub,overflow: TextOverflow.ellipsis,textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Widget _buildLine(bool isDone) {
    return Container(
      margin: const EdgeInsets.only(left: 11),
      height: 30,
      width: 2,
      color: isDone ? Colors.green : Colors.grey.shade300,
    );
  }
}
