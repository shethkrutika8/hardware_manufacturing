import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/notification_store.dart';
import 'package:hardware_manufacturing/screen/wishlist_store.dart';




// Palette sampled from the reference design screenshots.
const Color kAppBarBlue = Color(0xff6196c6);
const Color kGradTop = Color(0xff6898cd);
const Color kGradBottom = Color(0xff3b5c79);
const Color kAuthTop = Color(0xff4fb5de);
const Color kAuthBottom = Color(0xff3d8aab);
const Color kAuthPanel = Color(0xffbcd2dc);
const Color kIndigo = Color(0xff5066c6);
const Color kNavy = Color(0xff01224a);
const Color kTileBlue = Color(0xff4977ba);
const Color kGreen = Color(0xff43c437);
const Color kInk = Color(0xff1c2b36);
const Color kTagBlue = Color(0xff173f7a);
const Color kLightBlue = kAppBarBlue;
const Color kMidBlue = Color(0xff1565a8);
const Color kDarkBlue = kGradBottom;
const Color kPageGrey = Color(0xfff5f8fc);

const BoxDecoration kPageGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kGradTop, kGradBottom],
  ),
);

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.missingNote,
  });

  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String? missingNote;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        // Keep the same box if this asset is missing so layout stays unchanged.
        return SizedBox(
          width: width,
          height: height,
          child: ColoredBox(
            color: const Color(0xffe8eef5),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  missingNote ?? 'Add image later: $path',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildTechLogo extends StatelessWidget {
  const BuildTechLogo({super.key, this.width = 132, this.height = 40});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const AppAssetImage(
          path: 'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class BuildTechAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildTechAppBar({
    super.key,
    this.showBackButton = false,
    this.titleText,
    this.onBack,
    this.actions,
  });

  final bool showBackButton;
  final String? titleText;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final trailing = <Widget>[
      IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        icon: const Icon(
          Icons.local_shipping_outlined,
          color: Colors.black87,
          size: 18,
        ),
        tooltip: 'My Orders',
        onPressed: () => Navigator.pushNamed(context, '/orders'),
      ),
      ValueListenableBuilder<int>(
        valueListenable: CartStore.cartChangeNotifier,
        builder: (context, _, child) {
          final count = CartStore.itemCount;
          return Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black87,
                  size: 18,
                ),
                tooltip: 'Cart',
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (count > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: kGreen,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      ValueListenableBuilder<int>(
        valueListenable: WishlistStore.wishlistChangeNotifier,
        builder: (context, _, _) {
          final count = WishlistStore.count;
          return Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black87,
                  size: 18,
                ),
                tooltip: 'Wishlist',
                onPressed: () => Navigator.pushNamed(context, '/wishlist'),
              ),
              if (count > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      ValueListenableBuilder<int>(
        valueListenable: NotificationStore.changeNotifier,
        builder: (context, _, _) {
          final unread = NotificationStore.unreadCount;
          return Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                  size: 18,
                ),
                tooltip: 'Notifications',
                onPressed: () => Navigator.pushNamed(context, '/notifications'),
              ),
              if (unread > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      unread > 9 ? '9+' : '$unread',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        icon: const Icon(Icons.person_outline, color: Colors.black87, size: 18),
        tooltip: 'Profile',
        onPressed: () => Navigator.pushNamed(context, '/profile'),
      ),
    ];

    return Material(
      color: kAppBarBlue,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                if (showBackButton)
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 20,
                    ),
                    onPressed: onBack ?? () => Navigator.maybePop(context),
                  )
                else
                  Builder(
                    builder: (ctx) => IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black87,
                        size: 20,
                      ),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                if (titleText != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        titleText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          ),
                          child: const BuildTechLogo(),
                        ),
                      ),
                    ),
                  ),
                ...?actions,
                if (actions == null || actions!.isEmpty) ...[
                  const SizedBox(width: 2),
                  ...trailing.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: item,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Dark page title shown on the blue gradient under the app bar.
class PageHeading extends StatelessWidget {
  const PageHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: kInk,
        ),
      ),
    );
  }
}

