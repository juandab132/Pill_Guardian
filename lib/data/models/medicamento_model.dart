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

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'duracion': duracion,
    };
  }
}
