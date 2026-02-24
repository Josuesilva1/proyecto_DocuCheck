class VerificacionModel {
  int? idValidacion;
  String texto;
  DateTime fecha;
  bool valido;

  VerificacionModel({
    this.idValidacion,
    required this.texto,
    required this.fecha,
    required this.valido,
  });

  Map<String, dynamic> toMap() {
    return {
      'textoExtraido': texto,
      'resultadoValidacion': valido ? 1 : 0,
      'fecha': fecha.toIso8601String(),      
    };
  }

  factory VerificacionModel.fromMap(Map<String, dynamic> map) {
    return VerificacionModel(
      texto: map['textoExtraido'],
      valido: map['resultadoValidacion'] == 1,
      fecha: DateTime.parse(map['fecha']),      
    );
  }
}
