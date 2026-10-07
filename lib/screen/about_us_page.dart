import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const List<Map<String, Object>> _stats = [
    {'icon': Icons.verified_user_outlined, 'label': 'Premium\nQuality'},
    {'icon': Icons.settings_outlined, 'label': 'Precision\nEngineering'},
    {'icon': Icons.handshake_outlined, 'label': 'Reliable\nPerformance'},
    {'icon': Icons.groups_outlined, 'label': 'Built For\nIndustry'},
  ];

  static const List<Map<String, Object>> _strip = [
    {
      'icon': Icons.emoji_events_outlined,
      'label': 'HIGH PERFORMANCE\nTested. Proven. Trusted.',
    },
    {
      'icon': Icons.verified_outlined,
      'label': 'INDUSTRY EXPERTS\nExperience that builds better.',
    },
    {
      'icon': Icons.language,
      'label': 'GLOBAL STANDARDS\nWorld-class benchmarks.',
    },
    {
      'icon': Icons.factory_outlined,
      'label': 'MADE FOR THE FUTURE\nInnovating today.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
        children: [
          const Text(
            'About us',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'BuildTech Hardware is your trusted partner for quality tools and hardware '
            'for every project, big or small.',
            style: TextStyle(fontSize: 10, color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final stat in _stats) ...[
                Expanded(child: _statTile(stat)),
                if (stat != _stats.last) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xfff7f9fc),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const AppAssetImage(
                      path: 'assets/images/BuildTech_hardware_picture.png',
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  flex: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BuildTech Hardware',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: kInk,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Your trusted partner for quality tools and hardware for every '
                        'project, big or small.',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xff5c6b76),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 8),
                      Divider(height: 1),
                      SizedBox(height: 8),
                      Text(
                        'Our Mission',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: kInk,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'To provide durable, reliable, and affordable hardware that helps '
                        'professionals and DIY builders get the job done.',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xff5c6b76),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: kNavy,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 6,
                  ),
                  child: Row(
                    children: [
                      for (final item in _strip)
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                size: 16,
                                color: const Color(0xff2f7fd6),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  item['label'] as String,
                                  style: const TextStyle(
                                    fontSize: 6.5,
                                    color: Color(0xff33475c),
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
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
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'More Than Hardware.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'We Build Trust.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4da3ff),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'To provide durable, reliable, and affordable hardware that '
                              'helps professionals and DIY builders get the job done.',
                              style: TextStyle(
                                fontSize: 8.5,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (final line in const [
                              'Quality products.',
                              'Honest service.',
                              'Trusted by builders.',
                            ])
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      size: 12,
                                      color: Colors.white70,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      line,
                                      style: const TextStyle(
                                        fontSize: 8.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const AppAssetImage(
                            path: 'assets/images/toolkit.png',
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statTile(Map<String, Object> stat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: kTileBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Icon(stat['icon'] as IconData, size: 16, color: Colors.white),
          const SizedBox(height: 6),
          Text(
            stat['label'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 7,
              color: Colors.white,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
