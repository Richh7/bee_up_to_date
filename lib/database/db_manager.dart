import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/apiary.dart';
import 'model/harvest.dart';
import 'model/hive.dart';
import 'model/inspection.dart';

/*
  Wrapper class for database.
 */

class DatabaseManager {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'database.db';
    final String path = await getDatabasesPath();
    return join(path, name);
  }

  Future<void> _onCreate(Database db, int version) async {
    await createApiariesTable(db);
    await createHivesTable(db);
    await createHarvestsTable(db);
    await createInspectionsTable(db);
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<Database> _initialize() async {
    final String path = await fullPath;
    var database = openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
      singleInstance: true,
    );
    return database;
  }

  Future<void> createApiariesTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS apiaries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            location TEXT NOT NULL,
            description TEXT NOT NULL ON CONFLICT REPLACE DEFAULT ""
          )
        ''');
  }

  Future<void> createHivesTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS hives(
            id INTEGER PRIMARY KEY, 
            framesNumber INTEGER NOT NULL,
            queenColor TEXT NOT NULL,
            qrCode TEXT NOT NULL,
            comments TEXT NOT NULL ON CONFLICT REPLACE DEFAULT "",
            apiaryId INTEGER NOT NULL,
            FOREIGN KEY(apiaryId) REFERENCES apiaries(id) ON DELETE CASCADE
          )
        ''');
  }

  Future<void> createHarvestsTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS harvests(
            id INTEGER PRIMARY KEY,
            date TEXT NOT NULL,
            honeyType TEXT NOT NULL,
            weight REAL NOT NULL,
            waterPercentage REAL NOT NULL ON CONFLICT REPLACE DEFAULT 0.0,
            comments TEXT NOT NULL ON CONFLICT REPLACE DEFAULT "",
            apiaryId INTEGER NOT NULL,
            FOREIGN KEY(apiaryId) REFERENCES apiaries(id) ON DELETE CASCADE
          )
        ''');
  }

  Future<void> createInspectionsTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS inspections(
            id INTEGER PRIMARY KEY,
            date TEXT NOT NULL,
            queenSeen INTEGER NOT NULL CHECK (queenSeen IN (0, 1)),
            eggsSeen INTEGER NOT NULL CHECK (eggsSeen IN (0, 1)),
            cellsSeen INTEGER NOT NULL CHECK (cellsSeen IN (0, 1)),
            strength TEXT NOT NULL,
            comments TEXT NOT NULL ON CONFLICT REPLACE DEFAULT "",
            hiveId INTEGER NOT NULL,
            FOREIGN KEY(hiveId) REFERENCES hives(id) ON DELETE CASCADE
          )
        ''');
  }

//-------------------------------CREATE----------------------------------------

  Future<void> createApiary(Apiary apiary) async {
    final db = await DatabaseManager().database;
    await db.insert('apiaries', apiary.toMap());
  }

  Future<void> createHive(Hive hive) async {
    final db = await DatabaseManager().database;
    await db.insert('hives', hive.toMap());
  }

  Future<void> createHarvest(Harvest harvest) async {
    final db = await DatabaseManager().database;
    await db.insert('harvests', harvest.toMap());
  }

  Future<void> createInspection(Inspection inspection) async {
    final db = await DatabaseManager().database;
    await db.insert('inspections', inspection.toMap());
  }

//--------------------------------READ-----------------------------------------

  Future<List<Apiary>> readApiaries() async {
    final db = await DatabaseManager().database;
    final List<Map<String, dynamic>> apiaries = await db.query('apiaries');
    return apiaries.map((apiary) => Apiary.fromMap(apiary)).toList();
  }

  Future<List<Hive>> readHives() async {
    final db = await DatabaseManager().database;
    final List<Map<String, dynamic>> hives = await db.query('hives');
    return hives.map((hive) => Hive.fromMap(hive)).toList();
  }

  Future<List<Harvest>> readHarvests() async {
    final db = await DatabaseManager().database;
    final List<Map<String, dynamic>> harvests = await db.query('harvests');
    return harvests.map((harvest) => Harvest.fromMap(harvest)).toList();
  }

  Future<List<Inspection>> readInspections() async {
    final db = await DatabaseManager().database;
    final List<Map<String, dynamic>> inspections =
        await db.query('inspections');
    return inspections
        .map((inspection) => Inspection.fromMap(inspection))
        .toList();
  }

//-------------------------------UPDATE----------------------------------------

  Future<void> updateApiary(Apiary apiary) async {
    final db = await DatabaseManager().database;
    await db.update(
      'apiaries',
      apiary.toMap(),
      where: 'id = ?',
      whereArgs: [apiary.id],
    );
  }

  Future<void> updateHive(Hive hive) async {
    final db = await DatabaseManager().database;
    await db.update(
      'hives',
      hive.toMap(),
      where: 'id = ?',
      whereArgs: [hive.id],
    );
  }

  Future<void> updateHarvest(Harvest harvest) async {
    final db = await DatabaseManager().database;
    await db.update(
      'harvests',
      harvest.toMap(),
      where: 'id = ?',
      whereArgs: [harvest.id],
    );
  }

  Future<void> updateInspection(Inspection inspection) async {
    final db = await DatabaseManager().database;
    await db.update(
      'inspections',
      inspection.toMap(),
      where: 'id = ?',
      whereArgs: [inspection.id],
    );
  }

//-------------------------------DELETE----------------------------------------

  Future<void> deleteApiary(int apiaryId) async {
    final db = await DatabaseManager().database;
    await db.delete('apiaries', where: 'id = ?', whereArgs: [apiaryId]);
  }

  Future<void> deleteHive(int hiveId) async {
    final db = await DatabaseManager().database;
    await db.delete('hives', where: 'id = ?', whereArgs: [hiveId]);
  }

  Future<void> deleteHarvest(int hervestId) async {
    final db = await DatabaseManager().database;
    await db.delete('harvests', where: 'id = ?', whereArgs: [hervestId]);
  }

  Future<void> deleteInspection(int inspectionId) async {
    final db = await DatabaseManager().database;
    await db.delete('inspections', where: 'id = ?', whereArgs: [inspectionId]);
  }
}
