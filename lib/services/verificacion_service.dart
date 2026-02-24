import '../db/databaseHelper.dart';
import '../models/verificacion_model.dart';

class VerificacionService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertarVerificacion(VerificacionModel verificacion) async {
    final db = await dbHelper.database;
    return await db.insert('validaciones', verificacion.toMap());
  }

  Future<List<VerificacionModel>> obtenerVerificaciones() async {
    final db = await dbHelper.database;
    final result = await db.query('validaciones', orderBy: 'fecha DESC');

    return result.map((map) => VerificacionModel.fromMap(map)).toList();
  }

  Future<List<VerificacionModel>> obtenerVerificacionesDelDia() async {
    final db = await dbHelper.database;

    // Inicio del día
    final now = DateTime.now();
    final inicioDia = DateTime(now.year, now.month, now.day);
    final finDia = inicioDia.add(const Duration(days: 1));

    final result = await db.query(
      'validaciones',
      where: 'fecha >= ? AND fecha < ?',
      whereArgs: [inicioDia.toIso8601String(), finDia.toIso8601String()],
      orderBy: 'fecha DESC',
    );

    return result.map((map) => VerificacionModel.fromMap(map)).toList();
  }

  Future<int> eliminarVerificacion(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'validaciones',
      where: 'id_validacion = ?',
      whereArgs: [id],
    );
  }
}
