import 'dart:io';

import 'package:favorite_places/components/input_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImageField extends StatefulWidget {
  const InputImageField({super.key, required this.onPickImage});

  final Function(File pickedImage) onPickImage;

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

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget inputBlank = InputContainer(
      widget: TextButton.icon(
        onPressed: _selectImage,
        icon: Icon(Icons.camera),
        label: Text("Upload picture"),
      ),
    );
    Widget inputFilled = _selectedImage == null
        ? SizedBox.shrink()
        : GestureDetector(
            onTap: _selectImage,
            child: InputContainer(
              widget: Stack(
                children: [
                  Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(100),
                    child: Center(
                        child: Text(
                      "Tap to take image again",
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
                  )
                ],
              ),
            ),
          );
    Widget switchContent = _selectedImage == null ? inputBlank : inputFilled;

    return switchContent;
  }
}
