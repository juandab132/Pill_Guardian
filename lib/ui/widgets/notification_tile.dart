import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final DateTime dateTime;

  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(
          _formatDateTime(dateTime),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
