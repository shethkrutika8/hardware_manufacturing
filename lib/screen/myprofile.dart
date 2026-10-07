import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('My Profile'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffd660c8),
                        child: Text(
                          'KS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Krutika Sheth',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'shethkrutika8@gmail.com',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      _tile(Icons.person_outline, 'Edit Profile', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Profile details are shown on this page',
                            ),
                          ),
                        );
                      }),
                      const Divider(height: 1, indent: 12, endIndent: 12),
                      _tile(
                        Icons.lock_outline,
                        'Change Password',
                        () => Navigator.pushNamed(context, '/forgot-password'),
                      ),
                      const Divider(height: 1, indent: 12, endIndent: 12),
                      _tile(Icons.payment_outlined, 'Payment Methods', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Demo checkout only — no saved payment methods',
                            ),
                          ),
                        );
                      }),
                      const Divider(height: 1, indent: 12, endIndent: 12),
                      _tile(
                        Icons.favorite_border,
                        'Wishlist',
                        () => Navigator.pushNamed(context, '/wishlist'),
                      ),
                      const Divider(height: 1, indent: 12, endIndent: 12),
                      _tile(
                        Icons.receipt_long_outlined,
                        'Orders',
                        () => Navigator.pushNamed(context, '/orders'),
                      ),
                      const Divider(height: 1, indent: 12, endIndent: 12),
                      _tile(
                        Icons.settings_outlined,
                        'Settings',
                        () => Navigator.pushNamed(context, '/settings'),
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

  Widget _tile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: Icon(icon, color: Colors.black87, size: 22),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
      onTap: onTap,
    );
  }
}
