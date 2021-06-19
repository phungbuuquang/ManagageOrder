import 'package:flutter/material.dart';

class MyRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final Function(T?)? onChanged;
  final String? title;
  MyRadioButton({
    this.groupValue,
    this.title,
    required this.value,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          canvasColor: Colors.grey[50],
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      child: Container(
        height: 40,
        child: RadioListTile<T>(
          title: Text(title ?? ''),
          value: value,
          groupValue: groupValue,
          onChanged: (T? value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ),
    );
  }
}
