import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int selectedIndex = 0;

  final Color blue = const Color(0xff1565a8);
  final Color lightBlue = const Color(0xff66a3d8);
  final Color darkBlue = const Color(0xff063a70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _topTitle(),
                    _topBar(),
                    _aboutHeader(),
                    _missionCard(),
                    _statistics(),
                    _contactSection(),
                  ],
                ),
              ),
            ),
            _bottomNavigation(),
          ],
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

  // ----------------------------------------------------------
  // TOP TITLE
  // ----------------------------------------------------------

  Widget _topTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 28, top: 8, bottom: 8),
      child: const Text(
        "About Us",
        style: TextStyle(
          fontSize: 18,
          color: Color(0xffc7c7c7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // TOP BAR
  // ----------------------------------------------------------

  Widget _topBar() {
    return Builder(
      builder: (context) {
        return Container(
          height: 58,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          color: lightBlue,
          child: Row(
            children: [
              const SizedBox(width: 12),

              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, size: 28, color: Colors.black),
              ),

              const SizedBox(width: 4),

              // LOGO
              Container(
                height: 42,
                width: 155,
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

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.local_shipping_outlined,
                  color: Colors.black,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Colors.black),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Colors.black),
              ),

              const SizedBox(width: 3),
            ],
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // ABOUT HEADER
  // ----------------------------------------------------------

  Widget _aboutHeader() {
    return Container(
      width: double.infinity,
      color: lightBlue,
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About us",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            "Building a Better Tomorrow",
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "BuildTech Hardware is your trusted partner\n"
            "quality tools and hardware for every\n"
            "object, big or small.",
            style: TextStyle(color: Colors.white, fontSize: 9, height: 1.25),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _trustCard(
                  Icons.verified_user_outlined,
                  "Quality",
                  "You Can Trust",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _trustCard(
                  Icons.construction_outlined,
                  "Tools for",
                  "Every Need",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _trustCard(
                  Icons.support_agent,
                  "Supporting",
                  "Every Builder",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _trustCard(
                  Icons.workspace_premium_outlined,
                  "Built for",
                  "Building Better",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TRUST CARD
  // ----------------------------------------------------------

  Widget _trustCard(IconData icon, String title, String subtitle) {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: const Color(0xff3971c5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 17),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 7),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // MISSION CARD
  // ----------------------------------------------------------

  Widget _missionCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 7),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Expanded(
            flex: 5,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xff125a94),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/BuildTech_hardware_picture.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.storefront,
                        size: 75,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(width: 9),

          // TEXT
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Our Mission",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "To provide durable, reliable, and\n"
                  "affordable hardware solution that\n"
                  "empower professional and DIY\n"
                  "enthusiasts to build a better\n"
                  "tomorrow.",
                  style: TextStyle(fontSize: 8, height: 1.25),
                ),

                const SizedBox(height: 13),

                Container(height: 1, color: Colors.grey.shade400),

                const SizedBox(height: 12),

                const Text(
                  "Our Promise",
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Quality products, Honest\n"
                  "Service.\n"
                  "Trusted by Builders.",
                  style: TextStyle(fontSize: 8, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // STATISTICS
  // ----------------------------------------------------------

  Widget _statistics() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
      decoration: BoxDecoration(
        color: const Color(0xfff5f7f9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff063a70), width: 5),
      ),
      child: Row(
        children: [
          _stat(Icons.people_alt_outlined, "10K+", "Happy Customers"),
          _stat(Icons.inventory_2_outlined, "5K+", "Products"),
          _stat(Icons.location_on_outlined, "50+", "Cities Served"),
          _stat(Icons.verified_outlined, "100%", "Trusted Partner"),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String number, String title) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xff0756a0)),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff063a70),
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 5, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ----------------------------------------------------------
  // CONTACT / ABOUT US IMAGE SECTION
  // ----------------------------------------------------------

  Widget _contactSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 7, 7, 0),
      decoration: BoxDecoration(
        color: const Color(0xff063a70),
        borderRadius: BorderRadius.circular(8),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),

        child: Image.asset(
          'assets/About_us.png',
          width: double.infinity,
          fit: BoxFit.contain,

          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 180,
              child: Center(
                child: Text(
                  "About Us image not found",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // BOTTOM NAVIGATION
  // ----------------------------------------------------------

  Widget _bottomNavigation() {
    return NavigationBar(
      height: 65,
      selectedIndex: selectedIndex,
      backgroundColor: const Color(0xff8dbbe2),
      indicatorColor: Colors.transparent,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: "Categories",
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          label: "Cart",
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: "Orders",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
