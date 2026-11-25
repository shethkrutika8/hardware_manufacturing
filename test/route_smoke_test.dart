import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_manufacturing/main.dart';

void main() {
  const routes = [
    '/register',
    '/create-account',
    '/forgot-password',
    '/role-picker',
    '/admin/login',
    '/admin/dashboard',
    '/admin/products',
    '/admin/add-product',
    '/admin/inventory',
    '/admin/assign-orders',
    '/admin/categories',
    '/admin/customers',
    '/admin/notifications',
    '/admin/profile',
    '/admin/delivery-staff',
    '/admin/reports',
    '/admin/settings',
    '/admin/orders',
    '/admin/order-details',
    '/admin/product-details',
    '/admin/users',
    '/admin/user-details',
    '/delivery/login',
    '/delivery/dashboard',
    '/delivery/assigned-orders',
    '/delivery/updates',
    '/delivery/order-details',
    '/delivery/picked-up',
    '/delivery/out-for-delivery',
    '/delivery/delivered',
    '/delivery/notifications',
    '/delivery/settings',
    '/delivery/profile',
    '/categories',
  ];

  for (final route in routes) {
    testWidgets('route $route builds without exceptions', (tester) async {
      tester.view.physicalSize = const Size(1400, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final nav = tester.state<NavigatorState>(find.byType(Navigator).last);
      nav.pushNamed(route);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'route $route threw');
    });
  }
}
