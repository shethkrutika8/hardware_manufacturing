import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F6),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            // Responsive breakpoints
            final bool isMobile = screenWidth < 600;
            final bool isTablet = screenWidth >= 600 && screenWidth < 1000;

            double pageWidth;

            if (isMobile) {
              pageWidth = screenWidth;
            } else if (isTablet) {
              pageWidth = screenWidth * 0.90;
            } else {
              pageWidth = 950;
            }

            return Center(
              child: SizedBox(
                width: pageWidth,
                height: constraints.maxHeight,

                child: Container(
                  color: const Color(0xFF4F82AE),

                  child: Column(
                    children: [
                      // =====================================================
                      // HEADER
                      // =====================================================
                      _buildHeader(isMobile),

                      // =====================================================
                      // MAIN CONTENT
                      // =====================================================
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),

                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 12 : 30,
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                // =================================================
                                // ORDER DETAILS TITLE
                                // =================================================
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: isMobile ? 5 : 10,
                                    top: 5,
                                    bottom: 12,
                                  ),

                                  child: Text(
                                    "Order Details",

                                    style: TextStyle(
                                      fontSize: isMobile ? 16 : 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                // =================================================
                                // ORDER INFORMATION CARD
                                // =================================================
                                _buildOrderCard(isMobile),

                                const SizedBox(height: 12),

                                // =================================================
                                // DELIVERY ADDRESS
                                // =================================================
                                _buildAddressCard(isMobile),

                                const SizedBox(height: 15),

                                // =================================================
                                // ITEMS TITLE
                                // =================================================
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    bottom: 8,
                                  ),

                                  child: Text(
                                    "Items",

                                    style: TextStyle(
                                      fontSize: isMobile ? 15 : 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                // =================================================
                                // ITEM 1
                                // =================================================
                                _buildProductItem(
                                  isMobile: isMobile,
                                  imagePath: "assets/images/pliers.png",
                                  productName: "Combinational\nPliers",
                                  price: "Rs. 10.00/pcs",
                                  quantity: "Qty: 1",
                                ),

                                const SizedBox(height: 10),

                                // =================================================
                                // ITEM 2
                                // =================================================
                                _buildProductItem(
                                  isMobile: isMobile,
                                  imagePath: "assets/images/washer.png",
                                  productName: "Flat Washer",
                                  price: "Rs. 8.00/pcs",
                                  quantity: "Qty: 1",
                                  selected: true,
                                ),

                                const SizedBox(height: 15),

                                // =================================================
                                // ORDER SUMMARY
                                // =================================================
                                _buildOrderSummary(isMobile),

                                const SizedBox(height: 30),
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

  Widget _buildHeader(bool isMobile) {
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
                size: isMobile ? 27 : 31,
              ),
            ),

            // =============================================================
            // BUILDTECH LOGO
            // =============================================================
            Container(
              width: isMobile ? 125 : 160,
              height: isMobile ? 40 : 48,

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

            // SEARCH
            Icon(Icons.search, color: Colors.black, size: isMobile ? 25 : 29),

            SizedBox(width: isMobile ? 14 : 25),

            // NOTIFICATION
            Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: isMobile ? 27 : 31,
            ),

            SizedBox(width: isMobile ? 14 : 25),

            // FAVORITE
            Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: isMobile ? 27 : 31,
            ),

            SizedBox(width: isMobile ? 5 : 10),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // ORDER CARD
  // =====================================================================

  Widget _buildOrderCard(bool isMobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 25,
        vertical: isMobile ? 8 : 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Row(
        children: [
          // ORDER NUMBER
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "BTD1234567890",

                  style: TextStyle(
                    fontSize: isMobile ? 18 : 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Text(
                  "Order Placed May 2024",

                  style: TextStyle(
                    fontSize: isMobile ? 11 : 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // PROCESSING STATUS
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 15,
              vertical: 5,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFF75C44D),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              "Processing",

              style: TextStyle(
                fontSize: isMobile ? 9 : 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E6417),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // ADDRESS CARD
  // =====================================================================

  Widget _buildAddressCard(bool isMobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.fromLTRB(
        isMobile ? 10 : 20,
        10,
        isMobile ? 10 : 20,
        10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // LOCATION ICON
          Container(
            width: isMobile ? 28 : 38,
            height: isMobile ? 28 : 38,

            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent),

              borderRadius: BorderRadius.circular(7),
            ),

            child: Icon(
              Icons.location_on_outlined,
              color: Colors.deepPurpleAccent,
              size: isMobile ? 20 : 27,
            ),
          ),

          const SizedBox(width: 9),

          // ADDRESS DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Text(
                      "Delivery Address",

                      style: TextStyle(
                        fontSize: isMobile ? 14 : 18,
                        letterSpacing: 2,
                        fontFamily: "monospace",
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "Change",

                      style: TextStyle(
                        fontSize: isMobile ? 14 : 18,
                        color: Colors.deepPurple,
                        letterSpacing: 2,
                        fontFamily: "monospace",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  "Krutika Sheth",

                  style: TextStyle(
                    fontSize: isMobile ? 13 : 16,
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
                    fontSize: isMobile ? 11 : 14,
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
  // PRODUCT ITEM
  // =====================================================================

  Widget _buildProductItem({
    required bool isMobile,
    required String imagePath,
    required String productName,
    required String price,
    required String quantity,
    bool selected = false,
  }) {
    return Container(
      width: double.infinity,

      height: isMobile ? 63 : 85,

      decoration: BoxDecoration(
        color: Colors.white,

        border: selected
            ? Border.all(color: Colors.lightBlueAccent, width: 3)
            : null,
      ),

      child: Row(
        children: [
          // =============================================================
          // PRODUCT IMAGE
          // =============================================================
          Container(
            width: isMobile ? 75 : 110,
            height: double.infinity,

            padding: const EdgeInsets.all(5),

            child: Image.asset(
              imagePath,

              fit: BoxFit.contain,

              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  productName.toLowerCase().contains("washer")
                      ? Icons.circle_outlined
                      : Icons.build,
                  size: isMobile ? 45 : 60,
                  color: Colors.grey,
                );
              },
            ),
          ),

          // =============================================================
          // PRODUCT NAME
          // =============================================================
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  productName,

                  style: TextStyle(
                    fontSize: isMobile ? 11 : 15,
                    color: Colors.black,
                    fontFamily: "serif",
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  quantity,

                  style: TextStyle(
                    fontSize: isMobile ? 10 : 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // =============================================================
          // PRICE
          // =============================================================
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 10 : 25),

            child: Text(
              price,

              style: TextStyle(
                fontSize: isMobile ? 9 : 13,
                color: Colors.black,
                fontFamily: "serif",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================================
  // ORDER SUMMARY
  // =====================================================================

  Widget _buildOrderSummary(bool isMobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.fromLTRB(
        isMobile ? 12 : 20,
        8,
        isMobile ? 12 : 20,
        12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Order Summary",

            style: TextStyle(
              fontSize: isMobile ? 13 : 17,
              letterSpacing: 2,
              fontFamily: "monospace",
            ),
          ),

          const SizedBox(height: 5),

          _summaryRow("Subtotal", "Rs. 42.80", isMobile),

          _summaryRow("GST(18%)", "Rs. 7.70", isMobile),

          _summaryRow("Shipping Charges", "Rs. 0.00", isMobile),

          _summaryRow("Total", "Rs. 90.50", isMobile, bold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value,
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
              fontSize: isMobile ? 11 : 14,
              fontFamily: "monospace",
              letterSpacing: 1.5,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          const Spacer(),

          Text(
            value,

            style: TextStyle(
              fontSize: isMobile ? 11 : 14,
              fontFamily: "monospace",
              letterSpacing: 1,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
