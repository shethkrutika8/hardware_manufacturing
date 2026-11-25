import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/firebase_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _demoOtp;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp({required bool resend}) async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await FirebaseService.instance.sendPasswordReset(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset link sent to your email! Please check your inbox.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send reset email: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageScaffold(
      header: const Text(
        'Forgot Password',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff1747c0)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Enter your email ID and we'll send you a verification code.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Color(0xff2b3a45), height: 1.5),
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: authFieldDecoration('Email', prefix: const GmailIcon()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Enter email';
                  if (!value.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 40),
              PrimaryBlueButton(
                label: 'Send OTP',
                onPressed: () => _sendOtp(resend: false),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _sendOtp(resend: true),
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 4)),
                  child: const Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: Color(0xff40505c),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              if (_demoOtp != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Demo OTP: $_demoOtp',
                  style: const TextStyle(color: kNavy, fontWeight: FontWeight.w600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  ),
                  child: const Text(
                    'Back to Sign In',
                    style: TextStyle(fontSize: 10, color: kIndigo),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
