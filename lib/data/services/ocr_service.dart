import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import '../models/medicamento_model.dart';

class OCRService {
  static final OCRService _instance = OCRService._internal();
  factory OCRService() => _instance;

  final TextRecognizer _textRecognizer = TextRecognizer();

  OCRService._internal();

  Future<String> scanImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText = await _textRecognizer.processImage(
      inputImage,
    );
    return recognizedText.text;
  }

  List<MedicamentoModel> processExtractedText(String text) {
    final lines =
        text
            .split('\n')
            .map((line) => line.trim().toUpperCase())
            .where((line) => line.isNotEmpty)
            .toList();

    List<MedicamentoModel> medicamentos = [];

    String? nombre;
    String? dosis;
    String? frecuencia;
    String? duracion;

    for (var line in lines) {
      if (line.startsWith('CÓDIGO') ||
          line.startsWith('DOSIS') ||
          line.startsWith('VIA') ||
          line.contains('OBSERVACION')) {
        continue;
      }

      // Detectar duración
      final matchDuracionDias = RegExp(
        r'POR\s+(\d{1,3})\s*D[ÍI]AS?',
      ).firstMatch(line);
      final matchDuracionMeses = RegExp(r'(\d{1,2})\s*MESES?').firstMatch(line);
      if (matchDuracionDias != null) {
        duracion = '${matchDuracionDias.group(1)} días';
      } else if (matchDuracionMeses != null) {
        duracion = '${matchDuracionMeses.group(1)} meses';
      }

      // Detectar frecuencia
      final matchFrecuencia = RegExp(
        r'CADA\s+(\d{1,2})\s*HORAS?',
      ).firstMatch(line);
      if (matchFrecuencia != null) {
        frecuencia = 'Cada ${matchFrecuencia.group(1)} horas';
      }

      // Detectar medicamento y dosis
      final matchMedicamento = RegExp(
        r'^([A-ZÑÁÉÍÓÚ0-9\s]{3,})\s+(\d+\s?(MG|ML|MCG|AMP|TAB|G))',
      ).firstMatch(line);
      if (matchMedicamento != null) {
        nombre = matchMedicamento.group(1)?.trim();
        dosis = matchMedicamento.group(2)?.trim();
      }

      // Si solo hay dosis en otra línea (como "1 TAB") la tomamos como dosis también
      final matchSoloDosis = RegExp(
        r'^(\d+\s?(TAB|AMP|MG|ML))$',
      ).firstMatch(line);
      if (matchSoloDosis != null && dosis == null) {
        dosis = matchSoloDosis.group(1);
      }

      // Si detectamos nombre o dosis y al menos uno de los otros campos, lo agregamos
      if (nombre != null &&
          (dosis != null || frecuencia != null || duracion != null)) {
        medicamentos.add(
          MedicamentoModel(
            nombre: nombre,
            dosis: dosis ?? 'No especificada',
            frecuencia: frecuencia ?? 'No especificada',
            duracion: duracion ?? 'No especificada',
          ),
        );

        // Reiniciar
        nombre = null;
        dosis = null;
        frecuencia = null;
        duracion = null;
      }
    }

    return medicamentos;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
