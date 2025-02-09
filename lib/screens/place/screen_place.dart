import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';

class ScreenPlace extends StatelessWidget {
  const ScreenPlace({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: place.uuid,
            child: SizedBox(
              height: 300,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
