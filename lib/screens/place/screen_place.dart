import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';

class ScreenPlace extends StatelessWidget {
  const ScreenPlace({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
    );
  }
}
