import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Settings'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
              children: [
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      _tile(
                        context,
                        Icons.person_outline,
                        'Edit Profile',
                        () => Navigator.pushNamed(context, '/profile'),
                      ),
                      const _RowDivider(),
                      _tile(
                        context,
                        Icons.lock_outline,
                        'Change Password',
                        () => Navigator.pushNamed(context, '/forgot-password'),
                      ),
                      const _RowDivider(),
                      _tile(
                        context,
                        Icons.notifications_none,
                        'Notification',
                        () => Navigator.pushNamed(context, '/notifications'),
                      ),
                      const _RowDivider(),
                      _tile(context, Icons.language, 'Languages', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Language: English')),
                        );
                      }),
                      const _RowDivider(),
                      _tile(context, Icons.palette_outlined, 'Themes', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Theme follows the reference blue design',
                            ),
                          ),
                        );
                      }),
                      const _RowDivider(),
                      _tile(
                        context,
                        Icons.info_outline,
                        'About Us',
                        () => Navigator.pushNamed(context, '/about'),
                      ),
                      const _RowDivider(),
                      _tile(context, Icons.help_outline, 'Help & Support', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Support: support@buildtechhardware.com',
                            ),
                          ),
                        );
                      }),
                      const _RowDivider(),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 22,
                        ),
                        title: const Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
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

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
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

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, indent: 12, endIndent: 12);
  }
}
