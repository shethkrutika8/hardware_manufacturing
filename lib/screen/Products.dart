import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final Color lightBlue = const Color(0xff66a3d8);
  final Color darkBlue = const Color(0xff063a70);

  final List<Map<String, dynamic>> products = [
    {
      "name": "Hex Nut",
      "size": "M12 * 40 mm",
      "price": "Rs. 15.50/pcs",
      "image": "assets/images/hex_nut.jpg",
    },
    {
      "name": "Phillips Screw",
      "size": "4.2*25 mm",
      "price": "Rs. 21.89/pcs",
      "image": "assets/images/phillips_screw.jpg",
    },
    {
      "name": "Hex Bolt",
      "size": "M12",
      "price": "Rs. 15.50/pcs",
      "image": "assets/images/hex_bolt.jpg",
    },
    {
      "name": "HSS Drill Bit",
      "size": "6.0 mm",
      "price": "Rs. 10.00/pcs",
      "image": "assets/images/drill_bit.jpg",
    },
    {
      "name": "Anchor Bolt",
      "size": "M12 * 75 mm",
      "price": "Rs. 80.00/pcs",
      "image": "assets/images/anchor_bolt.jpg",
    },
  ];

  final Set<int> favouriteProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f5f5),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            _pageTitle(),
            _topBar(),

            Expanded(
              child: Container(
                color: lightBlue,
                child: Column(
                  children: [
                    _productsTitle(),
                    _filterBar(),

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 12,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return _productCard(index, products[index]);
                        },
                      ),
                    ),
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
  // PAGE TITLE
  // ------------------------------------------------------------

  Widget _pageTitle() {
    return Container(
      width: double.infinity,
      height: 28,
      padding: const EdgeInsets.only(left: 7),
      color: const Color(0xfff8f5f5),
      alignment: Alignment.centerLeft,
      child: const Text(
        "Products",
        style: TextStyle(color: Color(0xffbdbdbd), fontSize: 16),
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
          const SizedBox(width: 3),

          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.menu, color: Colors.black, size: 24),
            ),
          ),

          const SizedBox(width: 2),

          // LOGO
          Container(
            width: 90,
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
                    size: 18,
                  ),
                );
              },
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.local_shipping_outlined,
              color: Colors.black,
              size: 22,
            ),
          ),

          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 22,
            ),
          ),

          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 22,
            ),
          ),

          const SizedBox(width: 3),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // PRODUCTS TITLE
  // ------------------------------------------------------------

  Widget _productsTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 7),
      child: const Text(
        "Products",
        style: TextStyle(color: Color(0xff214b73), fontSize: 11),
      ),
    );
  }

  // ------------------------------------------------------------
  // FILTER BAR
  // ------------------------------------------------------------

  Widget _filterBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, bottom: 7),
      child: Row(
        children: [
          // FILTER
          _filterButton(
            icon: Icons.tune,
            text: "Filter",
            onTap: () {
              _showFilterDialog();
            },
          ),

          const SizedBox(width: 5),

          // CATEGORY
          Expanded(
            child: Container(
              height: 28,
              color: Colors.white,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      "All Categories",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      _showCategoryMenu();
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 25,
                      minHeight: 28,
                    ),
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 5),

          // SORT
          _filterButton(
            icon: Icons.swap_vert,
            text: "Sort",
            onTap: () {
              _showSortMenu();
            },
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // FILTER BUTTON
  // ------------------------------------------------------------

  Widget _filterButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        child: Row(
          children: [
            Icon(icon, size: 17, color: Colors.black),
            const SizedBox(width: 3),
            Text(
              text,
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PRODUCT CARD
  // ------------------------------------------------------------

  Widget _productCard(int index, Map<String, dynamic> product) {
    bool isFavourite = favouriteProducts.contains(index);

    return Container(
      height: 91,
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          // ----------------------------------------------------
          // PRODUCT IMAGE
          // ----------------------------------------------------
          Container(
            width: 55,
            height: 82,
            margin: const EdgeInsets.only(left: 3, top: 4, bottom: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product["image"],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xffeeeeee),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 5),

          // ----------------------------------------------------
          // PRODUCT INFORMATION
          // ----------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    product["size"],
                    style: const TextStyle(color: Colors.grey, fontSize: 8),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    product["price"],
                    style: const TextStyle(color: Colors.black, fontSize: 8),
                  ),

                  const SizedBox(height: 3),

                  // IN STOCK
                  Container(
                    width: 48,
                    height: 13,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff49bd45),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.black, fontSize: 7),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ----------------------------------------------------
          // RIGHT SIDE BUTTONS
          // ----------------------------------------------------
          SizedBox(
            width: 34,
            child: Column(
              children: [
                // FAVOURITE
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isFavourite) {
                        favouriteProducts.remove(index);
                      } else {
                        favouriteProducts.add(index);
                      }
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 38,
                  ),
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : Colors.black,
                    size: 19,
                  ),
                ),

                // ADD
                GestureDetector(
                  onTap: () {
                    _addToCart(product);
                  },
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.add, size: 15, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ADD TO CART
  // ------------------------------------------------------------

  void _addToCart(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${product["name"]} added to cart",
          style: const TextStyle(fontSize: 12),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ------------------------------------------------------------
  // FILTER DIALOG
  // ------------------------------------------------------------

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filter Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              CheckboxListTile(
                title: const Text("In Stock"),
                value: true,
                onChanged: (value) {},
              ),

              CheckboxListTile(
                title: const Text("Power Tools"),
                value: false,
                onChanged: (value) {},
              ),

              CheckboxListTile(
                title: const Text("Hand Tools"),
                value: false,
                onChanged: (value) {},
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // CATEGORY MENU
  // ------------------------------------------------------------

  void _showCategoryMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: const [
            ListTile(title: Text("All Categories")),
            ListTile(title: Text("Power Tools")),
            ListTile(title: Text("Hand Tools")),
            ListTile(title: Text("Fasteners")),
            ListTile(title: Text("Abrasives")),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SORT MENU
  // ------------------------------------------------------------

  void _showSortMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: const [
            ListTile(
              leading: Icon(Icons.arrow_upward),
              title: Text("Price: Low to High"),
            ),
            ListTile(
              leading: Icon(Icons.arrow_downward),
              title: Text("Price: High to Low"),
            ),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text("Name: A to Z"),
            ),
            ListTile(
              leading: Icon(Icons.sort_by_alpha),
              title: Text("Name: Z to A"),
            ),
          ],
        );
      },
    );
  }
}
