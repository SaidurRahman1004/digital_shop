import 'package:digital_shop/screens/Profile/wish_list_screen.dart';
import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/profile/profile_action_card.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../config/colors.dart';
import '../../widgets/profile/user_profile_card.dart';
import 'account_details_screen.dart';
import 'contact_section_admin.dart';
import 'order_tracking_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //logout
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      appBar: AppbarCustomAll(
        title: "Profile",
        showLogo: false,
        showDefaultActions: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (isDesktop) {
            return _buildDesktopLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfileCard(
            name: 'Siyam',
            email: 'Siyam@gmail.con',
            imageUrl:
                'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
            phone: '+88012348887',
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SectionHeader(title: 'Account Management', onSeeAll: null),
          ),
          const SizedBox(height: 8.0),
          _buildActionMenuList(),
        ],
      ),
    );
  }

  // For desktop, we can use a two-column layout
  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 2,
            child: Column(
              children: [
                UserProfileCard(
                  name: 'Tushar Biswas', // Dummy Data
                  email: 'tushar.biswas@example.com', // Dummy Data
                  imageUrl:
                      'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1974',
                  phone: '+880123456789',
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right Column
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Account Management', onSeeAll: null),
                  const SizedBox(height: 16),
                  _buildActionMenuList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionMenuList() {
    return Column(
      children: [
        ProfileActionMenuCard(
          icon: Iconsax.user_edit,
          title: 'Account Details',
          subtitle: 'Update your profile information',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountDetailsScreen()));
          },
        ),
        ProfileActionMenuCard(
          icon: Iconsax.message_text,
          title: 'My Messages',
          subtitle: 'View notifications and product updates',
          onTap: () {},
        ),
        ProfileActionMenuCard(
          icon: Iconsax.box_1,
          title: 'My Orders',
          subtitle: 'Track your recent orders',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));

          },
        ),
        ProfileActionMenuCard(
          icon: Iconsax.heart,
          title: 'Wishlist',
          subtitle: 'View your saved products',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen()));
          },
        ),
        ProfileActionMenuCard(
          icon: Iconsax.support,
          title: 'Contact Support',
          subtitle: 'Get help and support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppbarCustomAll(title: "Contact Us"),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AdminContactSection(),
                  ),
                ),
              ),
            );
          },
        ),
        ProfileActionMenuCard(
          icon: Iconsax.logout_1,
          title: 'Log Out',
          onTap: _showLogoutDialog,
          isDestructive: true,
        ),
      ],
    );
  }
}

//Single Column Layout for Desktop
