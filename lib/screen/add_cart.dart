import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "HSS Drill Bit",
      "size": "M12 × 40 mm",
      "price": 10.00,
      "quantity": 2,
      "image": "assets/drill_bit.png",
    },
    {
      "name": "Hex Nut",
      "size": "M12",
      "price": 15.50,
      "quantity": 3,
      "image": "assets/hex_nut.png",
    },
    {
      "name": "Flat Washer",
      "size": "M12",
      "price": 8.00,
      "quantity": 3,
      "image": "assets/washer.png",
    },
  ];

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  void deleteProduct(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get subtotal {
    double amount = 0;

    for (var item in cartItems) {
      amount += item["price"] * item["quantity"];
    }

    return amount;
  }

  double get gst => subtotal * 0.18;

  double get total => subtotal + gst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================
            Container(
              width: double.infinity,
              height: 65,
              color: const Color(0xFF6599C7),

              child: Row(
                children: [
                  // MENU
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Container(
                      width: 34,
                      height: 34,

                      decoration: BoxDecoration(
                        color: const Color(0xFF1595D1),
                        border: Border.all(color: Colors.black, width: 1),
                      ),

                      child: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),

                  const SizedBox(width: 25),

                  // LOGO
                  Container(
                    height: 42,
                    width: 150,
                    color: Colors.white,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          width: 30,
                          height: 30,

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF073B73),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),

                          child: const Icon(
                            Icons.hexagon_outlined,
                            color: Color(0xFF073B73),
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: 7),

                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "BuildTech",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF12355B),
                              ),
                            ),

                            Text(
                              "HARDWARE",
                              style: TextStyle(
                                fontSize: 7,
                                letterSpacing: 1.5,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // DELIVERY
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.local_shipping_outlined,
                      size: 27,
                      color: Colors.black87,
                    ),
                  ),

                  // NOTIFICATION
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 28,
                      color: Colors.black87,
                    ),
                  ),

                  // FAVORITE
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 28,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(width: 15),
                ],
              ),
            ),

            // =====================================================
            // MY CART TITLE
            // =====================================================
            Container(
              width: double.infinity,
              color: const Color(0xFF6599C7),

              padding: const EdgeInsets.fromLTRB(30, 20, 30, 25),

              child: const Text(
                "My Cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // =====================================================
            // CART CONTENT
            // =====================================================
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return cartProduct(index);
                      },
                    ),
            ),

            // =====================================================
            // SUMMARY
            // =====================================================
            Container(
              width: double.infinity,
              color: const Color(0xFF416C8D),

              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),

              child: Column(
                children: [
                  summaryRow("Subtotal", subtotal),

                  summaryRow("GST (18%)", gst),

                  summaryRow("Total", total),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: 230,
                    height: 38,

                    child: ElevatedButton(
                      onPressed: cartItems.isEmpty ? null : () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),

                      child: const Text(
                        "Proceed To CheckOut",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // PRODUCT ROW
  // =============================================================

  Widget cartProduct(int index) {
    final item = cartItems[index];

    double itemTotal = item["price"] * item["quantity"];

    return Container(
      width: double.infinity,

      decoration: const BoxDecoration(
        color: Colors.white,

        border: Border(bottom: BorderSide(color: Color(0xFF416C8D), width: 8)),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),

        child: Row(
          children: [
            // ===================================================
            // IMAGE
            // ===================================================
            Container(
              width: 220,
              height: 150,

              color: Colors.white,

              child: Image.asset(
                item["image"],
                fit: BoxFit.contain,

                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 35),

            // ===================================================
            // PRODUCT DETAILS
            // ===================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Text(
                        item["name"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 15),

                      IconButton(
                        onPressed: () {
                          deleteProduct(index);
                        },

                        icon: const Icon(Icons.delete_outline, size: 27),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    item["size"],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    "Rs. ${item["price"].toStringAsFixed(2)}/pcs",
                    style: const TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      quantityButton(Icons.remove, () {
                        decreaseQuantity(index);
                      }),

                      Container(
                        width: 45,
                        height: 32,

                        alignment: Alignment.center,

                        color: const Color(0xFFF2F2F2),

                        child: Text(
                          "${item["quantity"]}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      quantityButton(Icons.add, () {
                        increaseQuantity(index);
                      }),
                    ],
                  ),
                ],
              ),
            ),

            // ===================================================
            // ITEM TOTAL
            // ===================================================
            SizedBox(
              width: 130,

              child: Align(
                alignment: Alignment.centerRight,

                child: Text(
                  "Rs. ${itemTotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // QUANTITY BUTTON
  // =============================================================

  Widget quantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,

      child: Container(
        width: 32,
        height: 32,

        color: const Color(0xFFF2F2F2),

        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  // =============================================================
  // SUMMARY ROW
  // =============================================================

  Widget summaryRow(String title, double amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),

        Text(
          "Rs. ${amount.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
