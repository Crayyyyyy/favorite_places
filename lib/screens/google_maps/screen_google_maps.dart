import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';

class ScreenGoogleMaps extends StatefulWidget {
  ScreenGoogleMaps({
    super.key,
    this.location = PlaceLocation(lat: 37.422, lng: -122.084, address: ""),
  });

  final PlaceLocation location;

  @override
  State<ScreenGoogleMaps> createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
