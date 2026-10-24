import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Reusable role login page for Admin and Delivery panels.
class RoleLoginPage extends StatefulWidget {
  const RoleLoginPage({
    super.key,
    required this.title,
    required this.routeAfterLogin,
    required this.panelColor,
  });

  final String title;
  final String routeAfterLogin;
  final Color panelColor;

  @override
  State<RoleLoginPage> createState() => _RoleLoginPageState();
}

class _RoleLoginPageState extends State<RoleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        widget.routeAfterLogin,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
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
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const BuildTechLogo(width: 150, height: 62),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'High Quality hardware solution built to last.',
                          style: TextStyle(
                            fontSize: 12,
                            color: kTagBlue,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: kAuthPanel,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          22,
                          26,
                          22,
                          20 + keyboardInset.clamp(0.0, 120.0),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sign in to continue to your account',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@') ||
                                      !value.contains('.')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
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
                                      () =>
                                          _obscurePassword = !_obscurePassword,
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
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/forgot-password',
                                  ),
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: kIndigo,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              PrimaryBlueButton(
                                label: 'Sign In',
                                onPressed: _login,
                              ),
                              const SizedBox(height: 14),
                              Center(
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/role-picker',
                                        (r) => false,
                                      ),
                                  child: const Text(
                                    'Switch Panel',
                                    style: TextStyle(color: kIndigo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleLoginPage(
      title: 'Admin Login',
      routeAfterLogin: '/admin/dashboard',
      panelColor: Color(0xFF619DCA),
    );
  }
}

class DeliveryLoginPage extends StatelessWidget {
  const DeliveryLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleLoginPage(
      title: 'Delivery Login',
      routeAfterLogin: '/delivery/dashboard',
      panelColor: Color(0xFF67A4D2),
    );
  }
}
