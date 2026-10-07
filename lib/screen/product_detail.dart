import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  Product get product => widget.product;

  void _addToCart({required bool goToCart}) {
    CartStore.addProduct(product, quantity);
    if (goToCart) {
      Navigator.pushNamed(context, '/cart');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} added to cart')),
      );
    }
  }

  List<List<String>> get _specRows => [
        ['Size', product.size],
        ['Material', product.material],
        ['Thread Type', product.threadType],
        ['Head Type', product.headType],
        ['Finish', product.finish],
        ['Grade', product.grade],
        ['Application', product.application],
      ];

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      drawer: false,
      appBar: BuildTechAppBar(
        showBackButton: true,
        titleText: 'Product Details',
        onBack: () => Navigator.pop(context),
        actions: [
          WishlistHeartButton(productId: product.id, size: 20, color: Colors.black87),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87, size: 20),
            tooltip: 'Share',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Share ${product.name} (demo)')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            color: const Color(0xfff4f6f8),
            padding: const EdgeInsets.all(16),
            child: AppAssetImage(
              path: product.image,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.size,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  '${product.material} | ${product.threadType}',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    StockPill(
                      product.stock.startsWith('In Stock') ? 'In Stock' : product.stock,
                      fontSize: 8,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product.price,
                      style: const TextStyle(fontSize: 10, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Product Specifications',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xfff4f8fc),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < _specRows.length; i++) ...[
                        if (i > 0) const Divider(height: 1, thickness: 1),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 110,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    _specRows[i][0],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff33475c),
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1, thickness: 1),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    _specRows[i][1],
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xff33475c),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Text(
                      'Qty',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white, size: 20),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _addToCart(goToCart: true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kIndigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          CartStore.addProduct(product, quantity);
                          Navigator.pushNamed(context, '/checkout');
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Buy Now', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
