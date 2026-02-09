import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile/user_profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustomAll(
        title: "Profile",
        showLogo: false,
        showDefaultActions: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            UserProfileCard(
              name: 'Siyam',
              email: 'Siyam@gmail.con',
              imageUrl:
                  'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
              phone: '+88012348887',
            ),
          ],
        ),
      ),
    );
  }
}
