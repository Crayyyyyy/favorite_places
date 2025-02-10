import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(100),
        ),
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      width: double.infinity,
      height: 250,
      child: widget,
    );
  }
}
