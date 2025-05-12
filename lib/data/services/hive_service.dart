import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;

  late Box _formulasBox;

  HiveService._internal();

  Future<void> init() async {
    await Hive.initFlutter();
    _formulasBox = await Hive.openBox('formulasBox');
  }

  Future<void> saveFormulaLocally({
    required String formulaId,
    required Map<String, dynamic> formulaData,
  }) async {
    await _formulasBox.put(formulaId, formulaData);
  }

  List<Map<String, dynamic>> getAllFormulasLocally() {
    return _formulasBox.values
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Map<String, dynamic>? getFormulaById(String formulaId) {
    final data = _formulasBox.get(formulaId);
    if (data != null) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  Future<void> deleteFormulaLocally(String formulaId) async {
    await _formulasBox.delete(formulaId);
  }

  Future<void> clearAllFormulas() async {
    await _formulasBox.clear();
  }
}
