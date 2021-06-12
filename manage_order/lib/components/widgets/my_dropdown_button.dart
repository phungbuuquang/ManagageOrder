import 'package:flutter/material.dart';

class MyDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?)? onChanged;
  MyDropDownButton({required this.items, this.value, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          canvasColor: Colors.grey[50],
          primaryColor: Colors.black,
          accentColor: Colors.black,
          hintColor: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: DropdownButton<T>(
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
