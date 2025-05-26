import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/home_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pills Guardian 💊'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Get.toNamed(AppRoutes.alerts),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: Obx(() {
        if (_homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final formulas = _homeController.groupedFormulas;

        if (formulas.isEmpty) {
          return const Center(child: Text('No tienes fórmulas registradas.'));
        }

        return ListView.builder(
          itemCount: formulas.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final formula = formulas[index];

            return Card(
              child: ListTile(
                title: Text(formula['nombreFormula'] ?? 'Sin nombre'),
                subtitle: Text('Fecha: ${formula['fechaCreacion'] ?? ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _homeController.deleteFormula(
                      List<String>.from(formula['ids']),
                    );
                  },
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.formulaDetail, arguments: formula);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.createFormula),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Fórmula'),
      ),
    );
  }
}
