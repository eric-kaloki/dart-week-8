import 'package:flutter/material.dart';

// Updated AccountBalanceCard to accept dynamic balance
class AccountBalanceCard extends StatelessWidget {
  final double balance;

  const AccountBalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures it fits the width of the viewport
      decoration: BoxDecoration(
        color: Colors.deepPurple[50], // Consistent light purple
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Balance: \$${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Account Number: 1234-5678-9012',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Custom widget for the styled button
class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        elevation: 5,
        shadowColor: Colors.deepPurple.shade300,
      ),
      child: Text(text),
    );
  }
}

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String _recipientName = '';
  double _amount = 0.0;
  String _paymentMethod = 'Bank Transfer';
  bool _isFavorite = false;

  // Track account balance
  double _accountBalance = 1250.00;

  // Function to show success dialog
  void _showSuccessDialog(BuildContext context) {
    setState(() {
      _accountBalance -= _amount; // Deduct the sent amount from the balance
    });

    showDialog(
      context: context,
      builder: (context) => AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(seconds: 1),
        child: AlertDialog(
          title: const Text(
            'Success',
            style: TextStyle(color: Colors.deepPurple),
          ),
          content: Text('Transaction completed successfully! Remaining balance: \$${_accountBalance.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _formKey.currentState!.reset();
                  _paymentMethod = 'Bank Transfer';
                  _isFavorite = false;
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send Money',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              // Updated AccountBalanceCard to display dynamic balance
              AccountBalanceCard(balance: _accountBalance),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Recipient Name',
                onSaved: (value) => _recipientName = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipient name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Amount',
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.parse(value!),
                validator: (value) {
                  if (value == null ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  if (double.parse(value) > _accountBalance) {
                    return 'Insufficient balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mark as Favorite',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) => setState(() => _isFavorite = value),
                    activeColor: Colors.deepPurple,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: StyledButton(
                  text: 'Send Money',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _showSuccessDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Refactored Input Field Widget
  Widget _buildInputField({
    required String label,
    TextInputType? keyboardType,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.black87),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }

  // Refactored Dropdown Field
  Widget _buildDropdownField() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: DropdownButtonFormField<String>(
      value: _paymentMethod,
      items: const [
        DropdownMenuItem(value: 'M-Pesa', child: Text('M-Pesa', style: TextStyle(color: Colors.black87))),
        DropdownMenuItem(value: 'Airtel Money', child: Text('Airtel Money', style: TextStyle(color: Colors.black87))),
        DropdownMenuItem(value: 'Bank Transfer', child: Text('Bank Transfer', style: TextStyle(color: Colors.black87))),
        DropdownMenuItem(value: 'Credit Card', child: Text('Credit Card', style: TextStyle(color: Colors.black87))),
        DropdownMenuItem(value: 'PayPal', child: Text('PayPal', style: TextStyle(color: Colors.black87))),
      ],
      onChanged: (value) => setState(() => _paymentMethod = value!),
      decoration: const InputDecoration(
        labelText: 'Payment Method',
        border: InputBorder.none,
        labelStyle: TextStyle(color: Colors.black87),
      ),
      style: const TextStyle(color: Colors.black87),
      dropdownColor: Colors.white,
    ),
  );
}
}

