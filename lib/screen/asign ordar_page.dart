import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class AssignOrdersPage extends StatefulWidget {
  const AssignOrdersPage({super.key});

  @override
  State<AssignOrdersPage> createState() => _AssignOrdersPageState();
}

class _AssignOrdersPageState extends State<AssignOrdersPage> {
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'In Progress', 'Upcoming'];

  final List<_OrderItem> orders = const [
    _OrderItem(id: 'BTD1234567890', status: 'Pick Up'),
    _OrderItem(id: 'BTD6278364752', status: 'In Progress'),
    _OrderItem(id: 'BTD6278365778', status: 'Pending'),
    _OrderItem(id: 'BTD6278378689', status: 'Upcoming'),
    _OrderItem(id: 'BTD6278376432', status: 'Cancelled'),
    _OrderItem(id: 'BTD6768364752', status: 'Delivered'),
  ];

  List<_OrderItem> get filteredOrders {
    if (selectedFilter == 'All') return orders;
    if (selectedFilter == 'In Progress') {
      return orders.where((o) => o.status == 'In Progress').toList();
    }
    if (selectedFilter == 'Upcoming') {
      return orders.where((o) => o.status == 'Upcoming').toList();
    }
    return orders;
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
          'Assign Orders',
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
            colors: [Color(0xFF66A3D1), Color(0xFF365D7B)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Filter row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: filters.map((f) {
                    final selected = selectedFilter == f;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedFilter = f),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFFD1D970)
                                : Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            f,
                            style: TextStyle(
                              color: selected
                                  ? const Color(0xFF444400)
                                  : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              // Orders list
              Expanded(
                child: filteredOrders.isEmpty
                    ? const Center(
                        child: Text(
                          'No orders found.',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return _buildOrderCard(context, order);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, _OrderItem order) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/delivery/order-details'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.receipt_long, color: Color(0xFF365D7B), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                order.id,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            _statusBadge(order.status),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bg;
    Color fg;
    switch (status) {
      case 'Pick Up':
      case 'In Progress':
      case 'Pending':
      case 'Upcoming':
        bg = const Color(0xFFD1DA72);
        fg = const Color(0xFF637D3F);
        break;
      case 'Cancelled':
        bg = const Color(0xFFFF9FA2);
        fg = const Color(0xFFFF4147);
        break;
      case 'Delivered':
        bg = const Color(0xFF899AE0);
        fg = const Color(0xFF4E5FA4);
        break;
      default:
        bg = Colors.grey.shade200;
        fg = Colors.black;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status,
          style:
              TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _OrderItem {
  const _OrderItem({required this.id, required this.status});
  final String id;
  final String status;
}