import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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

    final List<BarChartGroupData> barGroups = [];
    final List<String> labels = [];
    int index = 0;

    frecuenciaPorMedicamento.forEach((nombre, horas) {
      labels.add(nombre);
      barGroups.add(
        BarChartGroupData(
          x: index++,
          barRods: [
            BarChartRodData(
              toY: horas.toDouble(),
              color: Colors.blueAccent,
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas de Medicación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            barGroups.isEmpty
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
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _getMaxY(barGroups),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.grey.shade200,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final idx = value.toInt();
                                  if (idx < 0 || idx >= labels.length) {
                                    return const Text('');
                                  }
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      labels[idx],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                                reservedSize: 42,
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: barGroups,
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  double _getMaxY(List<BarChartGroupData> barGroups) {
    double maxY = 0;
    for (var group in barGroups) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) maxY = rod.toY;
      }
    }
    return maxY + 5; // un poco de margen arriba
  }

  int? _extraerHoras(String frecuencia) {
    final match = RegExp(r'(\d{1,2})').firstMatch(frecuencia.toLowerCase());
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }
}
