import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/notification_service.dart';

class RemindersController extends GetxController {
  final HiveService _hiveService = HiveService();
  final NotificationService _notificationService = NotificationService();

  var reminders = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      isLoading.value = true;
      final formulas = _hiveService.getAllFormulasLocally();
      reminders.assignAll(formulas);
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los recordatorios.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsTaken(String formulaId, int medicamentoIndex) async {
    final formula = _hiveService.getFormulaById(formulaId);
    if (formula == null) return;

    final medicamentos = List<Map<String, dynamic>>.from(
      formula['medicamentos'] ?? [],
    );
    if (medicamentoIndex >= 0 && medicamentoIndex < medicamentos.length) {
      medicamentos[medicamentoIndex]['tomado'] = true;
      formula['medicamentos'] = medicamentos;

      await _hiveService.saveFormulaLocally(
        formulaId: formulaId,
        formulaData: formula,
      );
      await loadReminders();
    }
  }

  Future<void> scheduleAllNotifications() async {
    final formulas = _hiveService.getAllFormulasLocally();

    for (final entry in formulas) {
      final medicamentos = List<Map<String, dynamic>>.from(
        entry['medicamentos'] ?? [],
      );
      for (int i = 0; i < medicamentos.length; i++) {
        final med = medicamentos[i];
        final frecuencia = med['frecuencia']?.toString().toLowerCase();

        int? horas;
        final match = RegExp(r'(\d{1,2})').firstMatch(frecuencia ?? '');
        if (match != null) {
          horas = int.tryParse(match.group(1)!);
        }

        if (horas != null) {
          await _notificationService.scheduleNotification(
            id: i + entry['nombreFormula'].hashCode,
            title: 'Tomar medicamento: ${med['nombre']}',
            body: 'Dosis: ${med['dosis']} - Frecuencia: ${med['frecuencia']}',
            intervaloHoras: horas,
            scheduledTime: _notificationService.getNextScheduledTime(horas),
          );
        }
      }
    }
  }

  Future<void> cancelAllNotifications() async {
    await _notificationService.cancelAllNotifications();
  }
}
