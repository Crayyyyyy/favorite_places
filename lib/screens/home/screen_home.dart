import 'package:favorite_places/providers/provider_places.dart';
import 'package:favorite_places/screens/home/components/tile_place.dart';
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
      child: SizedBox(
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

    Widget listPlaces = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          spacing: 10,
          children: [
            for (var place in places) TilePlace(place: place),
          ],
        ),
      ),
    );

    Widget emptyPlaces = Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_neutral_rounded,
            size: 96,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
          Text(
            "List of places is empty",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(75),
                ),
          ),
          Text(
            "Add some by clicking on the '+' icon in bottom right",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(75),
                ),
          ),
        ],
      ),
    );

    Widget title = Text(
      "Saved Places",
      style: TextTheme.of(context).titleMedium,
    );

    Widget switchContent = places.isEmpty ? emptyPlaces : listPlaces;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: title,
      ),
      body: switchContent,
    );
  }
}
