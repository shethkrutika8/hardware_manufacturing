import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Delivery Dashboard — reachable via /delivery/dashboard
class DeliveryDashboardPage extends StatelessWidget {
  const DeliveryDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DeliveryDrawer(),
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
                Navigator.pushNamed(context, '/delivery/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'My Profile',
            onPressed: () =>
                Navigator.pushNamed(context, '/delivery/profile'),
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
            colors: [Color(0xFF67A4D2), Color(0xFF365D7B)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Logo ──
              const Center(child: BuildTechLogo(width: 180, height: 60)),
              const SizedBox(height: 20),

              // ── Stat cards ──
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.4,
                children: const [
                  _DelivStatCard(
                    title: 'Assigned Orders',
                    value: '1250',
                    icon: Icons.assignment,
                    route: '/delivery/assigned-orders',
                  ),
                  _DelivStatCard(
                    title: 'Completed',
                    value: '520',
                    icon: Icons.check_circle_outline,
                    route: '/delivery/delivered',
                  ),
                  _DelivStatCard(
                    title: "Today's Deliveries",
                    value: '7',
                    icon: Icons.local_shipping,
                    route: '/delivery/updates',
                  ),
                  _DelivStatCard(
                    title: 'On the Way',
                    value: '3',
                    icon: Icons.delivery_dining,
                    route: '/delivery/out-for-delivery',
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Today's deliveries summary ──
              const Text(
                "Today's Deliveries",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Completed',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '7',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'On Time',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '100%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF365D7B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Pending',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ── Quick Actions ──
              const Text(
                'Quick Actions',
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              _actionTile(context, Icons.assignment_outlined, 'Assigned Orders', '/delivery/assigned-orders'),
              const SizedBox(height: 10),
              _actionTile(context, Icons.update_outlined, 'Delivery Updates', '/delivery/updates'),
              const SizedBox(height: 10),
              _actionTile(context, Icons.receipt_long_outlined, 'Order Details', '/delivery/order-details'),

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

  Widget _actionTile(BuildContext context, IconData icon, String label, String route) {
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
                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
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
          const Icon(Icons.local_shipping, color: Color(0xFF365D7B), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(orderId,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(price, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _DelivStatCard extends StatelessWidget {
  const _DelivStatCard({
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
            Icon(icon, color: const Color(0xFF67A4D2), size: 22),
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
            Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}