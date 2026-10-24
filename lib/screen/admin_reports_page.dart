import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/panel_scaffold.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Reports',
      drawer: const AdminDrawer(),
      children: [
        _reportCard('Total Sales', 'Rs. 2,30,000', Icons.trending_up),
        const SizedBox(height: 16),
        _reportCard('Total Orders', '520', Icons.receipt_long),
        const SizedBox(height: 16),
        _reportCard('Total Products', '1250', Icons.inventory_2),
        const SizedBox(height: 16),
        _reportCard('Total Customers', '850', Icons.people),
        const SizedBox(height: 16),
        _reportCard('Pending Orders', '35', Icons.hourglass_empty),
      ],
    );
  }

  Widget _reportCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
