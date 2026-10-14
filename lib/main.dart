import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/about_us_page.dart';
import 'package:hardware_manufacturing/screen/add_cart.dart';
import 'package:hardware_manufacturing/screen/addproduct_page.dart';
import 'package:hardware_manufacturing/screen/asign%20ordar_page.dart';
import 'package:hardware_manufacturing/screen/categories_page.dart';
import 'package:hardware_manufacturing/screen/checkout.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/Dashbord_page.dart';
import 'package:hardware_manufacturing/screen/deliver%20staff_page.dart';
import 'package:hardware_manufacturing/screen/delivery%20dashboard_page.dart';
import 'package:hardware_manufacturing/screen/delivery%20updates_page.dart';
import 'package:hardware_manufacturing/screen/first_page.dart';
import 'package:hardware_manufacturing/screen/forgot_password_page.dart';
import 'package:hardware_manufacturing/screen/inventory_page.dart';
import 'package:hardware_manufacturing/screen/login_page.dart';
import 'package:hardware_manufacturing/screen/myprofile.dart';
import 'package:hardware_manufacturing/screen/notification_page.dart';
import 'package:hardware_manufacturing/screen/notifications_page.dart';
import 'package:hardware_manufacturing/screen/order%20details_page.dart';
import 'package:hardware_manufacturing/screen/order_detail.dart';
import 'package:hardware_manufacturing/screen/order_placed.dart';
import 'package:hardware_manufacturing/screen/ordar_page.dart';
import 'package:hardware_manufacturing/screen/product_detail.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';
import 'package:hardware_manufacturing/screen/product_page.dart';
import 'package:hardware_manufacturing/screen/products.dart';
import 'package:hardware_manufacturing/screen/register_page.dart';
import 'package:hardware_manufacturing/screen/setting.dart';
import 'package:hardware_manufacturing/screen/wishlist_page.dart';
import 'package:hardware_manufacturing/screen/admin%20profile_page.dart'
    show AdminProfilePageScreen;

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

        // Legacy admin routes kept for backward compat
        '/admin/orders': (_) => const InventoryPage(),
        '/admin/order-details': (_) => const OrderDetailsAdminPage(),
        '/admin/product-details': (_) => const OrderDetailsAdminPage(),
        '/admin/users': (_) => const CustomerPage(),
        '/admin/user-details': (_) => const OrderDetailsAdminPage(),
        '/admin/reports': (_) => const AdminReportsPage(),
        '/admin/settings': (_) => const AdminSettingsPage(),

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

