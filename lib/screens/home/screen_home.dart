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

    Widget listPlaces = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
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

    Widget switchContent = places.isEmpty ? emptyPlaces : listPlaces;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: Text(
          "Saved Places",
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: switchContent,
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
    Widget trailing = SizedBox(
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.av_timer_sharp,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${place.timestamp.hour}:${place.timestamp.minute}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.date_range_sharp,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${place.timestamp.day}.${place.timestamp.month}.${place.timestamp.year}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget leading = Hero(
      tag: place.uuid,
      child: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(place.image),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color:
                Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(50),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          onTap: () {
            _routePlace(context);
          },
          title: Text(
            place.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          leading: leading,
          trailing: trailing,
        ),
      ),
    );
  }
}
