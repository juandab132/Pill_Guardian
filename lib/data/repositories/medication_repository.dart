import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart';

class MedicationRepository {
  final AppwriteService _appwriteService = AppwriteService();
  final HiveService _hiveService = HiveService();

  Future<void> saveFormulaToCloud({
    required String userId,
    required String nombreFormula,
    required List<MedicamentoModel> medicamentos,
  }) async {
    await _appwriteService.createFormula(
      userId: userId,
      nombreFormula: nombreFormula,
      medicamentos: medicamentos,
    );
  }

  Future<void> saveFormulaLocally({
    required String formulaId,
    required String nombreFormula,
    required List<MedicamentoModel> medicamentos,
    required String fechaCreacion,
  }) async {
    await _hiveService.saveFormulaLocally(
      formulaId: formulaId,
      formulaData: {
        'nombreFormula': nombreFormula,
        'medicamentos': medicamentos.map((e) => e.toMap()).toList(),
        'fechaCreacion': fechaCreacion,
      },
    );
  }

  List<Map<String, dynamic>> getLocalFormulas() {
    return _hiveService.getAllFormulasLocally();
  }

  Map<String, dynamic>? getFormulaById(String formulaId) {
    return _hiveService.getFormulaById(formulaId);
  }

  Future<void> clearLocalFormulas() async {
    await _hiveService.clearAllFormulas();
  }
}
