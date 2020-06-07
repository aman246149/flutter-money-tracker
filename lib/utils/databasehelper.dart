
import 'dart:async';
import 'dart:io';

import 'package:moneysaving/model/Money.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper
{
  DatabaseHelper._createInstace();

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String moneytable='money';
  String colID='id';
  String colTitle='title';
  String colAmouunt='amount';
  String colMoney='monthlymoney';



  factory DatabaseHelper()
  {
    if(_databaseHelper==null)
      {
        _databaseHelper=DatabaseHelper._createInstace();
      }
    return  _databaseHelper;
  }

  Future<Database>  get database async
  {
    if(_database==null)
      {
        _database=await initializeDatabase();

      }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return notesDatabase;
  }

  void _createDatabase(Database db,int version) async
  {
    await db.execute('CREATE TABLE $moneytable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colAmouunt TEXT, $colMoney  TEXT)');
  }

  Future<int> insertNote(Money note) async {
    Database db = await this.database;
    var result = await db.insert(moneytable, note.toMap());
    return result;
  }

  Future<int> deleteNote(int id) async
  {
    Database db=await this.database;
  return  await db.rawDelete('DELETE FROM $moneytable where $colID=$id');
  }




  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(moneytable);
    return result;
  }

  Future<List<Money>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Money> noteList = List<Money>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Money.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}