// ─────────────────────────────────────────────────────────────────
// ROLE SELECTION PAGE
// ─────────────────────────────────────────────────────────────────
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kAuthTop, kAuthBottom],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BuildTechLogo(width: 180, height: 70),
                  const SizedBox(height: 28),
                  const Text(
                    'Choose a panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PanelButton(
                    label: 'ADMIN PANEL',
                    icon: Icons.admin_panel_settings_outlined,
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/admin/login',
                      (route) => false,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _PanelButton(
                    label: 'DELIVERY STAFF PANEL',
                    icon: Icons.delivery_dining_outlined,
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/delivery/login',
                      (route) => false,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _PanelButton(
                    label: 'CUSTOMER STORE',
                    icon: Icons.storefront_outlined,
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PanelButton extends StatelessWidget {
  const _PanelButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 24),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          backgroundColor: Colors.white,
          foregroundColor: kNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// ROLE LOGIN PAGE  (reused for Admin & Delivery)
// ─────────────────────────────────────────────────────────────────
class RoleLoginPage extends StatefulWidget {
  const RoleLoginPage({
    super.key,
    required this.title,
    required this.routeAfterLogin,
    required this.panelColor,
  });

  final String title;
  final String routeAfterLogin;
  final Color panelColor;

  @override
  State<RoleLoginPage> createState() => _RoleLoginPageState();
}

class _RoleLoginPageState extends State<RoleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        widget.routeAfterLogin,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kAuthTop, kAuthBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const BuildTechLogo(width: 150, height: 62),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'High Quality hardware solution built to last.',
                      style: TextStyle(
                        fontSize: 12,
                        color: kTagBlue,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kAuthPanel,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      22,
                      26,
                      22,
                      20 + keyboardInset.clamp(0.0, 120.0),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign in to continue to your account',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: authFieldDecoration(
                              'Email',
                              prefix: const Icon(
                                Icons.email_outlined,
                                color: Color(0xffb7b3b7),
                                size: 22,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@') || !value.contains('.')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: authFieldDecoration(
                              'Password',
                              prefix: const Icon(
                                Icons.lock_outline,
                                color: Color(0xffb7b3b7),
                                size: 22,
                              ),
                            ).copyWith(
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xff7d8791),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, '/forgot-password'),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: kIndigo,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          PrimaryBlueButton(label: 'Sign In', onPressed: _login),
                          const SizedBox(height: 14),
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/role-picker',
                                (r) => false,
                              ),
                              child: const Text(
                                'Switch Panel',
                                style: TextStyle(color: kIndigo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleLoginPage(
      title: 'Admin Login',
      routeAfterLogin: '/admin/dashboard',
      panelColor: Color(0xFF619DCA),
    );
  }
}

class DeliveryLoginPage extends StatelessWidget {
  const DeliveryLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleLoginPage(
      title: 'Delivery Login',
      routeAfterLogin: '/delivery/dashboard',
      panelColor: Color(0xFF67A4D2),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// ADMIN PAGES  (stub pages that link to real screens)
// ─────────────────────────────────────────────────────────────────

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Reports',
      drawer: const AdminDrawer(),
      children: [
        _reportCard('Total Sales', 'Rs. 2,30,000', Icons.trending_up),
        const SizedBox(height: 16),
        _reportCard('Total Orders', '520', Icons.receipt_long),
        const SizedBox(height: 16),
        _reportCard('Total Products', '1250', Icons.inventory_2),
        const SizedBox(height: 16),
        _reportCard('Total Customers', '850', Icons.people),
        const SizedBox(height: 16),
        _reportCard('Pending Orders', '35', Icons.hourglass_empty),
      ],
    );
  }

  Widget _reportCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Admin Settings',
      drawer: const AdminDrawer(),
      children: [
        _settingsTile(
          context,
          icon: Icons.person_outline,
          label: 'Edit Profile',
          route: '/admin/profile',
        ),
        const SizedBox(height: 12),
        _settingsTile(
          context,
          icon: Icons.notifications_none,
          label: 'Notifications',
          route: '/admin/notifications',
        ),
        const SizedBox(height: 12),
        _settingsTile(
          context,
          icon: Icons.lock_outline,
          label: 'Change Password',
          route: '/forgot-password',
        ),
        const SizedBox(height: 12),
        _settingsTile(
          context,
          icon: Icons.logout,
          label: 'Log Out',
          route: '/login',
          isLogout: true,
        ),
      ],
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    bool isLogout = false,
  }) {
    return ListTile(
      tileColor: Colors.white.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        if (isLogout) {
          Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// DELIVERY PAGES
// ─────────────────────────────────────────────────────────────────

class DeliveryPickedUpPage extends StatelessWidget {
  const DeliveryPickedUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Picked Up Orders',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in ['BTD1234567890', 'BTD6278364752', 'BTD6278365778'])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OrderTile(
              orderId: id,
              status: 'Picked Up',
              statusColor: Colors.amber,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}

class DeliveryOutForDeliveryPage extends StatelessWidget {
  const DeliveryOutForDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Out for Delivery',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in ['BTD1234567890', 'BTD6278364752'])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OrderTile(
              orderId: id,
              status: 'Out for Delivery',
              statusColor: Colors.orangeAccent,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}

class DeliveryDeliveredPage extends StatelessWidget {
  const DeliveryDeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Delivered',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in [
          'BTD6278378689',
          'BTD6278376432',
          'BTD6768364752',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OrderTile(
              orderId: id,
              status: 'Delivered',
              statusColor: Colors.greenAccent,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}

class DeliverySettingsPage extends StatelessWidget {
  const DeliverySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Delivery Settings',
      drawer: const DeliveryDrawer(),
      children: [
        _dsTile(context, icon: Icons.person_outline, label: 'My Profile',
            route: '/delivery/profile'),
        const SizedBox(height: 12),
        _dsTile(context, icon: Icons.notifications_none, label: 'Notifications',
            route: '/delivery/notifications'),
        const SizedBox(height: 12),
        _dsTile(context, icon: Icons.lock_outline, label: 'Change Password',
            route: '/forgot-password'),
        const SizedBox(height: 12),
        _dsTile(context, icon: Icons.logout, label: 'Log Out',
            route: '/login', isLogout: true),
      ],
    );
  }

  Widget _dsTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    bool isLogout = false,
  }) {
    return ListTile(
      tileColor: Colors.white.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        if (isLogout) {
          Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}

// Shared admin page for unimplemented admin sub‑pages
class OrderDetailsAdminPage extends StatelessWidget {
  const OrderDetailsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _PanelPage(
      title: 'Details',
      drawer: const AdminDrawer(),
      children: [
        _infoRow('Order ID', 'BTD1234567890'),
        const SizedBox(height: 12),
        _infoRow('Customer', 'Krutika Sheth'),
        const SizedBox(height: 12),
        _infoRow('Status', 'Processing'),
        const SizedBox(height: 12),
        _infoRow('Amount', 'Rs. 90.50'),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(color: Colors.white70, fontSize: 14)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// SHARED HELPERS
// ─────────────────────────────────────────────────────────────────

/// Generic gradient scaffold used by both admin and delivery stub pages.
class _PanelPage extends StatelessWidget {
  const _PanelPage({
    required this.title,
    required this.children,
    required this.drawer,
  });

  final String title;
  final List<Widget> children;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradTop, kGradBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: children,
          ),
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  final String orderId;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.receipt_long, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                orderId,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: statusColor, width: 1),
              ),
              child: Text(
                status,
                style:
                    TextStyle(color: statusColor, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
