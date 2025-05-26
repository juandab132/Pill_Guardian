import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/reminders_controller.dart';

class RemindersPage extends StatelessWidget {
  final RemindersController _controller = Get.put(RemindersController());

  RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios 💊'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.loadReminders(),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.groupedFormulas.isEmpty) {
          return const Center(child: Text('No hay recordatorios disponibles.'));
        }

        return ListView.builder(
          itemCount: _controller.groupedFormulas.length,
          itemBuilder: (context, index) {
            final formula = _controller.groupedFormulas[index];
            final medicamentos = List<Map<String, dynamic>>.from(
              formula['medicamentos'] ?? [],
            );

            return ExpansionTile(
              title: Text(formula['nombreFormula'] ?? 'Sin nombre'),
              subtitle: Text('Fecha: ${formula['fechaCreacion'] ?? ''}'),
              children:
                  medicamentos.map((med) {
                    final tomado = med['tomado'] == true;

                    return ListTile(
                      title: Text(med['nombre'] ?? 'Sin nombre'),
                      subtitle: Text(
                        'Dosis: ${med['dosis']} | Frecuencia: ${med['frecuencia']} | Duración: ${med['duracion']}',
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          tomado
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: tomado ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          if (!tomado) {
                            _controller.markAsTaken(med['docId']);
                          }
                        },
                      ),
                    );
                  }).toList(),
            );
          },
        );
      }),
    );
  }
}
