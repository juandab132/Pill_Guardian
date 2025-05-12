import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/scan_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

class MedicationController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();
  final HiveService _hiveService = HiveService();
  final ScanController _scanController = Get.find();

  var isSaving = false.obs;

  Future<void> saveFormula(String nombreFormula) async {
    try {
      isSaving.value = true;

      final user = await _appwriteService.getCurrentUser();

      final medicamentos = _scanController.medicamentos;

      await _appwriteService.createFormula(
        userId: user.$id,
        nombreFormula: nombreFormula,
        medicamentos: medicamentos,
      );

      final formulaId = DateTime.now().millisecondsSinceEpoch.toString();
      final formulaData = {
        'nombreFormula': nombreFormula,
        'medicamentos': medicamentos.map((m) => m.toMap()).toList(),
        'fechaCreacion': DateTime.now().toIso8601String(),
      };

      await _hiveService.saveFormulaLocally(
        formulaId: formulaId,
        formulaData: formulaData,
      );

      Get.snackbar('Fórmula guardada', 'Se guardó exitosamente.');
      _scanController.clearData();

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error al guardar', e.toString());
    } finally {
      isSaving.value = false;
    }
  }
}
