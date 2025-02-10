import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart';

class InputLocationField extends StatefulWidget {
  const InputLocationField({super.key});

  @override
  State<InputLocationField> createState() => _InputLocationFieldState();
}

class _InputLocationFieldState extends State<InputLocationField> {
  late Location location;

  void _getCurrentLocation() async {
    print("Executed");
    Location locationTemp = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

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

    location = locationTemp;
    locationData = await locationTemp.getLocation();
    // final url = Uri.parse();

    print(locationData.latitude);
    print(locationData.altitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          width: double.infinity,
          height: 250,
          child: TextButton.icon(
            style: ButtonStyle(),
            onPressed: () {},
            label: Text("Choose location on Map"),
            icon: Icon(Icons.maps_home_work_sharp),
          ),
        ),
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
