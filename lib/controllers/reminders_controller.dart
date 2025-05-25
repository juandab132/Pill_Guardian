import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';

class RemindersController extends GetxController {
  final HiveService _hiveService = HiveService();

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
}
