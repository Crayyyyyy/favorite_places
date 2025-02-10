import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';

class ScreenPlace extends StatelessWidget {
  const ScreenPlace({super.key, required this.place});
  final Place place;

  String? get locationImage {
    final lat = place.location.lat;
    final lng = place.location.lng;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=18&size=600x600&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDu8_Us5JNgx7xm6-G4GfY_emMCW6ousPQ';
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      place.title,
      style: Theme.of(context).textTheme.titleMedium,
    );

    Widget background = Hero(
      tag: place.uuid,
      child: SizedBox(
        height: double.infinity,
        child: Image.file(
          place.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );

    Widget fade = Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withAlpha(255),
              Colors.black.withAlpha(0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );

    Widget bubbleLocation = Column(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: NetworkImage(locationImage!),
        ),
        const SizedBox(height: 20),
        Text(
          place.location.address,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 70),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Stack(
        children: [
          background,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                fade,
                bubbleLocation,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
