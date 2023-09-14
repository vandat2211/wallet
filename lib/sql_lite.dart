import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wallet/core/data.dart';

class ImageDatabase {
  Database? _database;

  Future initDatabase() async {
    if(_database==null){
      final path = join(await getDatabasesPath(), 'image_database.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, imagePath TEXT, imagePath2 TEXT)',
          );
        },
      );
    }

  }

  Future<int> insertImage(CreditCardData image) async {
    await initDatabase();
    return await _database?.insert('images', image.toMap())??0;
  }
  Future<void> deleteImage(int id ) async {
    await initDatabase();
     await _database?.delete('images',where: "id = ?", whereArgs:[id]);
  }
  Future<void> deleteMultipleImages(List<int> imageIds) async {
    await initDatabase();
    await _database?.delete(
      'images',
      where: 'id IN (${imageIds.join(', ')})',
    );
  }

  Future<List<CreditCardData>> getAllImages() async {
    await initDatabase();
    final List<Map<String, dynamic>> maps = await _database?.query('images')??[];
    return List.generate(maps.length, (i) {
      return CreditCardData(
        id: maps[i]['id'],
        name: maps[i]['name'],
        imagePath: maps[i]['imagePath']??"",
        imagePath2: maps[i]['imagePath2']??"",
      );
    });
  }
}
