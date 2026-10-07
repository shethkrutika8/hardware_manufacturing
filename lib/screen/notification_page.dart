import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
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
              Color(0xFF67A4D2),
              Color(0xFF365D7B),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              _notificationCard(
                icon: _circleIcon(
                  icon: Icons.check,
                  backgroundColor: const Color(0xFF45B454),
                  iconColor: Colors.white,
                ),
                title: 'New Order Received',
                subtitle: 'Order ID: BTD1234567890',
                time: '10 min ago',
              ),
              const SizedBox(height: 14),
              _notificationCard(
                icon: _warningIcon(),
                title: 'Low Stock Alert',
                subtitle: 'Hand Tools (only 15 items left in stock)',
                time: '1 hour ago',
              ),
              const SizedBox(height: 14),
              _notificationCard(
                icon: _paymentFailedIcon(),
                title: 'Payment Failed',
                subtitle: 'Order BTD2435462753 - Transaction failed',
                time: '3 hours ago',
              ),
              const SizedBox(height: 14),
              _notificationCard(
                icon: _systemUpdateIcon(),
                title: 'System Update Completed',
                subtitle: 'New inventory tracking module is now live',
                time: 'Yesterday',
              ),
              const SizedBox(height: 14),
              _notificationCard(
                icon: _circleIcon(
                  icon: Icons.local_shipping,
                  backgroundColor: const Color(0xFF6BA8DF),
                  iconColor: Colors.white,
                ),
                title: 'Delivery Staff Dispatched',
                subtitle: 'Order BTD6278364752 is out for delivery',
                time: 'Yesterday',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _notificationCard({
    required Widget icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Center(child: icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _circleIcon({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 22,
      ),
    );
  }

  static Widget _warningIcon() {
    return SizedBox(
      width: 36,
      height: 36,
      child: CustomPaint(
        painter: WarningPainter(),
      ),
    );
  }

  static Widget _paymentFailedIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFFFF4540),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.credit_card_off,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  static Widget _systemUpdateIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF67A4D2).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.system_update_alt,
        color: Color(0xFF365D7B),
        size: 20,
      ),
    );
  }
}

class WarningPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFFFB000)
      ..style = PaintingStyle.fill;

    final Path triangle = Path();
    triangle.moveTo(size.width / 2, 3);
    triangle.lineTo(size.width - 2, size.height - 3);
    triangle.lineTo(2, size.height - 3);
    triangle.close();
    canvas.drawPath(triangle, paint);

    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width / 2, 12),
      Offset(size.width / 2, 22),
      whitePaint,
    );

    canvas.drawCircle(
      Offset(size.width / 2, 27),
      1.4,
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}