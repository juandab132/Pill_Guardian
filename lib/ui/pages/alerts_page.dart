import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/alerts_controller.dart';

class AlertsPage extends StatelessWidget {
  final AlertsController _controller = Get.put(AlertsController());

  AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas y Notificaciones')),
      body: Obx(() {
        if (_controller.alerts.isEmpty) {
          return const Center(
            child: Text('No hay notificaciones por el momento.'),
          );
        }

        return ListView.builder(
          itemCount: _controller.alerts.length,
          itemBuilder: (context, index) {
            final alert = _controller.alerts[index];
            return ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(alert['title'] ?? ''),
              subtitle: Text(alert['description'] ?? ''),
              trailing: Text(
                alert['timestamp'] ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        );
      }),
    );
  }
}
