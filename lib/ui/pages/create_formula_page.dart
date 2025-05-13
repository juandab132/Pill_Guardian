import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/scan_controller.dart';

class CreateFormulaPage extends StatelessWidget {
  final ScanController _scanController = Get.put(ScanController());

  CreateFormulaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Fórmula Médica')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Obx(() {
            if (_scanController.isLoading.value) {
              return const CircularProgressIndicator();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Cómo deseas escanear la fórmula médica?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Usar Cámara'),
                  onPressed:
                      () => _scanController.scanFormula(fromGallery: false),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Seleccionar de Galería'),
                  onPressed:
                      () => _scanController.scanFormula(fromGallery: true),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
