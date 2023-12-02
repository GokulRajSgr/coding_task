import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'confirm_payment_page.dart'; // Import the ConfirmPaymentPage

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(List<CartItem>) updateCart;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.updateCart,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: widget.cartItems.length,
              itemBuilder: (context, index, animation) {
                final cartItem = widget.cartItems[index];
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    title: Text('${cartItem.foodItem} x ${cartItem.quantity}'),
                    subtitle: Text('Price: \$${cartItem.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        List<CartItem> updatedCart =
                            List.from(widget.cartItems);
                        updatedCart.removeAt(index);

                        widget.updateCart(updatedCart);

                        _listKey.currentState?.removeItem(
                            index, (context, animation) => Container());
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ConfirmPaymentPage(cartItems: widget.cartItems),
                ),
              );
            },
            child: const Text('Proceed to Payment'),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
