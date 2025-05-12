class MedicamentoModel {
  final String nombre;
  final String dosis;
  final String frecuencia;
  final String duracion;

  MedicamentoModel({
    required this.nombre,
    required this.dosis,
    required this.frecuencia,
    required this.duracion,
  });

  factory MedicamentoModel.fromMap(Map<String, dynamic> map) {
    return MedicamentoModel(
      nombre: map['nombre'] ?? 'No especificado',
      dosis: map['dosis'] ?? 'No especificada',
      frecuencia: map['frecuencia'] ?? 'No especificada',
      duracion: map['duracion'] ?? 'No especificada',
    );
  }

  Map<String, String> toMap() {
    return {
      'nombre': nombre,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'duracion': duracion,
    };
  }

  @override
  String toString() {
    return '$nombre ($dosis, $frecuencia, $duracion)';
  }
}
