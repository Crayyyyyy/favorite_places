import 'package:flutter/material.dart';

class InputLocationField extends StatefulWidget {
  const InputLocationField({super.key});

  @override
  State<InputLocationField> createState() => _InputLocationFieldState();
}

class _InputLocationFieldState extends State<InputLocationField> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        label: Text("Set current location"),
        icon: Icon(Icons.maps_home_work_sharp),
      ),
    );
  }
}
