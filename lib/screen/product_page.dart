import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Manage Products — reachable via /admin/products
class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  final List<ManageProductItem> products = const [
    ManageProductItem(name: 'HSS Drill Bit', price: 'Rs. 10.00/pcs', quantity: '50'),
    ManageProductItem(name: 'Hex Nut', price: 'Rs. 15.50/pcs', quantity: '30'),
    ManageProductItem(name: 'Flat Washer', price: 'Rs. 8.00/pcs', quantity: '50'),
    ManageProductItem(name: 'Hex Bolt', price: 'Rs. 15.50/pcs', quantity: '40'),
    ManageProductItem(name: 'Allen Key', price: 'Rs. 25.00/pcs', quantity: '20'),
    ManageProductItem(name: 'Power Drill', price: 'Rs. 850.00', quantity: '10'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Manage Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Product',
            onPressed: () =>
                Navigator.pushNamed(context, '/admin/add-product'),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF659FCA), Color(0xFF355D7C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Search + Add ──
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey, size: 20),
                            SizedBox(width: 8),
                            Text('Search Product',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/admin/add-product'),
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          children: [
                            Icon(Icons.add,
                                color: Color(0xFF355D7C), size: 20),
                            SizedBox(width: 4),
                            Text(
                              'Add',
                              style: TextStyle(
                                  color: Color(0xFF355D7C),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Table header ──
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 4),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 3,
                      child: Text('Product',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Price',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Qty',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // ── Product list ──
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(p.name,
                                style: const TextStyle(fontSize: 12)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(p.price,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(p.quantity,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class ManageProductItem {
  const ManageProductItem({
    required this.name,
    required this.price,
    required this.quantity,
  });
  final String name;
  final String price;
  final String quantity;
}