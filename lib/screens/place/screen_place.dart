import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScreenPlace extends StatelessWidget {
  ScreenPlace({super.key, required this.place});
  final Place place;
  String? apiKey;

  Future<void> loadApiKey() async {
    String? tempKey;
    try {
      await dotenv.load(fileName: ".env");
      tempKey = dotenv.env['API_KEY'] ?? '';
    } catch (e) {
      debugPrint(
          "You need to create .env variable in root of this project with API_KEY in order to use Google Maps API.");
    }
    apiKey = tempKey;
    // debugPrint('API Key: $apiKey');
  }

  Future<String?> get locationImage async {
    final lat = place.location.lat;
    final lng = place.location.lng;

    await loadApiKey();

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=18&size=600x600&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
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
        FutureBuilder<String?>(
          future: locationImage,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircleAvatar(
                radius: 75,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const CircleAvatar(
                radius: 75,
                child: Icon(Icons.error),
              );
            } else {
              return CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(snapshot.data!),
              );
            }
          },
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
