import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';

class HistoryController extends GetxController {
  final HiveService _hiveService = HiveService();

  var history = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final formulas = _hiveService.getAllFormulasLocally();
      history.assignAll(formulas);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cargar el historial.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearHistory() async {
    try {
      await _hiveService.clearAllFormulas();
      history.clear();
      Get.snackbar('Historial borrado', 'Todo el historial ha sido eliminado.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo borrar el historial.');
    }
  }
}
