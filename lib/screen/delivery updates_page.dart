import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

/// Delivery Updates — reachable via /delivery/updates
class DeliveryUpdatesPage extends StatefulWidget {
  const DeliveryUpdatesPage({super.key});

  @override
  State<DeliveryUpdatesPage> createState() => _DeliveryUpdatesPageState();
}

class _DeliveryUpdatesPageState extends State<DeliveryUpdatesPage> {
  final List<String> orders = [
    'BTD1234567890',
    'BTD6278364752',
    'BTD6278365778',
    'BTD6278378689',
  ];

  int currentStep = 2; // 0=Assigned,1=Picked Up,2=Out for Delivery,3=Delivered

  final List<String> steps = [
    'Assigned',
    'Picked Up',
    'Out for Delivery',
    'Delivered',
  ];

  final List<IconData> stepIcons = [
    Icons.assignment_outlined,
    Icons.local_shipping_outlined,
    Icons.delivery_dining_outlined,
    Icons.check_circle_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DeliveryDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Delivery Updates',
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
            colors: [Color(0xFF67A4D2), Color(0xFF365D7B)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Progress stepper ──
              const Text(
                'Delivery Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              _buildProgressStepper(),

              const SizedBox(height: 28),

              // ── Update status button ──
              if (currentStep < steps.length - 1)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF365D7B),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.update),
                  label: Text(
                    'Mark as ${steps[currentStep + 1]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() => currentStep++);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Status updated to ${steps[currentStep]}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                )
              else
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.greenAccent),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.greenAccent, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'All orders delivered!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 28),

              // ── Complete orders ──
              const Text(
                'Complete Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              ...orders.map((id) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _orderCard(id),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStepper() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: List.generate(steps.length, (i) {
          final done = i <= currentStep;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: done ? Colors.white : Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      stepIcons[i],
                      size: 18,
                      color: done
                          ? const Color(0xFF365D7B)
                          : Colors.white54,
                    ),
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 2,
                      height: 30,
                      color: done ? Colors.white70 : Colors.white24,
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  steps[i],
                  style: TextStyle(
                    color: done ? Colors.white : Colors.white54,
                    fontSize: 14,
                    fontWeight:
                        done ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _orderCard(String orderId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long,
              color: Color(0xFF365D7B), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              orderId,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF899AE0).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              steps[currentStep],
              style: const TextStyle(
                  color: Color(0xFF4E5FA4),
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}