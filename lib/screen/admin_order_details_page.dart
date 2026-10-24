import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/panel_scaffold.dart';

/// Shared admin page for order details
class OrderDetailsAdminPage extends StatelessWidget {
  const OrderDetailsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Details',
      drawer: const AdminDrawer(),
      children: [
        _infoRow('Order ID', 'BTD1234567890'),
        const SizedBox(height: 12),
        _infoRow('Customer', 'Krutika Sheth'),
        const SizedBox(height: 12),
        _infoRow('Status', 'Processing'),
        const SizedBox(height: 12),
        _infoRow('Amount', 'Rs. 90.50'),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
