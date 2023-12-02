
class CartItem {
  final String foodItem;
  final int quantity;

  CartItem({
    required this.foodItem,
    required this.quantity,
  });

  double get price {
    switch (foodItem) {
      case 'Tea':
        return 3;
      case 'Coffee':
        return 3;
      case 'Soda':
        return 4;
      case 'Big Brekkie':
        return 16;
      case 'Bruchetta':
        return 8;
      case 'Poached Eggs':
        return 12;
      case 'Garden Salad':
        return 10;
      default:
        return 0; 
    }
  }
}
