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
            _buildHeader(theme),
            const SizedBox(height: 16),
            _buildProductInfo(theme),
            const SizedBox(height: 24),
            //info cards
            _buildInfoCard(
              context,
              theme,
              label: 'ACTIVATION ID',
              value: message.activationKey,
              onCopy: () => _copyToClipboard(
                context,
                message.activationId,
                'Activation ID',
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              theme,
              label: 'ACTIVATION KEY',
              value: message.activationKey,
              onCopy: () => _copyToClipboard(
                context,
                message.activationKey,
                'Activation Key',
              ),
            ),
            if(message.adminMessage.isNotEmpty)...[
              const Spacer(),
              const SizedBox(height: 20,),
              _buildAdminNote(theme),
            ]
          ],
        ),
      ),
    );
  }

  //header with order id and date

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'ORDER ID',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              message.id,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'DATE',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 2),
            Text(message.sentAt, style: theme.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  //product info
  Widget _buildProductInfo(ThemeData theme) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                message.productName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),
              Text(
                'Validity: ${message.validity}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.success.withAlpha(20),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            'Delivered',
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  //Info Card with copy button for activation id and key
  Widget _buildInfoCard(
    BuildContext context,
    ThemeData theme, {
    required String label,
    required String value,
    required VoidCallback onCopy,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCopy,
            icon: Icon(Icons.copy, color: theme.colorScheme.primary, size: 20),
            tooltip: 'Copy $label',
          ),
        ],
      ),
    );
  }
  //aDMIN mESSAGE can be added as a section at the bottom if needed, but for now we will keep it simple with just the activation details.
  Widget _buildAdminNote(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(20),
        border: const Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          const Icon(Icons.info_outline, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Admin Message',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.adminMessage,
                style: theme.textTheme.bodyMedium,
              )
            ],
          ))
        ],
      ),
    );
  }
}
