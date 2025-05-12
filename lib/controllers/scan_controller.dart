import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/ocr_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/models/medicamento_model.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

class ScanController extends GetxController {
  final OCRService _ocrService = OCRService();

  var extractedText = ''.obs;
  var medicamentos = <MedicamentoModel>[].obs;
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> scanFormula({bool fromGallery = false}) async {
    try {
      isLoading.value = true;

      final pickedFile = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        extractedText.value = await _ocrService.scanImage(imageFile);

        final parsedMedicamentos = _ocrService.processExtractedText(
          extractedText.value,
        );

        medicamentos.assignAll(parsedMedicamentos);

        Get.toNamed(AppRoutes.formulaSummary);
      } else {
        Get.snackbar('Escaneo cancelado', 'No se seleccionó ninguna imagen.');
      }
    } catch (e) {
      Get.snackbar('Error al escanear', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearData() {
    extractedText.value = '';
    medicamentos.clear();
  }
}
