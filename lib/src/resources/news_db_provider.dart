import 'package:sqflite/sqflite.dart' as sqf;
import 'package:path_provider/path_provider.dart' as pathp;
import 'package:path/path.dart' as path;
import 'dart:io' as io;
import 'dart:async';
import '../models/item_model.dart' as im;

class NewsDbProvider {
  sqf.Database db;

  init() async {
    io.Directory documentsDirectory =
        await pathp.getApplicationDocumentsDirectory();
    final String pathDirectory = path.join(documentsDirectory.path, 'items.db');
    this.db = await sqf.openDatabase(
      pathDirectory,
      version: 1,
      onCreate: (sqf.Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Items (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendents INTEGER
          )
        ''');
      },
    );
  }

  Future<im.ItemModel> fetchItem(int id) async {
    final List<Map<String, dynamic>> maps = await this.db.query(
      'Items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return im.ItemModel.fromJson(maps.first);
    }

    return null;
  }

  Future<int> addItem(im.ItemModel item) async {
    return await this.db.insert('Item', item.toMapFordDb());
  }
}
