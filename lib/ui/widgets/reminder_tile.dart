import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  final String medicamentoNombre;
  final String dosis;
  final String frecuencia;
  final bool tomado;
  final VoidCallback onToggle;

  const ReminderTile({
    super.key,
    required this.medicamentoNombre,
    required this.dosis,
    required this.frecuencia,
    required this.tomado,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tomado ? Colors.green.shade50 : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          medicamentoNombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Dosis: $dosis\nFrecuencia: $frecuencia'),
        trailing: IconButton(
          icon: Icon(
            tomado ? Icons.check_circle : Icons.radio_button_unchecked,
            color: tomado ? Colors.green : Colors.grey,
          ),
          onPressed: onToggle,
          tooltip: tomado ? 'Tomado' : 'Marcar como tomado',
        ),
      ),
    );
  }
}
