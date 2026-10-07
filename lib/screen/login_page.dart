import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _selectedRole = 'Customer'; // 'Customer', 'Admin', 'Delivery'

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim().toLowerCase();

      // Role-based routing as requested:
      // 1. If explicit role chosen as Admin or email contains admin -> Admin Dashboard
      // 2. If explicit role chosen as Delivery or email contains delivery -> Delivery Dashboard
      // 3. Otherwise -> Customer Home
      if (_selectedRole == 'Admin' || email.contains('admin')) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/admin/dashboard',
          (route) => false,
        );
      } else if (_selectedRole == 'Delivery' || email.contains('delivery')) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/delivery/dashboard',
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    }
  }

  void _setRole(String role) {
    setState(() {
      _selectedRole = role;
      if (role == 'Admin' && _emailController.text.isEmpty) {
        _emailController.text = 'admin@buildtech.com';
        _passwordController.text = '123456';
      } else if (role == 'Delivery' && _emailController.text.isEmpty) {
        _emailController.text = 'delivery@buildtech.com';
        _passwordController.text = '123456';
      } else if (role == 'Customer' &&
          (_emailController.text == 'admin@buildtech.com' ||
              _emailController.text == 'delivery@buildtech.com')) {
        _emailController.clear();
        _passwordController.clear();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return AuthPageScaffold(
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedRole == 'Admin'
                ? 'Admin Portal'
                : _selectedRole == 'Delivery'
                    ? 'Delivery Portal'
                    : 'Welcome Back',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _selectedRole == 'Admin'
                ? 'Sign in to access BuildTech Admin Dashboard'
                : _selectedRole == 'Delivery'
                    ? 'Sign in to access Delivery Staff Panel'
                    : 'High Quality hardware solution built to last.',
            style: const TextStyle(
              fontSize: 12,
              color: kTagBlue,
              height: 1.3,
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + keyboardInset.clamp(0, 120),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Role Selector Segmented Tabs ──
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Row(
                  children: [
                    _roleTab('Customer', 'Customer'),
                    _roleTab('Admin', 'Admin'),
                    _roleTab('Delivery', 'Delivery'),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Sign in to continue to your account',
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
              const SizedBox(height: 14),

              // ── Email Field ──
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: authFieldDecoration(
                  'Email',
                  prefix: const Icon(
                    Icons.email_outlined,
                    color: Color(0xffb7b3b7),
                    size: 22,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // ── Password Field ──
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: authFieldDecoration(
                  'Password',
                  prefix: const Icon(
                    Icons.lock_outline,
                    color: Color(0xffb7b3b7),
                    size: 22,
                  ),
                ).copyWith(
                  suffixIcon: IconButton(
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xff7d8791),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // ── Forgot Password ──
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: kIndigo,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // ── Sign In Button ──
              PrimaryBlueButton(
                label: _selectedRole == 'Admin'
                    ? 'Sign In as Admin'
                    : _selectedRole == 'Delivery'
                        ? 'Sign In as Delivery Staff'
                        : 'Sign In',
                onPressed: _login,
              ),

              const SizedBox(height: 16),

              // ── Register link ──
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: kIndigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ── Switch Panel Selector ──
              Center(
                child: TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/role-picker'),
                  icon: const Icon(Icons.dashboard_customize_outlined, size: 16),
                  label: const Text(
                    'Switch Panel / Role Picker',
                    style: TextStyle(fontSize: 12, color: kIndigo),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleTab(String role, String label) {
    final isSelected = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => _setRole(role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? kNavy : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
