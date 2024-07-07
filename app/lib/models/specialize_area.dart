import '../services/database_service.dart';

class SpecializeArea {
  final int? id;
  final String areas;

  SpecializeArea({
    this.id,
    required this.areas,
  });

  static Future<List<String>> getAreasName() async {
    final db = await BoothDB.connect();

    List<Map<String, dynamic>> result = await db.query('specialize_area');

    return List.generate(result.length, (index) {
      return result[index]['areas'];
    });
  }

  static Future<List<SpecializeArea>> getAllAreaDetails() async {
    final db = await BoothDB.connect();

    List<Map<String, dynamic>> result = await db.query('specialize_area');

    return List.generate(result.length, (index) {
      return SpecializeArea(
        areas: result[index]['areas'],
      );
    });
  }
}
