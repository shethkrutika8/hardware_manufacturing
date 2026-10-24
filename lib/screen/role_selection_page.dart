import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kAuthTop, kAuthBottom],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BuildTechLogo(width: 180, height: 70),
                    const SizedBox(height: 28),
                    const Text(
                      'Choose a panel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _PanelButton(
                      label: 'ADMIN PANEL',
                      icon: Icons.admin_panel_settings_outlined,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/admin/login',
                        (route) => false,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _PanelButton(
                      label: 'DELIVERY STAFF PANEL',
                      icon: Icons.delivery_dining_outlined,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/delivery/login',
                        (route) => false,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _PanelButton(
                      label: 'CUSTOMER STORE',
                      icon: Icons.storefront_outlined,
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PanelButton extends StatelessWidget {
  const _PanelButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 24),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          backgroundColor: Colors.white,
          foregroundColor: kNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
