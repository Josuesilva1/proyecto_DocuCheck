class Documento {
  final String texto;
  final DateTime fecha;

  Documento({required this.texto, required this.fecha});
}

//se hace una lista global para poder crear objetos del tipo Objeto en otras paginas archivos
List<Documento> documentos = [];
