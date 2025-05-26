import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/medication_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/scan_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';

class FormulaSummaryPage extends StatefulWidget {
  const FormulaSummaryPage({super.key});

  @override
  State<FormulaSummaryPage> createState() => _FormulaSummaryPageState();
}

class _FormulaSummaryPageState extends State<FormulaSummaryPage> {
  final TextEditingController formulaNameController = TextEditingController();
  final ScanController _scanController = Get.find();
  final MedicationController _medicationController = Get.put(
    MedicationController(),
  );

  void _agregarMedicamentoManual() {
    _scanController.medicamentos.add(
      MedicamentoModel(nombre: '', dosis: '', frecuencia: '', duracion: ''),
    );
  }

  void _eliminarMedicamento(int index) {
    _scanController.medicamentos.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de Fórmula')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: formulaNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Fórmula',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _agregarMedicamentoManual,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar medicamento'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _scanController.medicamentos.length,
                  itemBuilder: (context, index) {
                    final medicamento = _scanController.medicamentos[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Medicamento',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _eliminarMedicamento(index),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: medicamento.nombre,
                              decoration: const InputDecoration(
                                labelText: 'Nombre',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => medicamento.nombre = value,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: medicamento.dosis,
                              decoration: const InputDecoration(
                                labelText: 'Dosis',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => medicamento.dosis = value,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: medicamento.frecuencia,
                              decoration: const InputDecoration(
                                labelText: 'Frecuencia',
                                border: OutlineInputBorder(),
                              ),
                              onChanged:
                                  (value) => medicamento.frecuencia = value,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              initialValue: medicamento.duracion,
                              decoration: const InputDecoration(
                                labelText: 'Duración',
                                border: OutlineInputBorder(),
                              ),
                              onChanged:
                                  (value) => medicamento.duracion = value,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () =>
                  _medicationController.isSaving.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                        onPressed: () {
                          final nombre =
                              formulaNameController.text.trim().isEmpty
                                  ? 'Fórmula sin nombre'
                                  : formulaNameController.text.trim();
                          _medicationController.saveFormula(nombre);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar Fórmula'),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
