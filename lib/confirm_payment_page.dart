import 'package:flutter/material.dart';
import 'package:task_app/bill_summary_page.dart';
import 'package:task_app/cart_item.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const ConfirmPaymentPage({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  bool useCreditCard = false;
  int? numberOfPersons;
  bool payByIndividual = false;
  bool splitEqually = false;
  String? selectedPayer;
  bool discountInPercentage = false;
  double discountValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Payment Options:'),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Number of persons',
              ),
              onChanged: (value) {
                setState(() {
                  numberOfPersons = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Pay as Individual'),
              value: payByIndividual,
              onChanged: (value) {
                setState(() {
                  payByIndividual = value ?? false;
                  splitEqually = false;
                  selectedPayer = null;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            if (payByIndividual)
              Column(
                children: [
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    hint: const Text('Select Payer'),
                    value: selectedPayer,
                    items: List.generate(
                      numberOfPersons ?? 0,
                      (index) => DropdownMenuItem<String>(
                        value: 'Person ${index + 1}',
                        child: Text('Person ${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedPayer = value;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Split Equally'),
              value: splitEqually,
              onChanged: (value) {
                setState(() {
                  splitEqually = value ?? false;
                  payByIndividual = false;
                  selectedPayer = null;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Use Credit Card'),
              value: useCreditCard,
              onChanged: (value) {
                setState(() {
                  useCreditCard = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Discount in percentage'),
              value: discountInPercentage,
              onChanged: (value) {
                setState(() {
                  discountInPercentage = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              shape: const CircleBorder(),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter discount amount',
              ),
              onChanged: (value) {
                setState(() {
                  discountValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillSummaryPage(
                      cartItems: widget.cartItems,
                      numberOfPersons: numberOfPersons,
                      useCreditCard: useCreditCard,
                      payByIndividual: payByIndividual,
                      selectedPayer: selectedPayer,
                      splitEqually: splitEqually,
                      discountInPercentage: discountInPercentage,
                      discountValue: discountValue,
                    ),
                  ),
                );
              },
              child: const Text('Continue to Bill Summary'),
            ),
          ],
        ),
      ),
    );
  }
}
