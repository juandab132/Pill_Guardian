import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';

class FormulaDetailPage extends StatelessWidget {
  final Map<String, dynamic> formula = Map<String, dynamic>.from(Get.arguments);

  FormulaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MedicamentoModel> medicamentos =
        (formula['medicamentos'] as List)
            .map((e) => MedicamentoModel.fromMap(Map<String, dynamic>.from(e)))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(formula['nombreFormula'] ?? 'Detalles de Fórmula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formula['fechaCreacion'] != null)
              Text(
                'Fecha de creación: ${formula['fechaCreacion']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 12),
            const Text(
              'Medicamentos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: medicamentos.length,
                itemBuilder: (context, index) {
                  final med = medicamentos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med.nombre,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Dosis: ${med.dosis}'),
                          Text('Frecuencia: ${med.frecuencia}'),
                          Text('Duración: ${med.duracion}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
