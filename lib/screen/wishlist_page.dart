import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/wishlist_store.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Wishlist'),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff173f7a),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: WishlistStore.wishlistChangeNotifier,
              builder: (context, _, _) {
                final products = WishlistStore.products;
                if (products.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Your wishlist is empty. Add products from the catalog to save them here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 18),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xfff7f9fc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 92,
                            height: 88,
                            child: AppAssetImage(
                              path: product.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff22303c),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.price,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Color(0xff5c6b76),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                StockPill(
                                  product.stock.startsWith('In Stock')
                                      ? 'In Stock'
                                      : product.stock,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WishlistHeartButton(
                                productId: product.id,
                                size: 18,
                              ),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  CartStore.addProduct(product, 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} added to cart',
                                      ),
                                      action: SnackBarAction(
                                        label: 'Cart',
                                        onPressed: () => Navigator.pushNamed(
                                          context,
                                          '/cart',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.add_shopping_cart,
                                  size: 20,
                                  color: kIndigo,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
