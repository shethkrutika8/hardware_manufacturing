import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;

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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _topTitle(),
                    _topBar(),
                    _banner(),
                    _trendingCategories(),
                  ],
                ),
              ),
            ),
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

  // ------------------------------------------------------------
  // HOME PAGE TITLE
  // ------------------------------------------------------------

  Widget _topTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 28, top: 8, bottom: 8),
      child: const Text(
        "Home Page",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xffc7c7c7),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // TOP BAR
  // ------------------------------------------------------------

  Widget _topBar() {
    return Container(
      height: 58,
      color: lightBlue,
      child: Row(
        children: [
          const SizedBox(width: 5),

          // MENU
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, size: 28, color: Colors.black),
          ),

          const SizedBox(width: 2),

          // LOGO
          Container(
            width: 126,
            height: 42,
            color: Colors.white,
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.construction_outlined,
                    color: Color(0xff063a70),
                    size: 24,
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
              size: 24,
            ),
          ),

          // NOTIFICATION
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),

          // FAVORITE
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 25,
            ),
          ),

          const SizedBox(width: 2),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // MAIN BANNER
  // ------------------------------------------------------------

  Widget _banner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Image.asset(
          'assets/images/banner.jpg',
          width: double.infinity,
          height: 193,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _bannerPlaceholder();
          },
        ),
      ),
    );
  }

  // If banner image is not found
  Widget _bannerPlaceholder() {
    return Container(
      height: 193,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff071b2d), Color(0xff145783)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 18,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "BuildTech",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "BUILT STRONG.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  "BUILT TO LAST.",
                  style: TextStyle(
                    color: Color(0xffffc400),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                SizedBox(
                  width: 145,
                  child: Text(
                    "Precision Engineering. Superior Quality. "
                    "Hardware Solutions You Can Trust.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: -10,
            bottom: 0,
            child: Icon(
              Icons.precision_manufacturing,
              size: 145,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // TRENDING CATEGORIES
  // ------------------------------------------------------------

  Widget _trendingCategories() {
    return Container(
      width: double.infinity,
      color: lightBlue,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 18),
      child: Column(
        children: [
          // TITLE ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trending Categories",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff244a72),
                  fontWeight: FontWeight.w500,
                ),
              ),

              GestureDetector(
                onTap: () {
                  // View all categories
                },
                child: const Text(
                  "View More",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff244a72),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // CATEGORY GRID
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 17,
            mainAxisSpacing: 10,
            childAspectRatio: 1.28,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _categoryCard(
                image: 'assets/images/power_tools.jpg',
                title: 'Power Tools',
              ),

              _categoryCard(
                image: 'assets/images/hand_tools.jpg',
                title: 'Hand Tools',
              ),

              _categoryCard(
                image: 'assets/images/fasteners.jpg',
                title: 'Fasteners',
              ),

              _categoryCard(
                image: 'assets/images/abrasives.jpg',
                title: 'Abrasives',
              ),

              _categoryCard(
                image: 'assets/images/door_windows.jpg',
                title: 'Door & Windows Hardware',
              ),

              _categoryCard(
                image: 'assets/images/paint_tools.jpg',
                title: 'Paint & Decorating Tools',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // CATEGORY CARD
  // ------------------------------------------------------------

  Widget _categoryCard({required String image, required String title}) {
    return GestureDetector(
      onTap: () {
        // Open category
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
