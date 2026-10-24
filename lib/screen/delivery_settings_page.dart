import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/panel_scaffold.dart';

class DeliverySettingsPage extends StatelessWidget {
  const DeliverySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Delivery Settings',
      drawer: const DeliveryDrawer(),
      children: [
        _dsTile(
          context,
          icon: Icons.person_outline,
          label: 'My Profile',
          route: '/delivery/profile',
        ),
        const SizedBox(height: 12),
        _dsTile(
          context,
          icon: Icons.notifications_none,
          label: 'Notifications',
          route: '/delivery/notifications',
        ),
        const SizedBox(height: 12),
        _dsTile(
          context,
          icon: Icons.lock_outline,
          label: 'Change Password',
          route: '/forgot-password',
        ),
        const SizedBox(height: 12),
        _dsTile(
          context,
          icon: Icons.logout,
          label: 'Log Out',
          route: '/login',
          isLogout: true,
        ),
      ],
    );
  }

  Widget _dsTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    bool isLogout = false,
  }) {
    return ListTile(
      tileColor: Colors.white.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {
        if (isLogout) {
          Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
