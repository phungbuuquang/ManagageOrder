import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final Function(bool?)? onChanged;
  final bool value;
  MyCheckbox({
    this.onChanged,
    required this.value,
  });
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      activeColor: Theme.of(context).primaryColor,
      value: widget.value,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
    );
  }
}
