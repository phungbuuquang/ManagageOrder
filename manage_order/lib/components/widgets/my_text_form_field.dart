import 'package:flutter/material.dart';
import '../../styles/theme.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final bool isSecure;
  MyTextFormField({this.hintText, this.isSecure = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextTheme.getTextTheme.bodyText1,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isSecure,
    );
  }
}
