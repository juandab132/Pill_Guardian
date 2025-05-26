import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';

class RemindersController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();

  var groupedFormulas = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      isLoading.value = true;
      final user = await _appwriteService.getCurrentUser();
      final documents = await _appwriteService.getFormulas(user.$id);

      final Map<String, Map<String, dynamic>> grouped = {};

      for (final doc in documents) {
        final data = doc.data;
        final nombre = (data['nombreFormula'] ?? 'Sin nombre').toString();
        final id = data['userId'];
        final fecha = data['fechaCreacion'];

        final medicamento = {
          'nombre': data['nombre'],
          'dosis': data['dosis'],
          'frecuencia': data['frecuencia'],
          'duracion': data['duracion'],
          'tomado': data['tomado'] ?? false,
          'docId': doc.$id,
        };

        if (!grouped.containsKey(nombre)) {
          grouped[nombre] = {
            'nombreFormula': nombre,
            'fechaCreacion': fecha,
            'userId': id,
            'medicamentos': [medicamento],
          };
        } else {
          grouped[nombre]!['medicamentos'].add(medicamento);
        }
      }

      groupedFormulas.assignAll(grouped.values.toList());
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los recordatorios');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsTaken(String docId) async {
    try {
      await _appwriteService.updateDocumentField(
        documentId: docId,
        field: 'tomado',
        value: true,
      );
      await loadReminders();
    } catch (e) {
      Get.snackbar('Error', 'No se pudo marcar como tomado');
    }
  }
}
