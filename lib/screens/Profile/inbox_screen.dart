import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../models/message_model.dart';
import '../../widgets/profile/inbox_screen_card.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  //
  final List<MessageModel> _messages = [
    MessageModel(
      id: 'SB-9921',
      productName: 'Netflix Premium',
      validity: '1 Month (Ultra HD)',
      activationId: 'user.access@example.com',
      activationKey: 'X992-BB81-KDOP-PQ22',
      sentAt: '24 Oct 2023',
      adminMessage:
          'Please use a VPN if you are logging in from a restricted region. Contact support if the key shows "Already in Use".',
    ),
    MessageModel(
      id: 'SB-9915',
      productName: 'Spotify Family Plan',
      validity: '30 days',
      activationId: 'spotify.user@email.com',
      activationKey: 'KEY-P9Q0-R1S2-ABCD',
      sentAt: '22 Oct 2023',
    ),
    MessageModel(
      id: 'SB-9910',
      productName: 'Adobe Creative Cloud',
      validity: '1 Year Plan',
      activationId: 'adobe.creative@email.com',
      activationKey: 'ADBE-XYZ-7890-LMNO',
      sentAt: '20 Oct 2023',
      adminMessage:
          "Your license is activated. You can log in with this email.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustomAll(
        title: "My Inbox",
        showLogo: false,
        showDefaultActions: false,
      ),
      body: _messages.isEmpty
          ? _buildEmptyInbox()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  alignment: WrapAlignment.center,
                  children: _messages.map((message) {
                    return SizedBox(
                      width: 420,
                      child: MessageDeliveryCard(message: message),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }

  //Emty Messages
  Widget _buildEmptyInbox() {
    return Column(
      mainAxisAlignment: .center,
      children: [
        const Icon(Iconsax.direct_inbox, size: 80, color: Colors.grey),
        const SizedBox(height: 20),
        Text(
          'Your Inbox is Empty',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: .bold),
        ),
        const SizedBox(height: 12),
        Text(
          'No messages yet. All your notifications will appear here.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
