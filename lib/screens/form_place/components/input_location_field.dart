import 'dart:convert';

import 'package:favorite_places/components/input_container.dart';
import 'package:favorite_places/objects/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  String? key;

  String? get locationImage {
    if (location == null) return null;

    final lat = location!.lat;
    final lng = location!.lng;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x500&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$key';
  }

  @override
  void initState() {
    super.initState();
    loadApiKey();
  }

  void loadApiKey() async {
    String? apiKey;
    try {
      await dotenv.load(fileName: ".env");
      apiKey = dotenv.env['API_KEY'] ?? '';
    } catch (e) {
      debugPrint(
          "You need to create .env variable in root of this project with API_KEY in order to use Google Maps API.");
    }
    key = apiKey;
    // debugPrint('API Key: $apiKey');
  }

  void showSnackBarMessage(String message, Icon icon) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          spacing: 10,
          children: [
            icon,
            Text(message),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    Location locationTemp = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // <Handle location service availability>
    serviceEnabled = await locationTemp.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationTemp.requestService();
      if (!serviceEnabled) {
        showSnackBarMessage("No location service found",
            Icon(Icons.signal_cellular_connected_no_internet_4_bar_sharp));
        return;
      }
    }
    // </Handle location service availability>

    // <Handle location permissions>
    permissionGranted = await locationTemp.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationTemp.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        showSnackBarMessage(
            "Missing location permissions", Icon(Icons.no_accounts_sharp));
        return;
      }
    }
    // </Handle location permissions>

    // Toggle loading icon on LocationInputField
    setState(() {
      isLoading = true;
    });

    try {
      // Request device location data (Latitude, Longitude)
      final locationData = await locationTemp.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      // Handle scenario where location data were not obtained
      if (lat == null || lng == null) {
        showSnackBarMessage("Unable to obtain device location",
            Icon(Icons.error_outline_sharp));
        return;
      }

      // <Request location data from Google Maps>
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${key}');

      final response = await http.get(url);
      final jsonResponse = json.decode(response.body);
      // </Request location data from Google Maps>

      // Update state with location data
      setState(() {
        location = PlaceLocation(
          address: jsonResponse["results"][0]["formatted_address"],
          lat: lat,
          lng: lng,
        );
      });
    } catch (e) {
      print(e);
      location = null;
      showSnackBarMessage(
          "Something went wrong", Icon(Icons.error_outline_sharp));
    } finally {
      setState(() {
        if (location != null) {
          widget.onSelectLocation(location!);
        } else {
          location = null;
          showSnackBarMessage(
              "Something went wrong", Icon(Icons.error_outline_sharp));
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonCurrentLocation = ButtonLocation(
      title: "Current location",
      iconData: Icons.location_searching_sharp,
      onTap: _getCurrentLocation,
    );
    Widget buttonChooseLocation = ButtonLocation(
      title: "Use map",
      iconData: Icons.map_sharp,
      onTap: () {},
    );
    Widget inputFilled = InputContainer(
      widget: locationImage == null
          ? SizedBox.shrink()
          : Image.network(
              locationImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );
    Widget inputBlank = InputContainer(
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
            ? inputBlank
            : inputFilled;

    return Column(
      children: [
        switchContent,
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonCurrentLocation,
            buttonChooseLocation,
          ],
        ),
      ],
    );
  }
}

class ButtonLocation extends StatelessWidget {
  const ButtonLocation(
      {super.key,
      required this.title,
      required this.iconData,
      required this.onTap});

  final IconData iconData;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Row(
        spacing: 5,
        children: [
          Icon(
            iconData,
          ),
          Text(title),
        ],
      ),
    );
  }
}
