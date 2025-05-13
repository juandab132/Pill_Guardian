import 'package:flutter/material.dart';

class FormulaPreviewCard extends StatelessWidget {
  final Map<String, dynamic> formula;
  final VoidCallback? onTap;

  const FormulaPreviewCard({
    super.key,
    required this.formula,
    this.onTap,
    required Null Function() onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final nombre =
        formula['nombreFormula'] ?? formula['nombre'] ?? 'Sin nombre';
    final fecha = formula['fechaCreacion'] ?? '';
    final cantidadMed = (formula['medicamentos'] as List?)?.length ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text('Fecha: $fecha'),
              Text('Medicamentos: $cantidadMed'),
            ],
          ),
        ),
      ),
    );
  }
}
