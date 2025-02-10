import 'dart:io';

import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.address,
    required this.lat,
    required this.lng,
  });

  final String address;
  final double lat;
  final double lng;
}

class Place {
  Place({
    required this.title,
    this.description,
    required this.image,
    required this.location,
  })  : uuid = _uuid.v4(),
        timestamp = DateTime.now();

  Place.withUUID(
      {required this.title,
      this.description,
      required this.image,
      required this.location,
      required this.uuid})
      : timestamp = DateTime.now();

  final String title;
  final String uuid;
  final File image;
  final DateTime timestamp;
  final PlaceLocation location;

  final String? description;
  // ImageMemmory image
}
