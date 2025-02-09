import 'dart:io';

import 'package:favorite_places/objects/place.dart';
import 'package:favorite_places/providers/provider_places.dart';
import 'package:favorite_places/screens/form_place/components/input_image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class ScreenFormPlace extends ConsumerStatefulWidget {
  ScreenFormPlace({super.key}) : heroUuid = _uuid.v4();

  final heroUuid;

  @override
  ConsumerState<ScreenFormPlace> createState() => _ScreenFormPlaceState();
}

class _ScreenFormPlaceState extends ConsumerState<ScreenFormPlace> {
  late final TextEditingController _controllerTitle;
  late File _selectedImage;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerTitle = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerTitle.dispose();
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Place temp = Place.withUUID(
        title: _controllerTitle.text,
        image: _selectedImage,
        uuid: widget.heroUuid);
    ref.watch(providePlaces.notifier).addPlace(temp);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputTitle = TextFormField(
      controller: _controllerTitle,
      maxLength: 50,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
            ),
        label: Text(
          "Title",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        hintText: "Secret beach, Amazing city view ...",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title must be entered";
        }
      },
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
              Hero(
                tag: widget.heroUuid,
                child: InputImageField(onPickImage: (image) {
                  _selectedImage = image;
                }),
              ),
              const SizedBox(height: 15),
              buttonSubmit,
            ],
          ),
        ),
      ),
    );
  }
}
