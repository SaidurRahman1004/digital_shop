import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/colors.dart';
import '../../widgets/AppbarCustom.dart';
import '../../widgets/custo_snk.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/section_header.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user data
  final _nameController = TextEditingController(text: "Saidur Rahman"); // Dummy
  final _phoneController = TextEditingController(
    text: "+8801700000000",
  ); // Dummy
  final _whatsappController = TextEditingController(); // Optional
  final _facebookController = TextEditingController(); // Optional

  // Controllers for password change
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      mySnkmsg("Profile updated successfully!", context);
    }
  }

  void _changePassword() {
    mySnkmsg("Password changed successfully!", context);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Scaffold(
      appBar: const AppbarCustomAll(
        title: "Account Details",
        showLogo: false,
        showDefaultActions: false,
      ),
      body: SingleChildScrollView(
        padding: isDesktop
            ? const EdgeInsets.symmetric(vertical: 24, horizontal: 48)
            : const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: isDesktop ? _builsDesktopLayout() : _buildMobileLayout(),
        ),
      ),
    );
  }

  //Mobile layout
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildProfileInfoCard(),
        const SizedBox(height: 24),
        _buildPasswordCard(),
      ],
    );
  }

  //Desktop layout with two columns
  Widget _builsDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildProfileInfoCard()),
        const SizedBox(width: 24),
        Expanded(flex: 2, child: _buildPasswordCard()),
      ],
    );
  }

  // card for profile information
  Widget _buildProfileInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Personal Information',
              onSeeAll: null,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            // Email (read-only)
            TextFormField(
              initialValue: 'saidur@gmail.com', // Dummy
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: const Icon(Iconsax.direct_right),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // User Name
            CustomTextField(
              controller: _nameController,
              labelText: 'Full Name',
              prefixIcon: Iconsax.user,
              validator: (v) => v!.isEmpty ? 'Name cannot be empty' : null,
            ),
            const SizedBox(height: 16),
            // Phone Number
            CustomTextField(
              controller: _phoneController,
              labelText: 'Phone Number',
              prefixIcon: Iconsax.call,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            // Optional Fields
            CustomTextField(
              controller: _whatsappController,
              labelText: 'WhatsApp Number (Optional)',
              prefixIcon: Iconsax.message,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _facebookController,
              labelText: 'Facebook Profile URL (Optional)',
              prefixIcon: Iconsax.link,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Iconsax.document_upload),
                label: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  card for changing password
  Widget _buildPasswordCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Change Password',
              onSeeAll: null,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _currentPasswordController,
              labelText: 'Current Password',
              prefixIcon: Iconsax.lock_1,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _newPasswordController,
              labelText: 'New Password',
              prefixIcon: Iconsax.lock,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _confirmPasswordController,
              labelText: 'Confirm New Password',
              prefixIcon: Iconsax.lock,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Update Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
