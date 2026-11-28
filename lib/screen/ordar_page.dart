import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/firebase_service.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  final List<Customer> fallbackCustomers = const [
    Customer(
      initials: 'KS',
      name: 'Krutika Sheth',
      email: 'Krutika@gmail.com',
      ordersCount: 8,
      phone: '+91 98765 43210',
    ),
    Customer(
      initials: 'DP',
      name: 'Dhruvisha Patel',
      email: 'Dhruvisha@gmail.com',
      ordersCount: 4,
      phone: '+91 98765 43211',
    ),
    Customer(
      initials: 'UH',
      name: 'Upal Hirapara',
      email: 'Upal@gmail.com',
      ordersCount: 6,
      phone: '+91 98765 43212',
    ),
    Customer(
      initials: 'PS',
      name: 'Piyu Solanki',
      email: 'Piyu@gmail.com',
      ordersCount: 2,
      phone: '+91 98765 43213',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Customers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF66A3D1),
              Color(0xFF365D7B),
            ],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseService.instance.streamAllUsers(),
            builder: (context, snapshot) {
              List<Customer> customerList = [];

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                for (final doc in snapshot.data!.docs) {
                  final data = doc.data();
                  final name = data['name'] ?? 'User';
                  final email = data['email'] ?? '';
                  final phone = data['mobile'] ?? data['phone'] ?? '';
                  final initials = name.isNotEmpty
                      ? name.split(' ').map((s) => s.isNotEmpty ? s[0] : '').take(2).join().toUpperCase()
                      : 'U';
                  customerList.add(
                    Customer(
                      initials: initials,
                      name: name,
                      email: email,
                      ordersCount: 1,
                      phone: phone,
                    ),
                  );
                }
              }

              if (customerList.isEmpty) {
                customerList = fallbackCustomers;
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: customerList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return _customerCard(context, customerList[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _customerCard(BuildContext context, Customer customer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFEF7D82),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                customer.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customer.email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Orders: ${customer.ordersCount} | Phone: ${customer.phone}',
                  style: const TextStyle(
                    color: Color(0xFF365D7B),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}

class Customer {
  final String initials;
  final String name;
  final String email;
  final int ordersCount;
  final String phone;

  const Customer({
    required this.initials,
    required this.name,
    required this.email,
    required this.ordersCount,
    required this.phone,
  });
}