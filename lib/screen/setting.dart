import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/firebase_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _profileFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Krutika Sheth');
  final _emailController = TextEditingController(
    text: 'shethkrutika8@gmail.com',
  );
  final _phoneController = TextEditingController();

  bool _isEditingProfile = false;
  String _name = 'Krutika Sheth';
  String _email = 'shethkrutika8@gmail.com';
  String _phone = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadFirebaseUserProfile();
  }

  Future<void> _loadFirebaseUserProfile() async {
    final uid = FirebaseService.instance.currentUid;
    if (uid != null) {
      final data = await FirebaseService.instance.getUserProfile(uid);
      if (data != null && mounted) {
        setState(() {
          _name = data['name'] ?? _name;
          _email = data['email'] ?? _email;
          _phone = data['mobile'] ?? _phone;
          _nameController.text = _name;
          _emailController.text = _email;
          _phoneController.text = _phone;
        });
      }
    }
  }

  void _saveProfile() async {
    if (!_profileFormKey.currentState!.validate()) return;

    final newName = _nameController.text.trim();
    final newPhone = _phoneController.text.trim();

    setState(() {
      _name = newName;
      _email = _emailController.text.trim();
      _phone = newPhone;
      _isEditingProfile = false;
    });

    final uid = FirebaseService.instance.currentUid;
    if (uid != null) {
      await FirebaseService.instance.updateUserProfile(
        uid: uid,
        name: newName,
        mobile: newPhone,
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated in Firebase')));
    }
  }

  void _cancelProfileEdit() {
    _nameController.text = _name;
    _emailController.text = _email;
    _phoneController.text = _phone;
    setState(() => _isEditingProfile = false);
  }

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
                _buildProfileCard(),
                const SizedBox(height: 14),
                _buildSettingsCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xffd660c8),
                child: Text(
                  _initials(_name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    if (_phone.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        _phone,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!_isEditingProfile)
                OutlinedButton.icon(
                  onPressed: () => setState(() => _isEditingProfile = true),
                  icon: const Icon(Icons.edit_outlined, size: 17),
                  label: const Text('Edit Profile'),
                ),
            ],
          ),
          if (_isEditingProfile) ...[
            const SizedBox(height: 20),
            Form(
              key: _profileFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty ||
                          !RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(email)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone number (optional)',
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: _saveProfile,
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: const Text('Save changes'),
                      ),
                      TextButton(
                        onPressed: _cancelProfileEdit,
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts
        .take(2)
        .map((part) => part.isEmpty ? '' : part[0].toUpperCase())
        .join();
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
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
          _tile(context, Icons.payment_outlined, 'Payment Methods', () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Demo checkout only — no saved payment methods'),
              ),
            );
          }),
          const _RowDivider(),
          _tile(
            context,
            Icons.favorite_border,
            'Wishlist',
            () => Navigator.pushNamed(context, '/wishlist'),
          ),
          const _RowDivider(),
          _tile(
            context,
            Icons.receipt_long_outlined,
            'Orders',
            () => Navigator.pushNamed(context, '/orders'),
          ),
          const _RowDivider(),
          _tile(context, Icons.language, 'Languages', () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Language: English')));
          }),
          const _RowDivider(),
          _tile(context, Icons.palette_outlined, 'Themes', () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Theme follows the reference blue design'),
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
                content: Text('Support: support@buildtechhardware.com'),
              ),
            );
          }),
          const _RowDivider(),
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: const Icon(Icons.logout, color: Colors.red, size: 22),
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
      title: Text(title, style: const TextStyle(fontSize: 14)),
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
