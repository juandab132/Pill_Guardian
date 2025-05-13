import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final Map<String, dynamic> formula;
  final VoidCallback? onTap;

  const HistoryTile({super.key, required this.formula, this.onTap});

  @override
  Widget build(BuildContext context) {
    final nombre =
        formula['nombreFormula'] ?? formula['nombre'] ?? 'Sin nombre';
    final fecha = formula['fechaCreacion'] ?? '';

    return ListTile(
      title: Text(
        nombre.toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Fecha: $fecha'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
