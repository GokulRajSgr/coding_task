import 'package:flutter/material.dart';
import 'package:task_app/cart_item.dart';
import 'package:task_app/cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Billing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFoodItem = 'Tea';
  int quantity = 1;
  List<CartItem> cartItems = [];
  TextEditingController textEditingController =
      TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Billing'),
        actions: [
          CartIcon(
              itemCount: cartItems.length,
              cartItems: cartItems,
              updateCart: (newCartItems) {
                setState(() {
                  cartItems = newCartItems;
                });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Food Item:'),
            DropdownButton<String>(
              value: selectedFoodItem,
              items: [
                'Tea',
                'Coffee',
                'Soda',
                'Big Brekkie',
                'Bruchetta',
                'Poached Eggs',
                'Garden Salad',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFoodItem = newValue ?? 'Tea';
                });
              },
            ),
            const SizedBox(height: 10),
            const Text('Quantity'),
            TextField(
              keyboardType: TextInputType.number,
              controller: textEditingController,
              onChanged: (String value) {
                setState(() {
                  quantity = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                CartItem newItem =
                    CartItem(foodItem: selectedFoodItem, quantity: quantity);
                setState(() {
                  cartItems.add(newItem);
                  textEditingController.text = '1';
                  selectedFoodItem = 'Tea';
                  quantity = 0;
                });
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartIcon extends StatefulWidget {
  final int itemCount;
  final List<CartItem> cartItems;
  final Function(List<CartItem>) updateCart;

  const CartIcon({
    super.key,
    required this.itemCount,
    required this.cartItems,
    required this.updateCart,
  });

  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.shopping_cart),
          Positioned(
            right: 0,
            child: widget.itemCount > 0
                ? CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      widget.itemCount.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(
                cartItems: widget.cartItems, updateCart: widget.updateCart),
          ),
        );
      },
    );
  }
}
