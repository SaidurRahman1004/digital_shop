import 'package:digital_shop/widgets/custo_snk.dart';
import 'package:digital_shop/widgets/custom_text_field.dart';
import 'package:digital_shop/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/app_logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Sign Up Logic
  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // temp simulate
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        mySnkmsg("Registration Successful!", context);
        //navigate back to login
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const AppLogo(width: 120, height: 120),
                    const SizedBox(height: 20),
                    Text(
                      "Create Account",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Join Subscriptions BD marketplace and manage all your digital subscriptions in one place",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      labelText: "Full Name",
                      prefixIcon: Iconsax.user,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter your name"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      labelText: "Email Address",
                      prefixIcon: Iconsax.direct_right,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Enter email";
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
                          return "Enter a valid email";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      prefixIcon: Iconsax.lock,
                      obscureText: _obscurePassword,
                      suffixIcon: _obscurePassword
                          ? Iconsax.eye
                          : Iconsax.eye_slash,
                      onSuffixIconPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: (value) => (value != null && value.length < 6)
                          ? "Minimum 6 characters required"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    CustomTextField(
                      controller: _phoneController,
                      labelText: "WhatsApp / Phone (Optional)",
                      hintText: "e.g. +88017XXXXXXXX",
                      prefixIcon: Iconsax.call,
                      keyboardType: TextInputType.phone,

                    ),
                    const SizedBox(height: 32),

                    // Sign Up Button with Visibility
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Visibility(
                          visible: !_isLoading,
                          replacement: const CenterCircularProgressIndicator(
                            color: Colors.white,
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
