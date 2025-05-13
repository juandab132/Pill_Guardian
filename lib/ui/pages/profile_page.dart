import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/auth_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _authController = Get.find();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil 👤')),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Icon(Icons.account_circle, size: 100, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Usuario actual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historial de fórmulas'),
            onTap: () {
              Get.toNamed(AppRoutes.history);
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_alarm),
            title: const Text('Recordatorios'),
            onTap: () {
              Get.toNamed(AppRoutes.reminders);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Estadísticas'),
            onTap: () {
              Get.toNamed(AppRoutes.statistics);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () {
              _authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
