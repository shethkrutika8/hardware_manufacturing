import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/panel_scaffold.dart';

class DeliveryPickedUpPage extends StatelessWidget {
  const DeliveryPickedUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Picked Up Orders',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in ['BTD1234567890', 'BTD6278364752', 'BTD6278365778'])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PanelOrderTile(
              orderId: id,
              status: 'Picked Up',
              statusColor: Colors.amber,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}

class DeliveryOutForDeliveryPage extends StatelessWidget {
  const DeliveryOutForDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Out for Delivery',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in ['BTD1234567890', 'BTD6278364752'])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PanelOrderTile(
              orderId: id,
              status: 'Out for Delivery',
              statusColor: Colors.orangeAccent,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}

class DeliveryDeliveredPage extends StatelessWidget {
  const DeliveryDeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelPage(
      title: 'Delivered',
      drawer: const DeliveryDrawer(),
      children: [
        for (final id in [
          'BTD6278378689',
          'BTD6278376432',
          'BTD6768364752',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PanelOrderTile(
              orderId: id,
              status: 'Delivered',
              statusColor: Colors.greenAccent,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/order-details'),
            ),
          ),
      ],
    );
  }
}
