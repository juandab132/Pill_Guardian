import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/history_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/widgets/history_tile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Fórmulas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: controller.clearHistory,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.history.isEmpty) {
          return const Center(child: Text('No hay fórmulas almacenadas.'));
        }

        return ListView.builder(
          itemCount: controller.history.length,
          itemBuilder: (context, index) {
            final formula = controller.history[index];
            return HistoryTile(
              formula: formula,
              onTap: () {
                Get.toNamed('/formula-detail', arguments: formula);
              },
            );
          },
        );
      }),
    );
  }
}
