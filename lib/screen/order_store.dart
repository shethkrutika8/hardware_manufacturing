import 'package:flutter/foundation.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/notification_store.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';

class PlacedOrderItem {
  const PlacedOrderItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get lineTotal => product.numericPrice * quantity;
}

class PlacedOrder {
  const PlacedOrder({
    required this.id,
    required this.placedAt,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.paymentLabel,
  });

  final String id;
  final DateTime placedAt;
  final List<PlacedOrderItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final String customerName;
  final String phone;
  final String address;
  final String paymentLabel;
}

/// Holds the most recent demo order so confirmation and details stay in sync.
class OrderStore {
  static PlacedOrder? lastOrder;
  static final ValueNotifier<int> changeNotifier = ValueNotifier<int>(0);

  static PlacedOrder placeFromCart({
    required String customerName,
    required String phone,
    required String address,
    required String paymentLabel,
  }) {
    final stamp = DateTime.now();
    final id =
        'BTD${stamp.millisecondsSinceEpoch.toString().substring(stamp.millisecondsSinceEpoch.toString().length - 10)}';
    final order = PlacedOrder(
      id: id,
      placedAt: stamp,
      items: CartStore.items
          .map(
            (item) =>
                PlacedOrderItem(product: item.product, quantity: item.quantity),
          )
          .toList(),
      subtotal: CartStore.subtotal,
      tax: CartStore.tax,
      shipping: CartStore.shipping,
      total: CartStore.total,
      customerName: customerName,
      phone: phone,
      address: address,
      paymentLabel: paymentLabel,
    );
    lastOrder = order;
    NotificationStore.add(
      'Order confirmed',
      'Your order $id has been placed and is being processed. Payment status: pending confirmation.',
    );
    NotificationStore.add(
      'Payment update',
      'Payment for $id is ready for verification. Demo checkout completed successfully.',
    );
    changeNotifier.value++;
    return order;
  }
}
