import 'dart:ffi';
import 'dart:io';

import 'package:favorite_places/objects/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)");
    },
    version: 1,
  );
  return db;
}

class NotifierPlaces extends StateNotifier<List<Place>> {
  NotifierPlaces() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query("user_places");
    final places = data
        .map(
          (row) => Place.withUUID(
            uuid: row["id"] as String,
            title: row["title"] as String,
            image: File(row["image"] as String),
            location: PlaceLocation(
              address: row["address"] as String,
              lat: row["lat"] as double,
              lng: row["lng"] as double,
            ),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);

    final copiedImage = await place.image.copy('${appDir.path}/$filename');
    place.image = copiedImage;

    final db = await _getDatabase();

    db.insert("user_places", {
      "id": place.uuid,
      "title": place.title,
      "image": place.image.path,
      "lat": place.location.lat,
      "lng": place.location.lng,
      "address": place.location.address,
    });

    state = [...state, place];
  }
}

final providePlaces = StateNotifierProvider<NotifierPlaces, List<Place>>(
  (ref) => NotifierPlaces(),
);
