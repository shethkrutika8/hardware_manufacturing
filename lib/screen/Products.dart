import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String selectedCategory = 'All Categories';
  String sortMode = 'Sort';
  bool _appliedArg = false;

  static const List<String> _categories = [
    'All Categories',
    'Fasteners',
    'Power Tools',
    'Hand Tools',
    'Tool Kits',
    'Equipment',
    'Abrasives',
    'Door & Window',
  ];

  static const List<String> _sorts = [
    'Sort',
    'Price: Low to High',
    'Price: High to Low',
    'Name A-Z',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_appliedArg) return;
    _appliedArg = true;
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String && arg.isNotEmpty) {
      final match = _categories.firstWhere(
        (c) => c.toLowerCase() == arg.toLowerCase(),
        orElse: () => 'All Categories',
      );
      selectedCategory = match;
    }
  }

  List<Product> get _filtered {
    final list = kSampleProducts.where((p) {
      return selectedCategory == 'All Categories' || p.category == selectedCategory;
    }).toList();
    switch (sortMode) {
      case 'Price: Low to High':
        list.sort((a, b) => a.numericPrice.compareTo(b.numericPrice));
        break;
      case 'Price: High to Low':
        list.sort((a, b) => b.numericPrice.compareTo(a.numericPrice));
        break;
      case 'Name A-Z':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
    return list;
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter', style: TextStyle(fontSize: 15)),
          content: RadioGroup<String>(
            groupValue: selectedCategory,
            onChanged: (value) {
              setState(() => selectedCategory = value ?? 'All Categories');
              Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final category in _categories)
                  RadioListTile<String>(
                    value: category,
                    activeColor: kIndigo,
                    dense: true,
                    title: Text(category, style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Products'),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
            child: Row(
              children: [
                _chip(
                  onTap: _openFilterDialog,
                  child: Row(
                    children: const [
                      Icon(Icons.filter_list, size: 14, color: Color(0xff33475c)),
                      SizedBox(width: 4),
                      Text('Filter', style: TextStyle(fontSize: 10, color: Color(0xff5c6b76))),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _chip(
                    onTap: null,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        icon: const Icon(Icons.search, size: 14, color: Color(0xff33475c)),
                        style: const TextStyle(fontSize: 10, color: Color(0xff5c6b76)),
                        items: [
                          for (final category in _categories)
                            DropdownMenuItem(value: category, child: Text(category)),
                        ],
                        onChanged: (value) =>
                            setState(() => selectedCategory = value ?? 'All Categories'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _chip(
                  onTap: null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: sortMode,
                      icon: const Icon(Icons.tune, size: 14, color: Color(0xff33475c)),
                      style: const TextStyle(fontSize: 10, color: Color(0xff5c6b76)),
                      items: [
                        for (final sort in _sorts)
                          DropdownMenuItem(value: sort, child: Text(sort)),
                      ],
                      onChanged: (value) => setState(() => sortMode = value ?? 'Sort'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      'No matching products found',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 18),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _productItemCard(filtered[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip({required Widget child, VoidCallback? onTap}) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xfffbfbfd),
        borderRadius: BorderRadius.circular(4),
      ),
      child: onTap == null
          ? Center(child: child)
          : InkWell(onTap: onTap, child: Center(child: child)),
    );
  }

  Widget _productItemCard(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff7f9fc),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.pushNamed(context, '/product-detail', arguments: product);
          },
          child: Row(
            children: [
              SizedBox(
                width: 84,
                child: Column(
                  children: [
                    SizedBox(
                      height: 74,
                      width: 84,
                      child: AppAssetImage(path: product.image, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.numericPrice.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 8, color: Color(0xff8fa8c8)),
                    ),
                  ],
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff22303c),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.size} | ${product.material}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.price,
                      style: const TextStyle(fontSize: 9, color: Color(0xff5c6b76)),
                    ),
                    const SizedBox(height: 6),
                    StockPill(product.stock.startsWith('In Stock') ? 'In Stock' : product.stock),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WishlistHeartButton(productId: product.id, size: 18),
                  InkWell(
                    onTap: () {
                      CartStore.addProduct(product, 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: 'View Cart',
                            onPressed: () => Navigator.pushNamed(context, '/cart'),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add_box_outlined,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
