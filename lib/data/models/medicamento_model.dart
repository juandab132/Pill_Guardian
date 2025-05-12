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

  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'dosis': dosis,
    'frecuencia': frecuencia,
    'duracion': duracion,
  };

  factory MedicamentoModel.fromMap(Map<String, dynamic> map) {
    return MedicamentoModel(
      nombre: map['nombre'] ?? '',
      dosis: map['dosis'] ?? '',
      frecuencia: map['frecuencia'] ?? '',
      duracion: map['duracion'] ?? '',
    );
  }
}
