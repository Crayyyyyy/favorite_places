import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImageField extends StatefulWidget {
  const InputImageField({super.key});

  @override
  State<InputImageField> createState() => _InputImageFieldState();
}

class _InputImageFieldState extends State<InputImageField> {
  File? _selectedImage;

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 250,
      child: TextButton.icon(
        onPressed: _selectImage,
        icon: Icon(Icons.camera),
        label: Text("Upload picture"),
      ),
    );
  }
}
