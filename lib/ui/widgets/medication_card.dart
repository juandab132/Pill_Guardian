import 'package:flutter/material.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';

class MedicationCard extends StatelessWidget {
  final MedicamentoModel medicamento;

  const MedicationCard({super.key, required this.medicamento});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              medicamento.nombre,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Dosis: ${medicamento.dosis}'),
            Text('Frecuencia: ${medicamento.frecuencia}'),
            Text('Duración: ${medicamento.duracion}'),
          ],
        ),
      ),
    );
  }
}