class BuildTechDrawer extends StatelessWidget {
  const BuildTechDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'Home', 'icon': Icons.home_outlined, 'route': '/home'},
      {'label': 'About Us', 'icon': Icons.info_outline, 'route': '/about'},
      {
        'label': 'Products',
        'icon': Icons.grid_view_outlined,
        'route': '/products',
      },
      {
        'label': 'My Cart',
        'icon': Icons.shopping_cart_outlined,
        'route': '/cart',
      },
      {
        'label': 'Checkout',
        'icon': Icons.payment_outlined,
        'route': '/checkout',
      },
      {
        'label': 'Order Details',
        'icon': Icons.receipt_long_outlined,
        'route': '/orders',
      },
      {
        'label': 'My Profile',
        'icon': Icons.person_outline,
        'route': '/profile',
      },
      {
        'label': 'Settings',
        'icon': Icons.settings_outlined,
        'route': '/settings',
      },
      {'label': 'Login', 'icon': Icons.login_outlined, 'route': '/login'},
      {
        'label': 'Create Account',
        'icon': Icons.person_add_outlined,
        'route': '/register',
      },
      {
        'label': 'Forgot Password',
        'icon': Icons.lock_reset_outlined,
        'route': '/forgot-password',
      },
      {'label': 'Admin Panel', 'icon': Icons.admin_panel_settings_outlined, 'route': '/admin/dashboard'},
      {'label': 'Delivery Staff Panel', 'icon': Icons.local_shipping_outlined, 'route': '/delivery/dashboard'},
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kGradTop, kGradBottom],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const BuildTechLogo(width: 150, height: 46),
                const SizedBox(height: 12),
                const Text(
                  'Krutika Sheth',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'shethkrutika8@gmail.com',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ...menuItems.map(
            (item) => ListTile(
              leading: Icon(item['icon'] as IconData, color: kGradBottom),
              title: Text(
                item['label'] as String,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pop();
                final route = item['route'] as String;
                if (route == '/home') {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(route, (r) => false);
                } else {
                  Navigator.of(context).pushNamed(route);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'Dashboard', 'icon': Icons.dashboard_outlined, 'route': '/admin/dashboard'},
      {'label': 'Manage Products', 'icon': Icons.inventory_2_outlined, 'route': '/admin/products'},
      {'label': 'Add Product', 'icon': Icons.add_circle_outline, 'route': '/admin/add-product'},
      {'label': 'Inventory & Orders', 'icon': Icons.warehouse_outlined, 'route': '/admin/inventory'},
      {'label': 'Assign Orders', 'icon': Icons.assignment_turned_in_outlined, 'route': '/admin/assign-orders'},
      {'label': 'Customers', 'icon': Icons.people_outline, 'route': '/admin/customers'},
      {'label': 'Delivery Staff', 'icon': Icons.delivery_dining_outlined, 'route': '/admin/delivery-staff'},
      {'label': 'Notifications', 'icon': Icons.notifications_none, 'route': '/admin/notifications'},
      {'label': 'Admin Profile', 'icon': Icons.account_circle_outlined, 'route': '/admin/profile'},
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF619DCA), Color(0xFF355D7C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const BuildTechLogo(width: 150, height: 46),
                const SizedBox(height: 12),
                const Text(
                  'Admin Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'admin@buildtech.com',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ...menuItems.map(
            (item) => ListTile(
              leading: Icon(item['icon'] as IconData, color: const Color(0xFF355D7C)),
              title: Text(
                item['label'] as String,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pop();
                final route = item['route'] as String;
                Navigator.of(context).pushNamed(route);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.storefront_outlined, color: Color(0xFF355D7C)),
            title: const Text('Customer Store', style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined, color: Color(0xFF355D7C)),
            title: const Text('Delivery Staff Panel', style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/delivery/dashboard', (r) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
            },
          ),
        ],
      ),
    );
  }
}

