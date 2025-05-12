import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';
import 'package:appwrite/models.dart';

class HomeController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();

  var formulas = <Document>[].obs;
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
      final fetched = await _appwriteService.getFormulas(user.$id);
      formulas.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las fórmulas.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFormula(String documentId) async {
    try {
      await _appwriteService.deleteFormula(documentId);
      formulas.removeWhere((doc) => doc.$id == documentId);
      Get.snackbar('Eliminado', 'Fórmula eliminada correctamente.');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la fórmula.');
    }
  }
}
