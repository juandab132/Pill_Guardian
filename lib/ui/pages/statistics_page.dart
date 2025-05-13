import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';

class StatisticsPage extends StatelessWidget {
  final HiveService _hiveService = HiveService();

  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formulas = _hiveService.getAllFormulasLocally();
    final List<MedicamentoModel> allMedicamentos = [];

    for (var formula in formulas) {
      final meds =
          (formula['medicamentos'] as List)
              .map((e) => MedicamentoModel.fromMap(e))
              .toList();
      allMedicamentos.addAll(meds);
    }

    final Map<String, int> frecuenciaPorMedicamento = {};
    for (var med in allMedicamentos) {
      final nombre = med.nombre;
      final frecuencia = _extraerHoras(med.frecuencia);
      if (frecuencia != null) {
        frecuenciaPorMedicamento[nombre] =
            (frecuenciaPorMedicamento[nombre] ?? 0) + frecuencia;
      }
    }

    final List<charts.Series<MedicamentoStats, String>> series = [
      charts.Series(
        id: 'Frecuencia por medicamento',
        data:
            frecuenciaPorMedicamento.entries
                .map(
                  (e) => MedicamentoStats(nombre: e.key, totalHoras: e.value),
                )
                .toList(),
        domainFn: (MedicamentoStats stats, _) => stats.nombre,
        measureFn: (MedicamentoStats stats, _) => stats.totalHoras,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (MedicamentoStats stats, _) => '${stats.totalHoras} h',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas de Medicación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            series.first.data.isEmpty
                ? const Center(child: Text('No hay datos para mostrar.'))
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Frecuencia total por medicamento (horas)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: charts.BarChart(
                        series,
                        animate: true,
                        vertical: true,
                        barRendererDecorator:
                            charts.BarLabelDecorator<String>(),
                        domainAxis: const charts.OrdinalAxisSpec(),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  int? _extraerHoras(String frecuencia) {
    final match = RegExp(r'(\d{1,2})').firstMatch(frecuencia.toLowerCase());
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }
}

class MedicamentoStats {
  final String nombre;
  final int totalHoras;

  MedicamentoStats({required this.nombre, required this.totalHoras});
}
