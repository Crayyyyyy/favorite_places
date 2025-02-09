import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

class Place {
  Place({required this.title, this.description}) : uuid = _uuid.v4();

  String title;
  String uuid;
  String? description;
  // ImageMemmory image
}
