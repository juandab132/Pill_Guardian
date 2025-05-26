import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';

class HomeController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();

  var formulas = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFormulas();
  }

  Future<void> loadFormulas() async {
    try {
      isLoading.value = true;
      final user = await _appwriteService.getCurrentUser();
      final result = await _appwriteService.getFormulas(user.$id);

      // Convertimos cada documento a Map y añadimos su ID
      final fetched =
          result.map((doc) {
            final data = doc.data;
            data['id'] = doc.$id;
            return data;
          }).toList();

      formulas.assignAll(fetched);
    } catch (_) {
      Get.snackbar('Error', 'No se pudieron cargar las fórmulas.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFormula(String documentId) async {
    try {
      await _appwriteService.deleteFormula(documentId);
      formulas.removeWhere((doc) => doc['id'] == documentId);
      Get.snackbar('Eliminado', 'Fórmula eliminada correctamente.');
    } catch (_) {
      Get.snackbar('Error', 'No se pudo eliminar la fórmula.');
    }
  }
}
