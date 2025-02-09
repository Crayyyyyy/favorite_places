import 'package:favorite_places/screens/form_place/screen_form_place.dart';
import 'package:favorite_places/screens/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorSeed = ColorScheme.fromSeed(seedColor: Color(0xFFFF7043));

void main() {
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
      theme: ThemeData().copyWith(
        colorScheme: kColorSeed,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorSeed.primary,
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 22,
            color: kColorSeed.onPrimary,
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            color: kColorSeed.onSurface,
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: kColorSeed.onSurface,
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: kColorSeed.surface,
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        scaffoldBackgroundColor: kColorSeed.surface,
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(kColorSeed.onPrimary)),
        ),
        iconTheme: IconThemeData(
          color: kColorSeed.onSurface,
          size: 48,
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const ScreenHome(),
        '/formNewPlace': (context) => ScreenFormPlace(),
      },
    );
  }
}
