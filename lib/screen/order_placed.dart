import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/order_store.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = OrderStore.lastOrder;
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Order Placed'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xff4caf50),
                    child: Icon(Icons.check, color: Colors.white, size: 34),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Order Placed Successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your order has been placed and is being processed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff33475c),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Order ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xfff7f9fc),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    order?.id ?? '—',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xfff7f9fc),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      _row(
                        'Order Date',
                        order == null ? '—' : _date(order.placedAt),
                      ),
                      _row(
                        'Total Amount',
                        order == null ? '—' : formatRupees(order.total),
                      ),
                      _row('Payment Method', order?.paymentLabel ?? '—'),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                WhitePillButton(
                  label: 'View Order Details',
                  onPressed: () => Navigator.pushNamed(context, '/orders'),
                ),
                const SizedBox(height: 12),
                WhitePillButton(
                  label: 'Continue Shopping',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (r) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _date(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: kInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
