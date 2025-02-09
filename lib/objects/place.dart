import 'dart:io';

import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

class Place {
  Place({required this.title, this.description, required this.image})
      : uuid = _uuid.v4();

  Place.withUUID(
      {required this.title,
      this.description,
      required this.image,
      required this.uuid});

  final String title;
  final String uuid;
  final String? description;
  final File image;
  // ImageMemmory image
}
