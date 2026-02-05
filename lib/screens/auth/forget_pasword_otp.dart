import 'package:digital_shop/screens/auth/forget_pasword_reset.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../widgets/app_logo.dart';

class ForgetPasswordOtp extends StatelessWidget {
  const ForgetPasswordOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const AppLogo(width: 120, height: 120),
                const SizedBox(height: 20),
                const Text(
                  "Enter the 6-digit code sent to your registered email for Subscriptions BD.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Didn't receive code?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Resend OTP"),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgetPasswordReset(),
                      ),
                    ),
                    child: const Text("Verify OTP"),
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
