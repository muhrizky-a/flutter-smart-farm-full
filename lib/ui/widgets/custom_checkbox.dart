import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.onChanged,
  });
  final void Function(bool) onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (c) {
        setState(() {
          value = !value;
          widget.onChanged(value);
        });
      },
    );
  }
}
