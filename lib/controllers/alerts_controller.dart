import 'package:get/get.dart';

class AlertsController extends GetxController {
  var alerts = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockAlerts();
  }

  void loadMockAlerts() {
    alerts.assignAll([
      {
        'title': 'Dosis omitida',
        'description': 'No registraste la toma de Ibuprofeno a las 8:00 AM.',
        'timestamp': 'Hace 2 horas',
      },
      {
        'title': 'Recordatorio reprogramado',
        'description':
            'La toma de Amoxicilina fue reagendada para las 2:00 PM.',
        'timestamp': 'Hace 1 hora',
      },
      {
        'title': 'Nuevo tratamiento registrado',
        'description': 'Se ha guardado la fórmula “Control Gripe 1”.',
        'timestamp': 'Hoy',
      },
    ]);
  }
}
