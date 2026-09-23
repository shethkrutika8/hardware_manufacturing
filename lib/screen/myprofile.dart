import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f6f6),
      drawer: _buildDrawer(context),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff66a3d8), Color(0xff365b7b)],
            ),
          ),

          child: Column(
            children: [
              // HEADER
              _header(),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 18,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE
                        const Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // PROFILE INFORMATION
                        _profileBox(),

                        const SizedBox(height: 15),

                        // MENU
                        _menuBox(),

                        const SizedBox(height: 30),
                      ],
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

  Widget _buildDrawer(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'label': 'Home', 'icon': Icons.home_outlined, 'route': '/home'},
      {'label': 'About Us', 'icon': Icons.info_outline, 'route': '/about'},
      {
        'label': 'Products',
        'icon': Icons.grid_view_outlined,
        'route': '/products',
      },
      {'label': 'Cart', 'icon': Icons.shopping_cart_outlined, 'route': '/cart'},
      {
        'label': 'Orders',
        'icon': Icons.receipt_long_outlined,
        'route': '/orders',
      },
      {
        'label': 'Checkout',
        'icon': Icons.payment_outlined,
        'route': '/checkout',
      },
      {'label': 'Profile', 'icon': Icons.person_outline, 'route': '/profile'},
      {
        'label': 'Settings',
        'icon': Icons.settings_outlined,
        'route': '/settings',
      },
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xff1565a8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.construction_outlined,
                  color: Colors.white,
                  size: 34,
                ),
                SizedBox(height: 12),
                Text(
                  'BuildTech Hardware',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...menuItems.map(
            (item) => ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: const Color(0xff063a70),
              ),
              title: Text(item['label'] as String),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(item['route'] as String);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 70,
      color: const Color(0xff66a3d8),

      child: Row(
        children: [
          const SizedBox(width: 15),

          // MENU
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black, size: 28),
            ),
          ),

          const SizedBox(width: 10),

          // LOGO
          Container(
            width: 145,
            height: 45,
            color: Colors.white,
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.construction_outlined,
                    size: 24,
                    color: Color(0xff063a70),
                  ),
                );
              },
            ),
          ),

          const Spacer(),

          // DELIVERY
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.local_shipping_outlined,
              color: Colors.black,
              size: 27,
            ),
          ),

          const SizedBox(width: 10),

          // NOTIFICATION
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 29,
            ),
          ),

          const SizedBox(width: 10),

          // FAVORITE
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 29,
            ),
          ),

          const SizedBox(width: 15),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE BOX
  // ==========================================================

  Widget _profileBox() {
    return Container(
      width: double.infinity,
      height: 85,
      color: Colors.white,

      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Row(
        children: [
          // PROFILE CIRCLE
          Container(
            width: 65,
            height: 65,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffd878c5),
            ),

            alignment: Alignment.center,

            child: const Text(
              "KS",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 18),

          // NAME + EMAIL
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Krutika Sheth",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 4),

              Text(
                "abcd@gmail.com",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MENU BOX
  // ==========================================================

  Widget _menuBox() {
    return Container(
      width: double.infinity,
      color: Colors.white,

      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Column(
        children: [
          _menuItem(
            icon: Icons.co_present_outlined,
            title: "Edit Profile",
            onTap: () {},
          ),

          _divider(),

          _menuItem(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {},
          ),

          _divider(),

          _menuItem(
            icon: Icons.account_balance_wallet_outlined,
            title: "Payment Methods",
            onTap: () {},
          ),

          _divider(),

          _menuItem(
            icon: Icons.favorite_border,
            title: "Wishlist",
            onTap: () {},
          ),

          _divider(),

          _menuItem(
            icon: Icons.assignment_outlined,
            title: "Orders",
            onTap: () {},
          ),

          _divider(),

          _menuItem(icon: Icons.settings, title: "Settings", onTap: () {}),
        ],
      ),
    );
  }

  // ==========================================================
  // MENU ITEM
  // ==========================================================

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: SizedBox(
        height: 65,

        child: Row(
          children: [
            SizedBox(
              width: 40,

              child: Icon(icon, size: 24, color: Colors.black),
            ),

            const SizedBox(width: 18),

            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DIVIDER
  // ==========================================================

  Widget _divider() {
    return Container(height: 1, color: Colors.grey.shade500);
  }
}
