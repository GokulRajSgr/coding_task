import 'package:flutter/material.dart';
import 'cart_item.dart';

class BillSummaryPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final int? numberOfPersons;
  final bool useCreditCard;
  final bool payByIndividual;
  final String? selectedPayer;
  final bool splitEqually;
  final bool discountInPercentage;
  final double discountValue;

  const BillSummaryPage({
    Key? key,
    required this.cartItems,
    this.numberOfPersons,
    required this.useCreditCard,
    required this.payByIndividual,
    this.selectedPayer,
    required this.splitEqually,
    required this.discountInPercentage,
    required this.discountValue,
  }) : super(key: key);

  double calculateItemtotalWithoutTax() {
    double withTax =
        cartItems.fold(0, (itemTotal, item) => itemTotal + (item.price));
    double withoutTax = withTax - (withTax * 0.10);
    return withoutTax;
  }

  double calculateItemtotal() {
    return cartItems.fold(0, (itemTotal, item) => itemTotal + (item.price));
  }

  double calculateTaxes(double itemTotal) {
    return itemTotal * 0.10;
  }

  double calculateFinalBill(double itemTotal) {
    double total = itemTotal;
    if (discountInPercentage) {
      total -= total * (discountValue / 100);
    } else {
      total -= discountValue;
    }

    if (useCreditCard) {
      total += total * 0.012;
    }

    return total;
  }

  double calculateIndividualShare(double total) {
    return splitEqually ? total / numberOfPersons! : total;
  }

  @override
  Widget build(BuildContext context) {
    double itemTotal = calculateItemtotal();
    double itemTotalWithoutTax = calculateItemtotalWithoutTax();
    double taxes = calculateTaxes(itemTotal);
    double finalBill = calculateFinalBill(itemTotal);
    double individualShare = calculateIndividualShare(finalBill);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var item in cartItems)
                ListTile(
                  title: Text('${item.foodItem} x ${item.quantity}'),
                  subtitle: Text('Price: \$${item.price}'),
                ),
              const SizedBox(height: 20),
              Text('ItemTotal: \$${itemTotalWithoutTax.toStringAsFixed(2)}'),
              Text('Taxes: \$${taxes.toStringAsFixed(2)}'),
              Text('Total: \$${itemTotal.toStringAsFixed(2)}'),
              const SizedBox(height: 20),
              if (discountValue > 0)
                Text(
                    'Discount Reduced: \$${(itemTotal * (discountValue / 100)).toStringAsFixed(2)}'),
              
              if (useCreditCard)
                Text(
                    'Credit Card Surcharge: \$${(finalBill * 0.012).toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              Text('Final Bill: \$${finalBill.toStringAsFixed(2)}'),
              const SizedBox(height: 30),
              if (payByIndividual) Text('Paid by: $selectedPayer'),
              if (splitEqually)
                ...List.generate(
                  numberOfPersons!,
                  (index) => Text(
                      'Person ${index + 1} Share: \$${individualShare.toStringAsFixed(2)}'),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
