import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String?>> categories = [
    {
      'title': 'Power Tools',
      'image': 'assets/images/6.PNG',
      'category': 'Power Tools',
    },
    {
      'title': 'Hand Tools',
      'image': 'assets/images/toolkit.png',
      'category': 'Hand Tools',
    },
    {
      'title': 'Fasteners',
      'image': 'assets/images/HEX_NUT.PNG',
      'category': 'Fasteners',
    },
    {
      'title': 'Abrasives',
      'image': 'assets/images/5.PNG',
      'category': 'Abrasives',
    },
    {
      'title': 'Door & Window Hardware',
      'image': 'assets/images/4.PNG',
      'category': 'Door & Window',
    },
    {
      'title': 'Paint & Decorating Tools',
      'image': 'assets/images/lader.png',
      'category': 'Equipment',
    },
  ];

  void _openProducts({String? category}) {
    Navigator.pushNamed(context, '/products', arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Banner image: Use BuildTech hardware store image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const AppAssetImage(
                        path: 'assets/images/BuildTech_hardware_picture.png',
                        fit: BoxFit.cover,
                      ),
                      // Gradient overlay for readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.45),
                            ],
                          ),
                        ),
                      ),
                      // Banner text
                      Positioned(
                        left: 14,
                        bottom: 14,
                        right: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BuildTech Hardware',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () => _openProducts(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5066c6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Shop Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trending Categories',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kTagBlue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _openProducts(),
                        child: const Text(
                          'View More',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: kTagBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
                  child: GridView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 6,
                          childAspectRatio: 0.62,
                        ),
                    itemBuilder: (context, index) {
                      return _categoryTile(categories[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryTile(Map<String, String?> cat) {
    final image = cat['image'];
    return GestureDetector(
      onTap: () => _openProducts(category: cat['category']),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xfff7f9fc),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: image == null
                  ? const ColoredBox(
                      color: Color(0xffe8eef5),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Coming soon',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    )
                  : AppAssetImage(path: image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            cat['title']!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
