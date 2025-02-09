import 'package:favorite_places/objects/place.dart';
import 'package:favorite_places/providers/provider_places.dart';
import 'package:favorite_places/screens/place/screen_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({super.key});

  void _routeToForm(BuildContext context) {
    Navigator.of(context).pushNamed("/formNewPlace");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(providePlaces);

    Widget floatingActionButton = FloatingActionButton(
      child: Container(
        width: 32,
        height: 32,
        child: Icon(
          Icons.add,
        ),
      ),
      onPressed: () {
        _routeToForm(context);
      },
    );

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: Text(
          "Home sweet home",
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var place in places) TilePlace(place: place),
          ],
        ),
      ),
    );
  }
}

class TilePlace extends StatelessWidget {
  const TilePlace({super.key, required this.place});
  final Place place;

  void _routePlace(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => ScreenPlace(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _routePlace(context);
      },
      title: Text(place.title),
    );
  }
}
