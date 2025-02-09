import 'package:favorite_places/objects/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotifierPlaces extends StateNotifier<List<Place>> {
  NotifierPlaces()
      : super([
          Place(title: "One place"),
          Place(title: "Two place"),
          Place(title: "Three place"),
          Place(title: "Four place"),
          Place(title: "Five place"),
        ]);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final providePlaces = StateNotifierProvider<NotifierPlaces, List<Place>>(
  (ref) => NotifierPlaces(),
);
