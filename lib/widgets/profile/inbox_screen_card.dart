import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/colors.dart';
import '../../models/message_model.dart';
import '../custo_snk.dart';

class MessageDeliveryCard extends StatelessWidget {
  final MessageModel message;

  const MessageDeliveryCard({super.key, required this.message});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    mySnkmsg("$label copied to clipboard!", context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('ORDER ID', style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textGrey)),
                    const SizedBox(height: 2),
                    Text(message.id, style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('DATE', style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textGrey)),
                    const SizedBox(height: 2),
                    Text(message.sentAt, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
