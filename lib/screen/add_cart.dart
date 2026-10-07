import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('My Cart'),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: CartStore.cartChangeNotifier,
              builder: (context, _, _) {
                final cartItems = CartStore.items;
                if (cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your cart is empty',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        WhitePillButton(
                          label: 'Browse Products',
                          widthFactor: 0.6,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/products'),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Column(
                      children: [
                        _itemCard(item, index),
                        Container(
                          width: double.infinity,
                          height: 14,
                          color: const Color(0xff4176a8),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.product.name,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: CartStore.cartChangeNotifier,
            builder: (context, _, _) {
              final empty = CartStore.items.isEmpty;
              return Container(
                width: double.infinity,
                color: kGradBottom,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                child: Column(
                  children: [
                    _totalRow('Sub Total', formatRupees(CartStore.subtotal)),
                    const SizedBox(height: 4),
                    _totalRow('GST (18%)', formatRupees(CartStore.tax)),
                    const SizedBox(height: 4),
                    _totalRow(
                      'Total',
                      formatRupees(CartStore.cartTotal),
                      bold: true,
                    ),
                    const SizedBox(height: 14),
                    WhitePillButton(
                      label: 'Proceed To Checkout',
                      onPressed: empty
                          ? null
                          : () => Navigator.pushNamed(context, '/checkout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _totalRow(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      color: Colors.white,
      fontSize: bold ? 12 : 10,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }

  Widget _itemCard(CartItem item, int index) {
    return Container(
      color: const Color(0xfff7f9fc),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 92,
            child: AppAssetImage(path: item.product.image, fit: BoxFit.contain),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff22303c),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.price,
                  style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'In Stock',
                  style: TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _qtyButton(Icons.remove, () => CartStore.decrement(index)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _qtyButton(Icons.add, () => CartStore.increment(index)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => CartStore.removeItem(index),
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                formatRupees(item.totalPrice),
                style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 13),
      ),
    );
  }
}
