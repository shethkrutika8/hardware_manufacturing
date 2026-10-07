import 'package:flutter/foundation.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get totalPrice => product.numericPrice * quantity;

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartStore {
  static final List<CartItem> items = [];

  static final ValueNotifier<int> cartChangeNotifier = ValueNotifier<int>(0);

  static void _notify() {
    cartChangeNotifier.value++;
  }

  static void addProduct(Product product, [int quantity = 1]) {
    final safeQty = quantity < 1 ? 1 : quantity;
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      final existing = items[index];
      items[index] = existing.copyWith(quantity: existing.quantity + safeQty);
    } else {
      items.add(CartItem(product: product, quantity: safeQty));
    }
    _notify();
  }

  static void increment(int index) {
    if (index >= 0 && index < items.length) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
      _notify();
    }
  }

  static void decrement(int index) {
    if (index >= 0 && index < items.length && items[index].quantity > 1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      _notify();
    }
  }

  static void setQuantity(int index, int quantity) {
    if (index < 0 || index >= items.length) return;
    if (quantity < 1) return;
    items[index] = items[index].copyWith(quantity: quantity);
    _notify();
  }

  static void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      _notify();
    }
  }

  static void clear() {
    items.clear();
    _notify();
  }

  static int get itemCount {
    int count = 0;
    for (final item in items) {
      count += item.quantity;
    }
    return count;
  }

  static double get subtotal {
    double sum = 0.0;
    for (final item in items) {
      sum += item.totalPrice;
    }
    return sum;
  }

  static double get tax => subtotal * 0.18;

  static double get cartTotal => subtotal + tax;

  static double get shipping =>
      items.isEmpty ? 0.0 : (subtotal > 500 ? 0.0 : 40.0);

  static double get total => subtotal + tax + shipping;
}
