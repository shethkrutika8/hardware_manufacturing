import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/order_store.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Order Details'),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: OrderStore.changeNotifier,
              builder: (context, _, _) {
                final order = OrderStore.lastOrder;
                if (order == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No order yet. Complete checkout to see order details here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 18),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff7f9fc),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.id,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: kInk,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Order Placed, ${_date(order.placedAt)}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Color(0xff5c6b76),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const StockPill('Confirmed', fontSize: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xfff7f9fc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 16,
                                color: kIndigo,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Delivery Address',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: kInk,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Address changes are disabled for placed orders.',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: kIndigo,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.customerName,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: kIndigo,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.address.replaceAll(', ', ',\n'),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xff5c6b76),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            order.phone,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xff5c6b76),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Items',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kInk,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final item in order.items)
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xfff7f9fc),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 56,
                                  height: 50,
                                  child: AppAssetImage(
                                    path: item.product.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.product.numericPrice.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontSize: 7,
                                    color: Color(0xff8fa8c8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff22303c),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Qty: ${item.quantity}',
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xff5c6b76),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              formatRupees(item.lineTotal),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff22303c),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xfff7f9fc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: kInk,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _row('Subtotal', formatRupees(order.subtotal)),
                          _row('GST (18%)', formatRupees(order.tax)),
                          _row(
                            'Delivery Charges',
                            order.shipping == 0
                                ? 'Free'
                                : formatRupees(order.shipping),
                          ),
                          const SizedBox(height: 2),
                          _row('Total', formatRupees(order.total), bold: true),
                          const SizedBox(height: 6),
                          Text(
                            order.paymentLabel,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xff8a97a1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontSize: bold ? 11 : 9,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      color: bold ? kInk : const Color(0xff5c6b76),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
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
}
