import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenGoogleMaps extends StatefulWidget {
  const ScreenGoogleMaps({
    super.key,
    required this.place,
    this.isSelecting = true,
  });

  // lat: 50.69958099201482
  // lng: -3.0941394779051037

  final Place place;
  final bool isSelecting;

  @override
  State<ScreenGoogleMaps> createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  LatLng? _pickedLocation;

  void _routeBack(BuildContext ctx) {
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      widget.isSelecting ? "Pick location" : "Your location",
      style: Theme.of(context).textTheme.titleMedium,
    );

    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                print(_pickedLocation?.latitude);
                print(_pickedLocation?.longitude);
                _routeBack(context);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            if (widget.isSelecting) _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.place.location.lat, widget.place.location.lng),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId(widget.place.uuid),
                  position: _pickedLocation ??
                      LatLng(
                        widget.place.location.lat,
                        widget.place.location.lng,
                      ),
                ),
              },
      ),
    );
  }
}
