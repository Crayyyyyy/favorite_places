import 'package:favorite_places/components/theme_design.dart';
import 'package:favorite_places/screens/form_place/screen_form_place.dart';
import 'package:favorite_places/screens/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

main() {
  runApp(ProviderScope(
    child: const AppFavoritePlaces(),
  ));
}

class AppFavoritePlaces extends StatelessWidget {
  const AppFavoritePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeDesign,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const ScreenHome(),
        '/formNewPlace': (context) => ScreenFormPlace(),
      },
    );
  }
}
