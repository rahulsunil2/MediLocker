import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../global.dart';

// database table and column names
final String tableWords = 'Profile';
final String _user = Common.currentUser;
final String _phone = 'NIL';
final String _dob = 'NIL';
final String _address = 'NIL';
final String _allergy = 'NIL';
final String _gender = Common.gender;
final String _blood_grp = Common.blood;
final String _height = 'NIL';
final String _weight = 'NIL';

// data model class
class Word {
  String user;
  String phone;
  String dob;
  String address;
  String allergy;
  String gender;
  String blood_grp;
  String height;
  String weight;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    user = map[_user];
    phone = map[_phone];
    dob = map[_dob];
    address = map[_address];
    allergy = map[_allergy];
    gender = map[_gender];
    blood_grp = map[_blood_grp];
    height = map[_height];
    weight = map[_weight];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      _user: user,
      _phone: phone,
      _dob: dob,
      _address: address,
      _allergy: allergy,
      _gender: gender,
      _blood_grp: blood_grp,
      _height: height,
      _weight: weight,
    };
    /*if (id != null) {
      map[columnId] = id;
    }*/
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                $_user TEXT NOT NULL,
                $_phone TEXT NOT NULL,
                $_dob TEXT NOT NULL,
                $_address TEXT NOT NULL,
                $_allergy TEXT NOT NULL,
                $_gender TEXT NOT NULL,
                $_blood_grp TEXT NOT NULL,
                $_height TEXT NOT NULL,
                $_weight TEXT NOT NULL,
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    return id;
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [_user, _phone, _dob,_address,_allergy,_gender,_blood_grp,_height,_weight],
        where: '$_user = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Word>> queryAllWords() async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords);
    if (maps.length > 0) {
      List<Word> words = [];
      maps.forEach((map) => words.add(Word.fromMap(map)));
      return words;
    }
    return null;
  }

  Future<int> deleteWord(int id) async {
    Database db = await database;
    return await db.delete(tableWords, where: '$_user = ?', whereArgs: [id]);
  }

  Future<int> update(Word word) async {
    Database db = await database;
    return await db.update(tableWords, word.toMap(),
        where: '$_user = ?', whereArgs: [word.user]);
  }
}
