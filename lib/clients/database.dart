import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutterweatherapplication/models/models.dart' as model;

class DatabaseClient {
  DatabaseClient._();
  static final DatabaseClient db = DatabaseClient._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'forecast_database.db');
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Forecast("
          "city TEXT,"
          "country TEXT,"
          "sunrise INTEGER,"
          "sunset INTEGER"
          ")");
      await db.execute("CREATE TABLE Weather("
          "temperature INTEGER,"
          "feels_like INTEGER,"
          "pressure INTEGER,"
          "humidity INTEGER,"
          "overcast INTEGER,"
          "precipitation REAL,"
          "formatted_condition TEXT,"
          "wind_speed REAL,"
          "wind_degree REAL,"
          "weather_at INTEGER"
          ")");
        }
    );
  }

  newForecast(model.Forecast forecast) async {
    final db = await database;
    await db.rawDelete("DELETE FROM Forecast");
    await db.rawDelete("DELETE FROM Weather");
    await db.insert("Forecast", forecast.toDatabase());
    await db.insert("Weather", forecast.forecast[0].toDatabase());
    forecast.forecast.forEach((item) async {
      await db.insert("Weather", item.toDatabase());
    });
  }

  Future<model.Forecast> getForecast() async {
    final db = await database;
    final forecast = await db.query("Forecast");
    if (forecast.isEmpty) {
      throw Exception('Local storage is empty');
    }
    final weather = await db.rawQuery("SELECT * FROM Weather WHERE weather_at>?",
        [(DateTime.now().subtract(Duration(hours: 3)).millisecondsSinceEpoch)~/1000]
    );
    return model.Forecast.fromDatabase(
        forecast[0],
        weather.map((x) => model.Weather.fromDatabase(x)).toList()
    );
  }

}