class DeliveryDrawer extends StatelessWidget {
  const DeliveryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'Dashboard', 'icon': Icons.dashboard_outlined, 'route': '/delivery/dashboard'},
      {'label': 'Assigned Orders', 'icon': Icons.assignment_outlined, 'route': '/delivery/assigned-orders'},
      {'label': 'Delivery Updates', 'icon': Icons.update_outlined, 'route': '/delivery/updates'},
      {'label': 'Order Details', 'icon': Icons.receipt_long_outlined, 'route': '/delivery/order-details'},
      {'label': 'Notifications', 'icon': Icons.notifications_none, 'route': '/delivery/notifications'},
      {'label': 'My Profile', 'icon': Icons.account_circle_outlined, 'route': '/delivery/profile'},
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF67A4D2), Color(0xFF365D7B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const BuildTechLogo(width: 150, height: 46),
                const SizedBox(height: 12),
                const Text(
                  'Delivery Staff Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'delivery@buildtech.com',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ...menuItems.map(
            (item) => ListTile(
              leading: Icon(item['icon'] as IconData, color: const Color(0xFF365D7B)),
              title: Text(
                item['label'] as String,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pop();
                final route = item['route'] as String;
                Navigator.of(context).pushNamed(route);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings_outlined, color: Color(0xFF365D7B)),
            title: const Text('Admin Panel', style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/admin/dashboard', (r) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.storefront_outlined, color: Color(0xFF365D7B)),
            title: const Text('Customer Store', style: TextStyle(fontWeight: FontWeight.w500)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
            },
          ),
        ],
      ),
    );
  }
}

class WishlistHeartButton extends StatelessWidget {
  const WishlistHeartButton({
    super.key,
    required this.productId,
    this.size = 20,
    this.color,
  });

  final String productId;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: WishlistStore.wishlistChangeNotifier,
      builder: (context, _, _) {
        final wished = WishlistStore.isWishlisted(productId);
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: Icon(
            wished ? Icons.favorite : Icons.favorite_border,
            color: wished ? Colors.red : (color ?? Colors.grey.shade500),
            size: size,
          ),
          onPressed: () => WishlistStore.toggle(productId),
        );
      },
    );
  }
}

/// Small green stock pill used on product cards and details.
class StockPill extends StatelessWidget {
  const StockPill(this.label, {super.key, this.fontSize = 9});

  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Blue gradient scaffold used by all in-app (post login) pages.
class BluePageScaffold extends StatelessWidget {
  const BluePageScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer ? const BuildTechDrawer() : null,
      appBar: appBar ?? const BuildTechAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: kPageGradient,
        child: body,
      ),
    );
  }
}

class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    super.key,
    required this.header,
    required this.child,
  });

  final Widget header;
  final Widget child;

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
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 150,
                height: 62,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff4f6fa),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const AppAssetImage(
                  path: 'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
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
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Multicolour-style mail glyph used by the reference email fields.
class GmailIcon extends StatelessWidget {
  const GmailIcon({super.key, this.size = 18});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 6,
      child: Center(
        child: Text(
          'M',
          style: TextStyle(
            color: const Color(0xffea4335),
            fontSize: size,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}

InputDecoration authFieldDecoration(String label, {Widget? prefix}) {
  return InputDecoration(
    hintText: label,
    hintStyle: const TextStyle(fontSize: 13, color: Color(0xff9aa4ad)),
    prefixIcon: prefix,
    filled: true,
    fillColor: const Color(0xfffbfbfd),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: kIndigo, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}

class PrimaryBlueButton extends StatelessWidget {
  const PrimaryBlueButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kIndigo,
          foregroundColor: Colors.white,
          disabledBackgroundColor: kIndigo.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// White rounded pill button used on the dark footers / confirmation page.
class WhitePillButton extends StatelessWidget {
  const WhitePillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.widthFactor = 0.72,
  });

  final String label;
  final VoidCallback? onPressed;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: SizedBox(
        height: 34,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfff2f5fb),
            foregroundColor: kGradBottom,
            disabledBackgroundColor: Colors.white54,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

String formatRupees(double value) => 'Rs. ${value.toStringAsFixed(2)}';
