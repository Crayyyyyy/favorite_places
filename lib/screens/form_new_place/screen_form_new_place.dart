import 'package:favorite_places/objects/place.dart';
import 'package:favorite_places/providers/provider_places.dart';
import 'package:favorite_places/screens/form_new_place/components/input_image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenFormNewPlace extends ConsumerStatefulWidget {
  const ScreenFormNewPlace({super.key});

  @override
  ConsumerState<ScreenFormNewPlace> createState() => _ScreenFormNewPlaceState();
}

class _ScreenFormNewPlaceState extends ConsumerState<ScreenFormNewPlace> {
  late final TextEditingController _controllerTitle;
  late final TextEditingController _controllerDescription;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerTitle = TextEditingController();
    _controllerDescription = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTitle.dispose();
    _controllerDescription.dispose();
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref
        .read(providePlaces.notifier)
        .addPlace(Place(title: _controllerTitle.text));

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget inputTitle = TextFormField(
      controller: _controllerTitle,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
            ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title must be entered";
        }
      },
    );
    Widget inputDescription = TextFormField(
      controller: _controllerDescription,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
              )),
    );
    Widget inputDate = ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_month_sharp),
          const SizedBox(
            width: 10,
          ),
          Text(
            "No date",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );

    Widget buttonSubmit = ElevatedButton(
        onPressed: () {
          _submitForm(context);
        },
        child: Text("+ Add a place"));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add a Place!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              inputTitle,
              const SizedBox(height: 15),
              inputDescription,
              const SizedBox(height: 15),
              inputDate,
              const SizedBox(height: 15),
              buttonSubmit,
              const SizedBox(height: 15),
              InputImageField(),
            ],
          ),
        ),
      ),
    );
  }
}
