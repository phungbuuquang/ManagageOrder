import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      activeColor: Theme.of(context).primaryColor,
      value: false,
      onChanged: (value) {},
    );
  }
}
