import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';
import 'package:hardware_manufacturing/screen/notification_store.dart';
import 'package:hardware_manufacturing/screen/firebase_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      body: Column(
        children: [
          const PageHeading('Notifications'),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseService.instance.streamNotifications(),
              builder: (context, snapshot) {
                // If firestore has items, display them; otherwise fallback to local in-memory store
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 18),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data();
                      final title = data['title'] ?? 'Notification';
                      final message = data['message'] ?? '';
                      final isRead = data['isRead'] ?? false;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isRead ? const Color(0xfff7f9fc) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isRead ? Colors.transparent : const Color(0xffd7e9f6),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: isRead ? Colors.grey : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff22303c),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xff5c6b76),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () => FirebaseService.instance
                                  .markNotificationRead(doc.id, !isRead),
                              icon: Icon(
                                isRead
                                    ? Icons.mark_email_read_outlined
                                    : Icons.mark_email_unread_outlined,
                                size: 18,
                                color: kIndigo,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                // Fallback to local store
                return ValueListenableBuilder<int>(
                  valueListenable: NotificationStore.changeNotifier,
                  builder: (context, _, _) {
                    final items = NotificationStore.items;
                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'No notifications yet.',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 4, 14, 18),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: item.isRead
                                ? const Color(0xfff7f9fc)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: item.isRead
                                  ? Colors.transparent
                                  : const Color(0xffd7e9f6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: item.isRead ? Colors.grey : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff22303c),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.message,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        color: Color(0xff5c6b76),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () =>
                                    NotificationStore.toggleRead(index),
                                icon: Icon(
                                  item.isRead
                                      ? Icons.mark_email_read_outlined
                                      : Icons.mark_email_unread_outlined,
                                  size: 18,
                                  color: kIndigo,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: kGradBottom,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: WhitePillButton(
              label: 'Mark All as Read',
              onPressed: () => NotificationStore.markAllRead(),
            ),
          ),
        ],
      ),
    );
  }
}
