import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Admin Dashboard — reachable via /admin/dashboard
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
            onPressed: () =>
                Navigator.pushNamed(context, '/admin/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Admin Profile',
            onPressed: () => Navigator.pushNamed(context, '/admin/profile'),
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
            colors: [Color(0xFF619DCA), Color(0xFF355D7C)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Logo ──
              const Center(child: BuildTechLogo(width: 180, height: 60)),
              const SizedBox(height: 20),

              // ── Stat cards grid ──
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.4,
                children: const [
                  _StatCard(
                    title: 'Total Products',
                    value: '1250',
                    icon: Icons.inventory_2,
                    route: '/admin/products',
                  ),
                  _StatCard(
                    title: 'Total Orders',
                    value: '520',
                    icon: Icons.receipt_long,
                    route: '/admin/inventory',
                  ),
                  _StatCard(
                    title: 'Customers',
                    value: '850',
                    icon: Icons.people,
                    route: '/admin/customers',
                  ),
                  _StatCard(
                    title: 'Revenue',
                    value: 'Rs. 2300',
                    icon: Icons.currency_rupee,
                    route: '/admin/reports',
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Quick Actions ──
              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _quickAction(
                context,
                icon: Icons.add_circle_outline,
                label: 'Add Product',
                route: '/admin/add-product',
              ),
              const SizedBox(height: 10),
              _quickAction(
                context,
                icon: Icons.assignment_turned_in_outlined,
                label: 'Assign Orders',
                route: '/admin/assign-orders',
              ),
              const SizedBox(height: 10),
              _quickAction(
                context,
                icon: Icons.warehouse_outlined,
                label: 'Inventory & Orders',
                route: '/admin/inventory',
              ),
              const SizedBox(height: 10),
              _quickAction(
                context,
                icon: Icons.category_outlined,
                label: 'Manage Categories',
                route: '/admin/categories',
              ),

              const SizedBox(height: 22),

              // ── Sales overview ──
              const Text(
                'Sales Overview',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 130,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomPaint(painter: SalesChartPainter()),
              ),

              const SizedBox(height: 22),

              // ── Recent orders ──
              const Text(
                'Recent Orders',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _orderRow('BTD1234567890', 'Rs. 90.50'),
                    const Divider(height: 1),
                    _orderRow('BTD6278364752', 'Rs. 120.00'),
                    const Divider(height: 1),
                    _orderRow('BTD6278365778', 'Rs. 45.00'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickAction(
      BuildContext context, {
      required IconData icon,
      required String label,
      required String route,
    }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _orderRow(String orderId, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.receipt_long, color: Color(0xFF355D7C), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              orderId,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// STAT CARD
// ─────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.route,
  });

  final String title;
  final String value;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF619DCA), size: 22),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C2B36),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// SALES CHART PAINTER
// ─────────────────────────────────────────────────────────────────
class SalesChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 0.7;

    final barPaint = Paint()..color = const Color(0xFF4E8AB8);

    final linePaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 4; i++) {
      final y = size.height - (i * size.height / 5);
      canvas.drawLine(
          Offset(25, y), Offset(size.width - 8, y), axisPaint);
    }

    canvas.drawLine(
        const Offset(25, 5), Offset(25, size.height - 10), axisPaint);
    canvas.drawLine(Offset(25, size.height - 10),
        Offset(size.width - 8, size.height - 10), axisPaint);

    final barCount = 5;
    final availW = size.width - 45.0;
    final barW = (availW / barCount) * 0.5;
    final gap = (availW / barCount);
    final heights = [0.45, 0.78, 0.62, 0.42, 0.56];

    for (int i = 0; i < barCount; i++) {
      final h = (size.height - 15) * heights[i];
      final left = 30.0 + i * gap;
      canvas.drawRect(
        Rect.fromLTWH(left, size.height - 10 - h, barW, h),
        barPaint,
      );
    }

    final path = Path()
      ..moveTo(30, size.height - 10 - (size.height - 15) * 0.45)
      ..cubicTo(
        30 + gap * 0.5, size.height * 0.15,
        30 + gap * 0.9, size.height * 0.1,
        30 + gap, size.height - 10 - (size.height - 15) * 0.78,
      )
      ..cubicTo(
        30 + gap * 1.5, size.height * 0.25,
        30 + gap * 1.9, size.height * 0.35,
        30 + gap * 2, size.height - 10 - (size.height - 15) * 0.62,
      );
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
