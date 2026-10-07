import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_manufacturing/main.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/order_store.dart';
import 'package:hardware_manufacturing/screen/wishlist_store.dart';

Future<void> _bootApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 1500);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  CartStore.clear();
  OrderStore.lastOrder = null;
  for (final id in WishlistStore.ids.toList()) {
    WishlistStore.remove(id);
  }
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

Future<void> _signIn(WidgetTester tester) async {
  await tester.enterText(
    find.byType(TextFormField).at(0),
    'shethkrutika8@gmail.com',
  );
  await tester.enterText(find.byType(TextFormField).at(1), 'secret1');
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();
}

Future<void> _dismissSnackbars(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

Future<void> _openDrawer(WidgetTester tester, String label) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login validates and opens home', (tester) async {
    await _bootApp(tester);
    expect(find.text('Welcome Back'), findsOneWidget);

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter email'), findsOneWidget);

    await _signIn(tester);
    expect(find.text('Trending Categories'), findsOneWidget);
    expect(find.text('Power Tools'), findsOneWidget);
    expect(find.text('Hand Tools'), findsOneWidget);
  });

  testWidgets('forgot password opens from login and returns', (tester) async {
    await _bootApp(tester);
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    expect(find.text('Forgot Password'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField),
      'shethkrutika8@gmail.com',
    );
    await tester.tap(find.text('Send OTP'));
    await tester.pumpAndSettle();
    expect(find.text('Demo OTP: 4821'), findsOneWidget);

    await tester.tap(find.text('Back to Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('register validates, creates account and links back to login', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);
    await _openDrawer(tester, 'Create Account');
    expect(find.text('Create Account'), findsWidgets);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your full name'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Krutika Sheth');
    await tester.enterText(fields.at(1), 'shethkrutika8@gmail.com');
    await tester.enterText(fields.at(2), '5624356273');
    await tester.enterText(fields.at(3), 'secret1');
    await tester.enterText(fields.at(4), 'secret2');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pumpAndSettle();
    expect(find.text('Passwords do not match'), findsOneWidget);

    await tester.enterText(fields.at(4), 'secret1');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pumpAndSettle();
    expect(find.text('Trending Categories'), findsOneWidget);

    await _openDrawer(tester, 'Create Account');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('home category opens filtered products and product details', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);

    await tester.tap(find.text('Fasteners'));
    await tester.pumpAndSettle();
    expect(find.text('Hex Nut'), findsOneWidget);
    expect(find.text('Step Ladder'), findsNothing);

    await tester.tap(find.text('Hex Nut'));
    await tester.pumpAndSettle();
    expect(find.text('Product Details'), findsOneWidget);
    expect(find.text('Product Specifications'), findsOneWidget);
    expect(find.text('Rs. 15.50/pcs'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Hex Nut'), findsOneWidget);
  });

  testWidgets('cart add, badge, quantity, totals and remove', (tester) async {
    await _bootApp(tester);
    await _signIn(tester);
    await tester.tap(find.text('View More'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add_box_outlined).first);
    await _dismissSnackbars(tester);
    expect(CartStore.itemCount, 1);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.shopping_bag_outlined).first);
    await tester.pumpAndSettle();
    expect(find.text('My Cart'), findsOneWidget);
    expect(find.text('Hex Nut'), findsWidgets);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();
    expect(CartStore.itemCount, 2);
    expect(find.text('Rs. 31.00'), findsNWidgets(2));
    expect(find.text('Rs. 36.58'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();
    expect(CartStore.itemCount, 1);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Your cart is empty'), findsOneWidget);
    final checkoutButton = tester.widget<ElevatedButton>(
      find.descendant(
        of: find.widgetWithText(WhitePillButton, 'Proceed To Checkout'),
        matching: find.byType(ElevatedButton),
      ),
    );
    expect(checkoutButton.onPressed, isNull);
  });

  testWidgets('wishlist toggles consistently on card and details', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);
    await tester.tap(find.text('View More'));
    await tester.pumpAndSettle();

    final cardHeart = find.descendant(
      of: find.byType(ListView),
      matching: find.byIcon(Icons.favorite_border),
    );
    await tester.tap(cardHeart.first);
    await tester.pumpAndSettle();
    expect(WishlistStore.isWishlisted('hex-nut'), isTrue);
    expect(
      find.descendant(
        of: find.byType(ListView),
        matching: find.byIcon(Icons.favorite),
      ),
      findsWidgets,
    );

    await tester.tap(find.text('Hex Nut'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsWidgets);

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pumpAndSettle();
    expect(WishlistStore.isWishlisted('hex-nut'), isFalse);
  });

  testWidgets('checkout places a demo order and order pages show it', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);
    await tester.tap(find.text('View More'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hex Nut'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(WhitePillButton),
        matching: find.text('Proceed To Checkout'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('CheckOut'), findsOneWidget);
    expect(find.text('Delivery Address'), findsOneWidget);
    expect(find.text('Payment Method'), findsOneWidget);
    expect(find.text('Cash on Delivery'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(WhitePillButton),
        matching: find.text('Place Order'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Order Placed Successfully'), findsOneWidget);
    final orderId = OrderStore.lastOrder!.id;
    expect(find.text(orderId), findsOneWidget);
    expect(CartStore.items, isEmpty);

    await tester.tap(find.text('View Order Details'));
    await tester.pumpAndSettle();
    expect(find.text('Order Details'), findsOneWidget);
    expect(find.text('Confirmed'), findsOneWidget);
    expect(find.text(orderId), findsOneWidget);
    expect(find.text('Hex Nut'), findsWidgets);

    await _openDrawer(tester, 'Home');
    expect(find.text('Trending Categories'), findsOneWidget);
  });

  testWidgets('order details shows empty state before any order', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);
    await _openDrawer(tester, 'Order Details');
    expect(find.textContaining('No order yet'), findsOneWidget);
  });

  testWidgets('settings and profile rows navigate correctly', (tester) async {
    await _bootApp(tester);
    await _signIn(tester);

    await _openDrawer(tester, 'Settings');
    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Krutika Sheth'), findsOneWidget);
    expect(find.text('shethkrutika8@gmail.com'), findsOneWidget);

    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();
    expect(find.text('Log Out'), findsOneWidget);

    await tester.tap(find.text('About Us'));
    await tester.pumpAndSettle();
    expect(find.text('About us'), findsOneWidget);

    await _openDrawer(tester, 'Settings');
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);
  });

  testWidgets('profile rows reach wishlist, orders and settings', (
    tester,
  ) async {
    await _bootApp(tester);
    await _signIn(tester);
    await _openDrawer(tester, 'My Profile');

    await tester.tap(find.text('Wishlist'));
    await tester.pumpAndSettle();
    expect(find.text('Products'), findsWidgets);

    await _openDrawer(tester, 'My Profile');
    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();
    expect(find.text('Order Details'), findsOneWidget);

    await _openDrawer(tester, 'My Profile');
    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();
    expect(find.text('Log Out'), findsOneWidget);
  });

  testWidgets(
    'about page shows the toolkit image and wishlist remains visible',
    (tester) async {
      await _bootApp(tester);
      await _signIn(tester);
      await _openDrawer(tester, 'About Us');

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/toolkit.png',
        ),
        findsOneWidget,
      );

      expect(find.byTooltip('Wishlist'), findsOneWidget);
    },
  );

  testWidgets('logo and banner assets are wired up', (tester) async {
    await _bootApp(tester);
    expect(find.byType(Image), findsWidgets);
    await _signIn(tester);
    expect(find.byType(Image), findsWidgets);
  });
}
