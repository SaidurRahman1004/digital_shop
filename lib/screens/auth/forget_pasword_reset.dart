import 'package:digital_shop/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/app_logo.dart';

class ForgetPasswordReset extends StatefulWidget {
  const ForgetPasswordReset({super.key});

  @override
  State<ForgetPasswordReset> createState() => _ForgetPasswordResetState();
}

class _ForgetPasswordResetState extends State<ForgetPasswordReset> {
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Password")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(width: 120, height: 120),
                const SizedBox(height: 20),
                const Text("Set your new password to login."),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _passController,
                  labelText: "New Password",
                  prefixIcon: Iconsax.lock,
                  obscureText: _isObscure,
                  suffixIcon: _isObscure ? Iconsax.eye : Iconsax.eye_slash,
                  onSuffixIconPressed: () =>
                      setState(() => _isObscure = !_isObscure),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPassController,
                  labelText: "Confirm Password",
                  prefixIcon: Iconsax.lock_1,
                  obscureText: _isObscure,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text("Reset Password"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}