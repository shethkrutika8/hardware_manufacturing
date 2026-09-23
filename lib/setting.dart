import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              // ================================
              // HEADER
              // ================================
              _header(),

              // ================================
              // MAIN CONTENT
              // ================================
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // SETTINGS BOX
                        Container(
                          width: double.infinity,
                          color: Colors.white,

                          child: Column(
                            children: [
                              _settingItem(
                                icon: Icons.person_outline,
                                title: "Edit Profile",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.lock_outline,
                                title: "Change Password",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.notifications_none,
                                title: "Notification",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.language,
                                title: "Languages",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.format_paint_outlined,
                                title: "Themes",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.info_outline,
                                title: "About Us",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.support_agent,
                                title: "Help & Support",
                                onTap: () {},
                              ),

                              _divider(),

                              _settingItem(
                                icon: Icons.logout,
                                title: "Log Out",
                                logout: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),

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

  // ==========================================================
  // HEADER
  // ==========================================================

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

  Widget _header() {
    return Container(
      width: double.infinity,
      height: 75,

      color: const Color(0xff66a3d8),

      child: Row(
        children: [
          const SizedBox(width: 20),

          // MENU
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.black, size: 32),
            ),
          ),

          const SizedBox(width: 15),

          // ================================
          // LOGO
          // ================================
          Container(
            width: 165,
            height: 55,
            color: Colors.white,
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.construction_outlined,
                    size: 28,
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
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          // NOTIFICATION
          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 32,
            ),
          ),

          const SizedBox(width: 15),

          // FAVORITE
          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 32,
            ),
          ),

          const SizedBox(width: 25),
        ],
      ),
    );
  }

  // ==========================================================
  // SETTING ITEM
  // ==========================================================

  Widget _settingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool logout = false,
  }) {
    return InkWell(
      onTap: onTap,

      child: Container(
        height: 65,

        padding: const EdgeInsets.symmetric(horizontal: 30),

        child: Row(
          children: [
            Icon(
              icon,
              size: 28,

              color: logout ? Colors.redAccent : Colors.black,
            ),

            const SizedBox(width: 45),

            Text(
              title,

              style: TextStyle(
                fontSize: 15,

                color: logout ? Colors.redAccent : Colors.black,
              ),
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
    return Container(
      height: 1,

      margin: const EdgeInsets.symmetric(horizontal: 20),

      color: Colors.grey.shade500,
    );
  }
}
