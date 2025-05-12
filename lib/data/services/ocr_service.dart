import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

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

  List<Map<String, String>> processExtractedText(String text) {
    final lines =
        text.split('\n').map((line) => line.trim().toUpperCase()).toList();
    List<Map<String, String>> medicamentos = [];

    String? nombre;
    String? dosis;
    String? frecuencia;
    String? duracion;

    for (var line in lines) {
      if (line.isEmpty) continue;

      final regexMed = RegExp(
        r'^([A-ZÑÁÉÍÓÚ0-9\s]+)\s+(\d+MG|\d+ ML|\d+ MCG)?',
      );
      final match = regexMed.firstMatch(line);
      if (match != null) {
        nombre = match.group(1)?.trim();
        dosis = match.group(2)?.trim();
      }

      final matchFrecuencia = RegExp(
        r'CADA\s+(\d{1,2})\s*HORAS?',
      ).firstMatch(line);
      if (matchFrecuencia != null) {
        frecuencia = 'Cada ${matchFrecuencia.group(1)} horas';
      }

      final matchDuracion = RegExp(
        r'POR\s+(\d{1,3})\s*D[IÍ]AS?',
      ).firstMatch(line);
      if (matchDuracion != null) {
        duracion = '${matchDuracion.group(1)} días';
      }

      if (nombre != null &&
          (dosis != null || frecuencia != null || duracion != null)) {
        medicamentos.add({
          'nombre': nombre,
          'dosis': dosis ?? 'No especificada',
          'frecuencia': frecuencia ?? 'No especificada',
          'duracion': duracion ?? 'No especificada',
        });

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
