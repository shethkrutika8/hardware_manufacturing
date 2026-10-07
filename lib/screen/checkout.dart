import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/order_store.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Krutika Sheth');
  final _phoneController = TextEditingController(text: '+91 5624356273');
  final _addressController = TextEditingController(
    text: 'Ambika Township, Jivraj Park, Rajkot, Gujarat 360004',
  );
  String _payment = 'UPI / Google Pay / Apple Pay';
  bool _editing = false;

  static const List<Map<String, Object>> _paymentOptions = [
    {
      'label': 'UPI / Google Pay / Apple Pay',
      'icon': Icons.account_balance_wallet_outlined,
      'color': Color(0xff4aa3e0),
    },
    {
      'label': 'Credit/Debit Card',
      'icon': Icons.credit_card_outlined,
      'color': Color(0xff27ae60),
    },
    {
      'label': 'Net Banking',
      'icon': Icons.account_balance_outlined,
      'color': Color(0xff5b8def),
    },
    {
      'label': 'Cash on Delivery',
      'icon': Icons.payments_outlined,
      'color': Color(0xffe67e22),
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (CartStore.items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }
    if (_editing && !_formKey.currentState!.validate()) return;

    OrderStore.placeFromCart(
      customerName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      paymentLabel: '$_payment (Demo — no payment processed)',
    );
    CartStore.clear();
    Navigator.pushReplacementNamed(context, '/order-placed');
  }

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('CheckOut'),
          _stepper(),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: CartStore.cartChangeNotifier,
              builder: (context, _, _) {
                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    children: [
                      _addressCard(),
                      const SizedBox(height: 12),
                      _summaryCard(),
                      const SizedBox(height: 12),
                      _paymentCard(),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: kGradBottom,
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: WhitePillButton(
              label: 'Place Order',
              onPressed: _placeOrder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepper() {
    const steps = [
      {'icon': Icons.location_on_outlined, 'label': 'Address'},
      {'icon': Icons.payment_outlined, 'label': 'Payment'},
      {'icon': Icons.receipt_long_outlined, 'label': 'Review'},
      {'icon': Icons.check_circle_outline, 'label': 'Place Order'},
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            if (i > 0)
              Expanded(
                child: Container(
                  height: 1.5,
                  margin: const EdgeInsets.only(top: 11),
                  color: const Color(0xff12365f),
                ),
              ),
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff12365f),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    steps[i]['icon'] as IconData,
                    size: 13,
                    color: const Color(0xff12365f),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 52,
                  child: Text(
                    steps[i]['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xff12365f),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _addressCard() {
    return Container(
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
              const Icon(Icons.person_outline, size: 16, color: kIndigo),
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
                onTap: () => setState(() => _editing = !_editing),
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
          if (!_editing) ...[
            Text(
              _nameController.text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: kIndigo,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _addressController.text.replaceAll(', ', ',\n'),
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xff5c6b76),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _phoneController.text,
              style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
            ),
          ] else ...[
            TextFormField(
              controller: _nameController,
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Name is required' : null,
            ),
            TextFormField(
              controller: _phoneController,
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(labelText: 'Phone'),
              validator: (v) => v == null || v.trim().length < 10
                  ? 'Enter a valid phone'
                  : null,
            ),
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Address is required' : null,
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
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
          const SizedBox(height: 8),
          if (CartStore.items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('No items in cart', style: TextStyle(fontSize: 10)),
            ),
          ...CartStore.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.product.name}  x${item.quantity}',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xff5c6b76),
                      ),
                    ),
                  ),
                  Text(
                    formatRupees(item.totalPrice),
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xff5c6b76),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 10),
          _line('Subtotal', formatRupees(CartStore.subtotal)),
          _line('GST (18%)', formatRupees(CartStore.tax)),
          _line(
            'Delivery Charges',
            CartStore.shipping == 0 ? 'Free' : formatRupees(CartStore.shipping),
          ),
          const SizedBox(height: 4),
          _line('Total', formatRupees(CartStore.total), bold: true),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return Material(
      color: const Color(0xfff7f9fc),
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: kInk,
                ),
              ),
            ),
            const SizedBox(height: 4),
            RadioGroup<String>(
              groupValue: _payment,
              onChanged: (value) {
                if (value != null) setState(() => _payment = value);
              },
              child: Column(
                children: [
                  for (final option in _paymentOptions)
                    RadioListTile<String>(
                      value: option['label'] as String,
                      activeColor: kIndigo,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          Icon(
                            option['icon'] as IconData,
                            size: 16,
                            color: option['color'] as Color,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              option['label'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xff5c6b76),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Demo checkout — no real payment is processed.',
                style: TextStyle(fontSize: 8, color: Color(0xff8a97a1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(String label, String value, {bool bold = false}) {
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
}
