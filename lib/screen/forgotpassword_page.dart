import 'package:flutter/material.dart';

void main() {
  runApp(const BuildTechApp());
}

class BuildTechApp extends StatelessWidget {
  const BuildTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuildTech Hardware',
      theme: ThemeData(
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const ForgotPasswordPage(),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void sendOTP() {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP sent to your email'),
      ),
    );
  }

  void resendOTP() {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email first'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent successfully'),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF54B6DB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF55B9DE),
                        Color(0xFF3D8BAA),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      // Logo
                      Container(
                        width: 170,
                        height: 70,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0B2945),
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'B',
                                  style: TextStyle(
                                    color: Color(0xFF1457A6),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BuildTech',
                                  style: TextStyle(
                                    color: Color(0xFF12243A),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'H A R D W A R E',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Forgot Password
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Color(0xFF18159C),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Small line
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 55,
                            height: 1,
                            color: Colors.white24,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Description
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 44),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'High-Quality hardware solution built to\nlast.',
                            style: TextStyle(
                              color: Color(0xFF11186C),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 45),

                      // Bottom Card
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: 333,
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          32,
                          40,
                          32,
                          30,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC1D9E2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Entre your email ID we’ll send',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),

                            const Text(
                              'you a verification code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Email field
                            Container(
                              height: 35,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xFFE3A3A3),
                                    size: 25,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 59),

                            // Send OTP Button
                            SizedBox(
                              width: 202,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: sendOTP,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5068C8),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                child: const Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Resend OTP
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: resendOTP,
                                child: const Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
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
              ),
            );
          },
        ),
      ),
    );
  }
}