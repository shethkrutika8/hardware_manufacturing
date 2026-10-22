import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Admin Order Details (delivery view) — reachable via /delivery/order-details
class DeliveryOrderDetailsScreen extends StatelessWidget {
  const DeliveryOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DeliveryDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Details',
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
            colors: [Color(0xFF67A4D2), Color(0xFF365D7B)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Order ID ──
              _infoCard(
                child: Center(
                  child: Text(
                    'BTD1234567890',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Customer & address ──
              _infoCard(
                child: Column(
                  children: [
                    _row('Customer', 'Krutika Sheth'),
                    const Divider(height: 20),
                    _row('Phone', '+91 98765 43210'),
                    const Divider(height: 20),
                    _row('Address',
                        '12, MG Road, Rajkot, Gujarat – 360 001'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Order items ──
              _infoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Items',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    _itemRow('HSS Drill Bit', '2 pcs', 'Rs. 20.00'),
                    const Divider(height: 14),
                    _itemRow('Hex Nut M8', '10 pcs', 'Rs. 35.00'),
                    const Divider(height: 14),
                    _itemRow('Flat Washer', '5 pcs', 'Rs. 12.00'),
                    const Divider(height: 14),
                    const Row(
                      children: [
                        Spacer(),
                        Text(
                          'Total: Rs. 67.00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Action buttons ──
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF365D7B),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.update),
                label: const Text(
                  'Update Delivery Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, '/delivery/updates'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white54),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Assigned Orders'),
                onPressed: () => Navigator.pushNamed(
                    context, '/delivery/assigned-orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
        ),
      ],
    );
  }

  Widget _itemRow(String name, String qty, String price) {
    return Row(
      children: [
        Expanded(
          child: Text(name, style: const TextStyle(fontSize: 13)),
        ),
        Text(qty,
            style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(width: 12),
        Text(price,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}