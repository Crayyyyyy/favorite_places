import 'package:favorite_places/objects/place.dart';
import 'package:favorite_places/screens/place/screen_place.dart';
import 'package:flutter/material.dart';

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
    Widget subtitle = Text(
      place.location.address,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withValues(alpha: 0.55),
          ),
    );
    Widget title = Text(
      place.title,
      style: Theme.of(context).textTheme.titleSmall,
    );

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(50),
          width: 1,
        ),
      ),
      contentPadding: EdgeInsets.all(10),
      tileColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () {
        _routePlace(context);
      },
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
    );
  }
}
