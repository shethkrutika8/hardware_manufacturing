import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black87,
              size: 21,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87, size: 20),
            onPressed: () {},
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- PRODUCT IMAGE ----------------
            Container(
              width: double.infinity,
              height: 140,
              color: Colors.white,
              child: Image.asset('assets/bolt.png', fit: BoxFit.contain),
            ),

            // ---------------- PRODUCT INFORMATION ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 14, 15, 12),
              color: const Color(0xFF568BB7),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hex Nut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    "M12",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    "BuildTech Hardware",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    "Rs. 150/PCS (Incl. of GST)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          "In Stock",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 7),

                      const Text(
                        "(325 Pcs available)",
                        style: TextStyle(color: Colors.white, fontSize: 7),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ---------------- SPECIFICATION TITLE ----------------
            Container(
              color: const Color(0xFF568BB7),
              width: double.infinity,
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 4),
              child: const Text(
                "Product Specification",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ---------------- SPECIFICATION TABLE ----------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700, width: 0.7),
              ),
              child: Column(
                children: [
                  specificationRow("SKU", "BT-HB-M12-40"),

                  specificationRow("Brand", "BuildTech"),

                  specificationRow("Material", "Stainless Steel"),

                  specificationRow("Size", "M12"),

                  specificationRow("Thread Type", "Full Thread"),

                  specificationRow("Head Type", "Hexagonal"),

                  specificationRow("Finish", "Zinc Plated"),

                  specificationRow("Weight", "45.50g/Pcs"),

                  specificationRow("Load Capacity", "8.8 Grade"),

                  specificationRow(
                    "Warranty",
                    "12 Month Manufacturing Warranty",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ---------------- TABLE ROW ----------------
  static Widget specificationRow(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade600, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // LEFT COLUMN
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey.shade600, width: 0.5),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(fontSize: 7.5, color: Colors.black87),
              ),
            ),
          ),

          // RIGHT COLUMN
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Text(
                value,
                style: const TextStyle(fontSize: 7.5, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
