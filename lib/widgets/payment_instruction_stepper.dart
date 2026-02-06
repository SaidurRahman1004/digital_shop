import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class PaymentInstructionStepper extends StatelessWidget {
  final String amount;
  final String adminNumber;
  final String orderId;

  const PaymentInstructionStepper({
    super.key,
    required this.amount,
    required this.adminNumber,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
      _buildStep(
        context,
        icon: Iconsax.mobile,
        title: "Open your Banking App",
        subtitle: "Select 'Send Money' or 'Transfer'",
        isLast: false,
      ),
      _buildStep(
        context,
        icon: Iconsax.money_send,
        title: "Send ৳$amount to Number",
        subtitle: adminNumber,
        isLast: false,
        isCopyable: true,
      ),
      _buildStep(
        context,
        icon: Iconsax.edit,
        title: "Use Order ID as Reference",
        subtitle: "Reference: $orderId",
        isLast: false,
        isCopyable: true,
      ),
      _buildStep(
        context,
        icon: Iconsax.receipt_21,
        title: "Submit Transaction ID",
        subtitle: "Copy the TxID from the confirmation SMS/App",
        isLast: true,
      ),
    ]);
  }

  Widget _buildStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isLast,
    bool isCopyable = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            if (!isLast) ...[
              Container(
                width: 2,
                height: 40,
                color: Theme.of(context).primaryColor.withAlpha(100),
              ),
            ],
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(child: Text(subtitle)),
                  if (isCopyable)
                    IconButton(
                      onPressed: () {
                        //copy to clipboard
                        Clipboard.setData(ClipboardData(text: subtitle));
                        mySnkmsg("Copied to clipboard!", context);
                      },
                      icon: const Icon(Iconsax.copy, size: 16),
                    ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
