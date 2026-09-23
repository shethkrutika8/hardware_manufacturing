import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPayment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            // Detect phone / tablet / web
            final bool isMobile = screenWidth < 600;
            final bool isTablet = screenWidth >= 600 && screenWidth < 1000;
            final bool isWeb = screenWidth >= 1000;

            // Responsive content width
            double contentWidth;

            if (isMobile) {
              contentWidth = screenWidth;
            } else if (isTablet) {
              contentWidth = screenWidth * 0.90;
            } else {
              contentWidth = 900;
            }

            return Center(
              child: SizedBox(
                width: contentWidth,
                height: constraints.maxHeight,
                child: Container(
                  color: const Color(0xFF4F82AE),

                  child: Column(
                    children: [
                      // =====================================================
                      // HEADER
                      // =====================================================
                      _buildHeader(isMobile: isMobile, isTablet: isTablet),

                      // =====================================================
                      // TITLE
                      // =====================================================
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: isMobile ? 25 : 40,
                          top: 5,
                          bottom: 12,
                        ),
                        child: Text(
                          "CheckOut",
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // =====================================================
                      // STEPS
                      // =====================================================
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 45,
                        ),
                        child: _buildSteps(isMobile: isMobile),
                      ),

                      const SizedBox(height: 15),

                      // =====================================================
                      // MAIN CONTENT
                      // =====================================================
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),

                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 0 : 20,
                            ),

                            child: Column(
                              children: [
                                // =================================================
                                // DELIVERY ADDRESS
                                // =================================================
                                _buildAddressCard(isMobile: isMobile),

                                SizedBox(height: isMobile ? 20 : 25),

                                // =================================================
                                // ORDER SUMMARY
                                // =================================================
                                _buildOrderSummary(isMobile: isMobile),

                                SizedBox(height: isMobile ? 12 : 18),

                                // =================================================
                                // PAYMENT METHOD
                                // =================================================
                                _buildPaymentMethod(isMobile: isMobile),

                                SizedBox(height: isMobile ? 35 : 50),

                                // =================================================
                                // ORDER BUTTON
                                // =================================================
                                SizedBox(
                                  width: isMobile ? 185 : 230,
                                  height: isMobile ? 35 : 42,

                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Order Placed Successfully!",
                                          ),
                                        ),
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      elevation: 0,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),

                                    child: Text(
                                      "Order Placed",
                                      style: TextStyle(
                                        fontSize: isMobile ? 12 : 14,
                                        fontFamily: "monospace",
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 35),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =====================================================================
  // HEADER
  // =====================================================================

  Widget _buildHeader({required bool isMobile, required bool isTablet}) {
    return SizedBox(
      height: isMobile ? 65 : 75,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),

        child: Row(
          children: [
            // MENU
            IconButton(
              onPressed: () {},

              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: isMobile ? 27 : 30,
              ),
            ),

            // =============================================================
            // LOGO
            // =============================================================
            Container(
              height: isMobile ? 40 : 48,
              width: isMobile ? 125 : 155,

              color: Colors.white,

              padding: const EdgeInsets.all(5),

              child: Row(
                children: [
                  Container(
                    width: isMobile ? 30 : 36,
                    height: isMobile ? 30 : 36,

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF17456E),
                        width: 2,
                      ),

                      borderRadius: BorderRadius.circular(6),
                    ),

                    child: Icon(
                      Icons.hexagon_outlined,
                      color: const Color(0xFF17456E),
                      size: isMobile ? 25 : 30,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "BuildTech",

                        style: TextStyle(
                          fontSize: isMobile ? 14 : 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF173C60),
                        ),
                      ),

                      Text(
                        "HARDWARE",

                        style: TextStyle(
                          fontSize: isMobile ? 6 : 7,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // =============================================================
            // HEADER ICONS
            // =============================================================
            Icon(
              Icons.local_shipping_outlined,
              size: isMobile ? 24 : 28,
              color: Colors.black,
            ),

            SizedBox(width: isMobile ? 12 : 25),

            Icon(
              Icons.notifications_none,
              size: isMobile ? 27 : 31,
              color: Colors.black,
            ),

            SizedBox(width: isMobile ? 12 : 25),

            Icon(
              Icons.favorite_border,
              size: isMobile ? 27 : 31,
              color: Colors.black,
            ),

            SizedBox(width: isMobile ? 5 : 10),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // STEPS
  // =====================================================================

  Widget _buildSteps({required bool isMobile}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        _step(1, "Address", isMobile),

        _line(),

        _step(2, "Payment", isMobile),

        _line(),

        _step(3, "Review", isMobile),

        _line(),

        _step(4, "Place\nOrder", isMobile),
      ],
    );
  }

  Widget _step(int number, String title, bool isMobile) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: isMobile ? 23 : 28,
            height: isMobile ? 23 : 28,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(color: Colors.black, width: 1.5),
            ),

            child: Text(
              "$number",

              style: TextStyle(
                fontSize: isMobile ? 11 : 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: isMobile ? 10 : 12,
              fontFamily: "monospace",
              letterSpacing: isMobile ? 1.5 : 2,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      width: 35,
      height: 2,

      margin: const EdgeInsets.only(top: 11),

      color: Colors.black54,
    );
  }

  // =====================================================================
  // ADDRESS CARD
  // =====================================================================

  Widget _buildAddressCard({required bool isMobile}) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.fromLTRB(
        isMobile ? 12 : 20,
        10,
        isMobile ? 12 : 20,
        10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // LOCATION ICON
          Container(
            width: isMobile ? 30 : 38,
            height: isMobile ? 30 : 38,

            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),

              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(
              Icons.location_on_outlined,
              color: Colors.blueAccent,
              size: isMobile ? 21 : 27,
            ),
          ),

          const SizedBox(width: 10),

          // ADDRESS TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Text(
                      "Delivery Address",

                      style: TextStyle(
                        fontSize: isMobile ? 14 : 17,
                        letterSpacing: 1.5,
                        fontFamily: "monospace",
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        "Change",

                        style: TextStyle(
                          fontSize: isMobile ? 14 : 17,
                          color: Colors.deepPurple,
                          letterSpacing: 1.5,
                          fontFamily: "monospace",
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  "Krutika Sheth",

                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.deepPurple,
                    fontFamily: "monospace",
                    letterSpacing: 1.5,
                  ),
                ),

                Text(
                  "Ambika Township,\n"
                  "Jivraj park,\n"
                  "Rajkot,\n"
                  "360004\n"
                  "+91 5624356273",

                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Colors.black,
                    fontFamily: "monospace",
                    letterSpacing: 1.2,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // ORDER SUMMARY
  // =====================================================================

  Widget _buildOrderSummary({required bool isMobile}) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.fromLTRB(
        isMobile ? 15 : 20,
        10,
        isMobile ? 15 : 20,
        10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Order Summary",

            style: TextStyle(
              fontSize: isMobile ? 14 : 17,
              letterSpacing: 2,
              fontFamily: "monospace",
            ),
          ),

          const SizedBox(height: 6),

          _priceRow("Subtotal", "Rs. 42.80", isMobile),

          _priceRow("GST(18%)", "Rs. 7.70", isMobile),

          _priceRow("Shipping Charges", "Rs. 4.00", isMobile),

          const Divider(height: 8, thickness: 1),

          _priceRow("Total", "Rs. 54.50", isMobile, bold: true),
        ],
      ),
    );
  }

  Widget _priceRow(
    String title,
    String price,
    bool isMobile, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),

      child: Row(
        children: [
          Text(
            title,

            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontFamily: "monospace",
              letterSpacing: 1.5,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          const Spacer(),

          Text(
            price,

            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              fontFamily: "monospace",
              letterSpacing: 1,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // PAYMENT METHOD
  // =====================================================================

  Widget _buildPaymentMethod({required bool isMobile}) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,

            padding: EdgeInsets.fromLTRB(isMobile ? 15 : 20, 10, 15, 4),

            child: Text(
              "Payment Method",

              style: TextStyle(
                fontSize: isMobile ? 13 : 16,
                fontFamily: "monospace",
              ),
            ),
          ),

          _paymentOption(0, "💳", "UPI / Google Pay / Paytm", isMobile),

          _paymentOption(1, "💳", "Credit/Debit Card", isMobile),

          _paymentOption(2, "🏦", "Net Banking", isMobile),

          _paymentOption(3, "💵", "Cash On Delivery", isMobile),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _paymentOption(int value, String icon, String title, bool isMobile) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },

      child: SizedBox(
        height: isMobile ? 30 : 38,

        child: Row(
          children: [
            SizedBox(width: isMobile ? 15 : 20),

            Text(icon, style: TextStyle(fontSize: isMobile ? 13 : 16)),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                title,

                style: TextStyle(
                  fontSize: isMobile ? 11 : 14,
                  fontFamily: "monospace",
                ),
              ),
            ),

            Radio<int>(
              value: value,
              groupValue: selectedPayment,

              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedPayment = newValue;
                  });
                }
              },

              activeColor: Colors.blue,

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            SizedBox(width: isMobile ? 8 : 15),
          ],
        ),
      ),
    );
  }
}
