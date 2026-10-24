import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/about_us_page.dart';
import 'package:hardware_manufacturing/screen/add_cart.dart';
import 'package:hardware_manufacturing/screen/addproduct_page.dart';
import 'package:hardware_manufacturing/screen/admin_order_details_page.dart';
import 'package:hardware_manufacturing/screen/admin_profile_page.dart'
    show AdminProfilePageScreen;
import 'package:hardware_manufacturing/screen/admin_reports_page.dart';
import 'package:hardware_manufacturing/screen/admin_settings_page.dart';
import 'package:hardware_manufacturing/screen/asign_ordar_page.dart';
import 'package:hardware_manufacturing/screen/categories_page.dart';
import 'package:hardware_manufacturing/screen/checkout.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/create_account_page.dart';
import 'package:hardware_manufacturing/screen/dashbord_page.dart';
import 'package:hardware_manufacturing/screen/deliver_staff_page.dart';
import 'package:hardware_manufacturing/screen/delivery_dashboard_page.dart';
import 'package:hardware_manufacturing/screen/delivery_orders_pages.dart';
import 'package:hardware_manufacturing/screen/delivery_settings_page.dart';
import 'package:hardware_manufacturing/screen/delivery_updates_page.dart';
import 'package:hardware_manufacturing/screen/first_page.dart';
import 'package:hardware_manufacturing/screen/forgot_password_page.dart';
import 'package:hardware_manufacturing/screen/inventory_page.dart';
import 'package:hardware_manufacturing/screen/login_page.dart';
import 'package:hardware_manufacturing/screen/myprofile.dart';
import 'package:hardware_manufacturing/screen/notification_page.dart';
import 'package:hardware_manufacturing/screen/notifications_page.dart';
import 'package:hardware_manufacturing/screen/ordar_page.dart';
import 'package:hardware_manufacturing/screen/order_detail.dart';
import 'package:hardware_manufacturing/screen/order_details_page.dart';
import 'package:hardware_manufacturing/screen/order_placed.dart';
import 'package:hardware_manufacturing/screen/product_detail.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';
import 'package:hardware_manufacturing/screen/product_page.dart';
import 'package:hardware_manufacturing/screen/products.dart';
import 'package:hardware_manufacturing/screen/register_page.dart';
import 'package:hardware_manufacturing/screen/role_login_page.dart';
import 'package:hardware_manufacturing/screen/role_selection_page.dart';
import 'package:hardware_manufacturing/screen/setting.dart';
import 'package:hardware_manufacturing/screen/wishlist_page.dart';

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
        fontFamily: 'Arial',
        scaffoldBackgroundColor: kPageGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: kMidBlue),
        appBarTheme: const AppBarTheme(
          backgroundColor: kAppBarBlue,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.15,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: '/login',
      routes: {
        // ── Customer routes ──
        '/home': (_) => const HomePage(),
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/create-account': (_) => const CreateAccountPage(),
        '/forgot-password': (_) => const ForgotPasswordPage(),
        '/about': (_) => const AboutUsPage(),
        '/products': (_) => const ProductsPage(),
        '/wishlist': (_) => const WishlistPage(),
        '/notifications': (_) => const NotificationsPage(),
        '/profile': (_) => const MyProfilePage(),
        '/settings': (_) => const SettingsPage(),
        '/cart': (_) => const CartPage(),
        '/checkout': (_) => const CheckoutPage(),
        '/orders': (_) => const OrderDetailsPage(),
        '/order-placed': (_) => const OrderPlacedPage(),

        // ── Role picker / entry points ──
        '/role-picker': (_) => const RoleSelectionPage(),

        // ── Admin routes ──
        '/admin/login': (_) => const AdminLoginPage(),
        '/admin/dashboard': (_) => const AdminDashboard(),
        '/admin/products': (_) => const ManageProductPage(),
        '/admin/add-product': (_) => const AddProductPage(),
        '/admin/inventory': (_) => const InventoryPage(),
        '/admin/assign-orders': (_) => const AssignOrdersPage(),
        '/admin/categories': (_) => const CategoriesPage(),
        '/admin/customers': (_) => const CustomerPage(),
        '/admin/notifications': (_) => const NotificationPage(),
        '/admin/profile': (_) => const AdminProfilePageScreen(),
        '/admin/delivery-staff': (_) => const DeliveryStaffPage(),
        '/admin/reports': (_) => const AdminReportsPage(),
        '/admin/settings': (_) => const AdminSettingsPage(),
        '/admin/orders': (_) => const InventoryPage(),
        '/admin/order-details': (_) => const OrderDetailsAdminPage(),
        '/admin/product-details': (_) => const OrderDetailsAdminPage(),
        '/admin/users': (_) => const CustomerPage(),
        '/admin/user-details': (_) => const OrderDetailsAdminPage(),

        // ── Delivery routes ──
        '/delivery/login': (_) => const DeliveryLoginPage(),
        '/delivery/dashboard': (_) => const DeliveryDashboardPage(),
        '/delivery/assigned-orders': (_) => const AssignOrdersPage(),
        '/delivery/updates': (_) => const DeliveryUpdatesPage(),
        '/delivery/order-details': (_) => const DeliveryOrderDetailsScreen(),
        '/delivery/picked-up': (_) => const DeliveryPickedUpPage(),
        '/delivery/out-for-delivery': (_) => const DeliveryOutForDeliveryPage(),
        '/delivery/delivered': (_) => const DeliveryDeliveredPage(),
        '/delivery/notifications': (_) => const NotificationPage(),
        '/delivery/settings': (_) => const DeliverySettingsPage(),
        '/delivery/profile': (_) => const DeliveryStaffPage(),

        // ── Categories (shared) ──
        '/categories': (_) => const CategoriesPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product-detail') {
          final product = settings.arguments as Product?;
          if (product == null) {
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('No product selected')),
              ),
            );
          }
          return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(product: product),
          );
        }
        return MaterialPageRoute(builder: (_) => const LoginPage());
      },
    );
  }
}
