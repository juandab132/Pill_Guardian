import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';

class HomeController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();

  var groupedFormulas = <Map<String, dynamic>>[].obs;
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
      final documents = await _appwriteService.getFormulas(user.$id);

      final Map<String, Map<String, dynamic>> grouped = {};

      for (final doc in documents) {
        final data = doc.data;
        final nombre = (data['nombreFormula'] ?? 'Sin nombre').toString();
        final fecha = data['fechaCreacion'];
        final docId = doc.$id;

        final key = '$nombre|$fecha';

        final medicamento = {
          'nombre': data['nombre'],
          'dosis': data['dosis'],
          'frecuencia': data['frecuencia'],
          'duracion': data['duracion'],
          'tomado': data['tomado'] ?? false,
          'docId': docId,
        };

        if (!grouped.containsKey(key)) {
          grouped[key] = {
            'nombreFormula': nombre,
            'fechaCreacion': fecha,
            'medicamentos': [medicamento],
            'ids': [docId],
          };
        } else {
          grouped[key]!['medicamentos'].add(medicamento);
          grouped[key]!['ids'].add(docId);
        }
      }

      groupedFormulas.assignAll(grouped.values.toList());
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar las fórmulas');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFormula(List<String> documentIds) async {
    try {
      for (final id in documentIds) {
        await _appwriteService.deleteFormula(id);
      }
      loadFormulas();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar la fórmula');
    }
  }
}
