import 'package:flutter/material.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            // Responsive screen detection
            final bool isMobile = screenWidth < 600;
            final bool isTablet = screenWidth >= 600 && screenWidth < 1000;

            // Page width
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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF639BD0), Color(0xFF365B7B)],
                    ),
                  ),
                  child: Column(
                    children: [
                      // ====================================================
                      // HEADER
                      // ====================================================
                      _buildHeader(isMobile),

                      // ====================================================
                      // CONTENT
                      // ====================================================
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 20 : 50,
                            ),
                            child: Column(
                              children: [
                                // ==================================================
                                // ORDER PLACED TITLE
                                // ==================================================
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: isMobile ? 15 : 20,
                                      top: 5,
                                    ),
                                    child: Text(
                                      "Order Placed",
                                      style: TextStyle(
                                        fontSize: isMobile ? 15 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: isMobile ? 15 : 25),

                                // ==================================================
                                // GREEN CHECK CIRCLE
                                // ==================================================
                                Container(
                                  width: isMobile ? 58 : 75,
                                  height: isMobile ? 58 : 75,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4CAF50),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: isMobile ? 42 : 55,
                                  ),
                                ),

                                SizedBox(height: isMobile ? 22 : 30),

                                // ==================================================
                                // SUCCESS MESSAGE
                                // ==================================================
                                Text(
                                  "Order Placed Successfully",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  "Your order has been placed and is\n"
                                  "being processed.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isMobile ? 13 : 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    height: 1.35,
                                  ),
                                ),

                                SizedBox(height: isMobile ? 25 : 35),

                                // ==================================================
                                // ORDER ID TITLE
                                // ==================================================
                                Text(
                                  "Order ID",
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // ==================================================
                                // ORDER ID BOX
                                // ==================================================
                                Container(
                                  width: isMobile ? 220 : 320,
                                  height: isMobile ? 58 : 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Text(
                                    "BTD1234567890",
                                    style: TextStyle(
                                      fontSize: isMobile ? 18 : 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                SizedBox(height: isMobile ? 28 : 35),

                                // ==================================================
                                // ORDER INFORMATION CARD
                                // ==================================================
                                Container(
                                  width: isMobile ? 220 : 400,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 13 : 22,
                                    vertical: isMobile ? 11 : 16,
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      _detailsRow(
                                        "Order Date",
                                        "24 May 2025",
                                        isMobile,
                                      ),

                                      const SizedBox(height: 10),

                                      _detailsRow(
                                        "Total Amount",
                                        "Rs. 90.50",
                                        isMobile,
                                      ),

                                      const SizedBox(height: 10),

                                      _detailsRow(
                                        "Payment Method",
                                        "UPI/GooglePay",
                                        isMobile,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: isMobile ? 28 : 35),

                                // ==================================================
                                // VIEW ORDER DETAILS BUTTON
                                // ==================================================
                                SizedBox(
                                  width: isMobile ? 200 : 280,
                                  height: isMobile ? 35 : 43,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add navigation here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "View Order Details",
                                      style: TextStyle(
                                        fontSize: isMobile ? 12 : 15,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // ==================================================
                                // CONTINUE SHOPPING BUTTON
                                // ==================================================
                                SizedBox(
                                  width: isMobile ? 200 : 280,
                                  height: isMobile ? 35 : 43,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add navigation here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "Continue Shopping",
                                      style: TextStyle(
                                        fontSize: isMobile ? 12 : 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: isMobile ? 30 : 45),
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

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader(bool isMobile) {
    return SizedBox(
      height: isMobile ? 65 : 78,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),
        child: Row(
          children: [
            // ==========================================================
            // MENU
            // ==========================================================
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: isMobile ? 27 : 32,
              ),
            ),

            // ==========================================================
            // ACTUAL BUILDTECH LOGO
            // ==========================================================
            Container(
              width: isMobile ? 118 : 165,
              height: isMobile ? 40 : 52,
              color: Colors.white,
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                "assets/images/buildtech_logo.png",
                fit: BoxFit.contain,

                // Temporary fallback if logo isn't found
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hexagon_outlined,
                          color: const Color(0xFF173C60),
                          size: isMobile ? 27 : 35,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "BuildTech",
                              style: TextStyle(
                                fontSize: isMobile ? 13 : 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF173C60),
                              ),
                            ),
                            Text(
                              "HARDWARE",
                              style: TextStyle(
                                fontSize: isMobile ? 5 : 7,
                                letterSpacing: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            // ==========================================================
            // SEARCH
            // ==========================================================
            Icon(Icons.search, color: Colors.black, size: isMobile ? 25 : 30),

            SizedBox(width: isMobile ? 15 : 25),

            // ==========================================================
            // NOTIFICATION
            // ==========================================================
            Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: isMobile ? 27 : 32,
            ),

            SizedBox(width: isMobile ? 15 : 25),

            // ==========================================================
            // FAVORITE
            // ==========================================================
            Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: isMobile ? 27 : 32,
            ),

            SizedBox(width: isMobile ? 5 : 10),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // DETAILS ROW
  // ================================================================

  Widget _detailsRow(String title, String value, bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 11 : 14,
              color: Colors.black87,
            ),
          ),
        ),

        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: isMobile ? 11 : 14, color: Colors.black87),
        ),
      ],
    );
  }
}
