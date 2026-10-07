import 'package:flutter/foundation.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';

/// Shared wishlist state across the app.
/// Stores product IDs that have been wishlisted.
class WishlistStore {
  static final Set<String> _ids = {};

  static final ValueNotifier<int> wishlistChangeNotifier = ValueNotifier<int>(
    0,
  );

  static void _notify() {
    wishlistChangeNotifier.value++;
  }

  static bool isWishlisted(String productId) => _ids.contains(productId);

  static void toggle(String productId) {
    if (_ids.contains(productId)) {
      _ids.remove(productId);
    } else {
      _ids.add(productId);
    }
    _notify();
  }

  static void add(String productId) {
    _ids.add(productId);
    _notify();
  }

  static void remove(String productId) {
    _ids.remove(productId);
    _notify();
  }

  static Set<String> get ids => Set.unmodifiable(_ids);

  static List<Product> get products =>
      kSampleProducts.where((product) => _ids.contains(product.id)).toList();

  static int get count => _ids.length;
}
