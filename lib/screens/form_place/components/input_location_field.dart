import 'dart:convert';
import 'dart:io';

import 'package:favorite_places/components/input_container.dart';
import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class InputLocationField extends StatefulWidget {
  const InputLocationField({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<InputLocationField> createState() => _InputLocationFieldState();
}

class _InputLocationFieldState extends State<InputLocationField> {
  PlaceLocation? location;
  bool isLoading = false;

  String? get locationImage {
    if (location == null) return null;

    final lat = location!.lat;
    final lng = location!.lng;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x500&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyA_sws5s18dqon0YYxpCJ7k4-xXmwbe4zI';
  }

  void _getCurrentLocation() async {
    print("Executed");
    Location locationTemp = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationTemp.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationTemp.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await locationTemp.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationTemp.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isLoading = true;
    });
    try {
      final locationData = await locationTemp.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) return;

      final key = "AIzaSyA_sws5s18dqon0YYxpCJ7k4-xXmwbe4zI";

      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${key}');

      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);

      setState(() {
        location = PlaceLocation(
          address: jsonResponse["results"][0]["formatted_address"],
          lat: lat,
          lng: lng,
        );
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        if (location != null) {
          widget.onSelectLocation(location!);
        }
        isLoading = false;
      });
    }

    // print(jsonResponse["results"][0]["formatted_address"]);
    // print(locationData.latitude);
    // print(locationData.altitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget preview = InputContainer(
      widget: locationImage == null
          ? SizedBox.shrink()
          : Image.network(
              locationImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );

    Widget inputPlaceholder = InputContainer(
      widget: TextButton.icon(
        style: ButtonStyle(),
        onPressed: () {},
        label: Text("Choose location on Map"),
        icon: Icon(Icons.maps_home_work_sharp),
      ),
    );

    Widget containerLoading = InputContainer(
      widget: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Widget switchContent = isLoading
        ? containerLoading
        : locationImage == null
            ? inputPlaceholder
            : preview;

    return Column(
      children: [
        switchContent,
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_searching_sharp,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Current location"),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.map_sharp,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("Use Map"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
