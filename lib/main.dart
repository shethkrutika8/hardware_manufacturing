import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/order_detail.dart';
import 'package:hardware_manufacturing/screen/order_placed.dart';
import 'package:hardware_manufacturing/screen/First_page.dart' as home_screen;
import 'package:hardware_manufacturing/screen/Products.dart' as products_screen;
import 'package:hardware_manufacturing/screen/about_us_page.dart'
    as about_screen;
import 'package:hardware_manufacturing/screen/add_cart.dart';
import 'package:hardware_manufacturing/screen/checkout.dart';
import 'package:hardware_manufacturing/screen/myprofile.dart';
import 'package:hardware_manufacturing/screen/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuildTech Hardware',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xfff8f5f5),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1565a8)),
      ),
      home: const about_screen.AboutUsPage(),
      routes: {
        '/home': (_) => const home_screen.HomePage(),
        '/about': (_) => const about_screen.AboutUsPage(),
        '/products': (_) => const products_screen.ProductsPage(),
        '/profile': (_) => const MyProfilePage(),
        '/settings': (_) => const SettingsPage(),
        '/cart': (_) => const CartPage(),
        '/checkout': (_) => const CheckoutPage(),
        '/orders': (_) => const OrderDetailsPage(),
        '/order-placed': (_) => const OrderPlacedPage(),
      },
    );
  }
}
