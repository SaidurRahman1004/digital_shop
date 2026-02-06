import 'dart:math';
import 'package:digital_shop/widgets/AppbarCustom.dart';
import 'package:digital_shop/widgets/custom_text_field.dart';
import 'package:digital_shop/widgets/section_header.dart';
import 'package:digital_shop/widgets/payment_instruction_stepper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentCheckout extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final double totalAmount;

  const PaymentCheckout({
    super.key,
    required this.items,
    required this.totalAmount,
  });

  @override
  State<PaymentCheckout> createState() => _PaymentCheckoutState();
}

class _PaymentCheckoutState extends State<PaymentCheckout> {
  final _formKey = GlobalKey<FormState>();
  final _trxController = TextEditingController();
  final _senderNumberController = TextEditingController();
  final _paidAmountController = TextEditingController();
  late String _orderId;
  String _selectedMethod = 'Bkash';

  //Admin numbers
  final Map<String, String> _adminNumbers = {
    'Bkash': '017XXXXXXXX',
    'Nagad': '018XXXXXXXX',
    'Rocket': '019XXXXXXXX',
  };

  @override
  void initState() {
    super.initState();
    _orderId = "ORDID${Random().nextInt(900000) + 100000}";
    _paidAmountController.text = widget.totalAmount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustomAll(title: "Payment Checkout", showLogo: false),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildOrderSummaryCard(),
                  const SizedBox(height: 24),
                  const SectionHeader(title: "Payment Instructions"),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PaymentInstructionStepper(
                        amount: widget.totalAmount.toStringAsFixed(2),
                        adminNumber: _adminNumbers[_selectedMethod]!,
                        orderId: _orderId,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SectionHeader(title: "Select Your Payment Method"),
                  _buildPaymentMethodDropdown(),
                  const SizedBox(height: 20),
                  //inputs Feilds
                  CustomTextField(
                    controller: _trxController,
                    labelText: "Transaction ID (TxID)",
                    prefixIcon: Iconsax.password_check,
                    hintText: "Enter the TxID from your SMS",
                    validator: (v) => v!.isEmpty ? "TxID is required" : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _senderNumberController,
                    labelText: "Your Account Number",
                    prefixIcon: Iconsax.call,
                    keyboardType: TextInputType.phone,
                    hintText: "The number you paid from",
                    validator: (v) =>
                        v!.isEmpty ? "Sender number is required" : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _paidAmountController,
                    labelText: "Paid Amount",
                    prefixIcon: Iconsax.money_3,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),

                  // HelpButton
                  TextButton.icon(
                    onPressed: _showHelpDialog,
                    icon: const Icon(Iconsax.info_circle),
                    label: const Text("Need Help with Payment?"),
                  ),
                  // SubmitButton
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _handleSubmit,
                      child: const Text(
                        "Confirm & Submit Payment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //order Summery Card
  Widget _buildOrderSummaryCard() {
    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColor.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SectionHeader(title: "Order Summary"),
            ListTile(
              title: const Text("Order ID", style: TextStyle(fontSize: 14)),
              trailing: Text(
                _orderId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const Divider(),
            ...widget.items.map(
              (item) => ListTile(
                dense: true,
                title: Text(item['name']),
                trailing: Text("৳${item['price']}"),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Total Payable",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                "৳${widget.totalAmount}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Payment selection dropdown
  Widget _buildPaymentMethodDropdown() {
    final methods = ['Bkash', 'Nagad', 'Rocket'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: methods.map((m) {
        bool isSelected = _selectedMethod == m;
        return GestureDetector(
          onTap: () => setState(() => _selectedMethod = m),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              m,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  //help dialog
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Guide"),
        content: const Text(
          "A PDF or Video Guide will be loaded here. Currently, please follow the steps on screen.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {}
  }
}
