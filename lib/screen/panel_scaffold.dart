import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Generic gradient scaffold used by both admin and delivery sub-pages.
class PanelPage extends StatelessWidget {
  const PanelPage({
    super.key,
    required this.title,
    required this.children,
    required this.drawer,
  });

  final String title;
  final List<Widget> children;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradTop, kGradBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Order tile used across delivery and admin order list pages.
class PanelOrderTile extends StatelessWidget {
  const PanelOrderTile({
    super.key,
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  final String orderId;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.receipt_long, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                orderId,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: statusColor, width: 1),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
