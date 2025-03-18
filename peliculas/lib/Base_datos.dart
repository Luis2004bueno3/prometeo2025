import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Pelicula.dart';


class Base_datos {
  static final Base_datos instance = Base_datos._init();
  static Database? _database;

  Base_datos._init();

  Future<Database> get database async {
    if (_database != null) return _database!;


    if(kIsWeb) databaseFactory=databaseFactory;

    _database = await _initDB('peliculas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE peliculas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        anio TEXT,
        descripcion TEXT,
        categoria TEXT,
        clasi TEXT,
        puntuacion INTEGER
      )
    ''');
  }

  Future<int> insertPelicula(Pelicula pelicula) async {
    final db = await instance.database;
    final id=  db.insert('peliculas', pelicula.toMap());
    return id;
  }

  Future<List<Pelicula>> getPeliculas(String clasificacion) async {
    final db = await instance.database;
    final result = await db.query(
      'peliculas',
      where: 'clasi = ?',
      whereArgs: [clasificacion],
    );
    return result.map((json) => Pelicula.fromMap(json)).toList();
  }

  Future<void> deletePelicula(int id) async {
    final db = await instance.database;
    await db.delete('peliculas', where: 'id = ?', whereArgs: [id]);
  }


  Future<void> updatePeliculasClasificacion(int id, String nuevaClasificacion) async {
    final db = await database; // Obtener la base de datos
    await db.update(
      'peliculas', // Nombre de la tabla en la BD
      {'clasi': nuevaClasificacion}, // Campos a actualizar
      where: 'id = ?', // Condición para actualizar la película específica
      whereArgs: [id], // Parámetro para evitar SQL Injection
    );
  }

}
