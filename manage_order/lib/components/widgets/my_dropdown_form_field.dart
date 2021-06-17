import 'package:flutter/material.dart';

class MyDropDownFormField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?)? onChanged;
  final String? hintText;
  MyDropDownFormField({
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
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
        height: 60,
        alignment: AlignmentDirectional.centerStart,
        child: DropdownButtonFormField<T>(
          decoration: InputDecoration(
            labelText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
          ),
          iconEnabledColor: Colors.black,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          value: value,
          isExpanded: true,
          elevation: 16,
          iconSize: 40,
          items: items,
          onChanged: (val) {
            if (onChanged != null) {
              onChanged!(val);
            }
          },
        ),
      ),
    );
  }
}
