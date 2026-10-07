import 'package:flutter/foundation.dart';

class AppNotificationItem {
  const AppNotificationItem({
    required this.title,
    required this.message,
    this.isRead = false,
  });

  final String title;
  final String message;
  final bool isRead;

  AppNotificationItem copyWith({String? title, String? message, bool? isRead}) {
    return AppNotificationItem(
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationStore {
  static final List<AppNotificationItem> _items = [
    const AppNotificationItem(
      title: 'Order confirmed',
      message:
          'Your recent BuildTech order has been confirmed and is being prepared for dispatch.',
      isRead: false,
    ),
    const AppNotificationItem(
      title: 'Payment update',
      message:
          'Payment verification for your hardware purchase is complete. Demo checkout succeeded.',
      isRead: false,
    ),
    const AppNotificationItem(
      title: 'Shipping update',
      message:
          'Your fasteners shipment is on the way and is expected to arrive in 2-3 working days.',
      isRead: true,
    ),
  ];

  static final ValueNotifier<int> changeNotifier = ValueNotifier<int>(0);

  static void _notify() => changeNotifier.value++;

  static List<AppNotificationItem> get items => List.unmodifiable(_items);

  static int get unreadCount => _items.where((item) => !item.isRead).length;

  static void add(String title, String message) {
    _items.insert(
      0,
      AppNotificationItem(title: title, message: message, isRead: false),
    );
    _notify();
  }

  static void markAllRead() {
    for (int i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(isRead: true);
    }
    _notify();
  }

  static void toggleRead(int index) {
    if (index < 0 || index >= _items.length) return;
    _items[index] = _items[index].copyWith(isRead: !_items[index].isRead);
    _notify();
  }
}
