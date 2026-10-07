import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String selectedFilter = 'All';

  final List<Order> orders = const [
    Order(id: 'BTD1234567890', status: 'Processing'),
    Order(id: 'BTD6278364752', status: 'Processing'),
    Order(id: 'BTD6278365778', status: 'Shipped'),
    Order(id: 'BTD6278378689', status: 'Shipped'),
    Order(id: 'BTD6278376432', status: 'Cancelled'),
    Order(id: 'BTD6768364752', status: 'Delivered'),
  ];

  final List<String> filters = [
    'All',
    'Processing',
    'Shipped',
    'Delivered',
  ];

  List<Order> get filteredOrders {
    if (selectedFilter == 'All') {
      return orders;
    }
    return orders.where((order) => order.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Inventory & Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF66A3D1),
              Color(0xFF365D7B),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 14),

              // Filter pills
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final filter in filters)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: _filterButton(filter),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Order List
              Expanded(
                child: filteredOrders.isEmpty
                    ? const Center(
                        child: Text(
                          'No orders in this status',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return _orderCard(order.id, order.status);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterButton(String filter) {
    final bool isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD5DD72) : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              color: isSelected ? const Color(0xFF333300) : Colors.white,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderCard(String orderId, String status) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/delivery/order-details'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.inventory_2_outlined,
                color: Color(0xFF365D7B), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                orderId,
                style: const TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _statusBadge(status),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Processing':
        backgroundColor = const Color(0xFFD1DA72);
        textColor = const Color(0xFF638040);
        break;
      case 'Shipped':
        backgroundColor = const Color(0xFFD1DA72);
        textColor = const Color(0xFF638040);
        break;
      case 'Cancelled':
        backgroundColor = const Color(0xFFFF9FA1);
        textColor = const Color(0xFFFF3F45);
        break;
      case 'Delivered':
        backgroundColor = const Color(0xFF899AE0);
        textColor = const Color(0xFF4B5C9E);
        break;
      default:
        backgroundColor = Colors.grey.shade300;
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Order {
  final String id;
  final String status;

  const Order({
    required this.id,
    required this.status,
  });
}