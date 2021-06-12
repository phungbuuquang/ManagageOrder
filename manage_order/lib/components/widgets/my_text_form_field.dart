import 'package:flutter/material.dart';
import '../../styles/theme.dart';

class MyTextFormField extends StatefulWidget {
  final String? hintText;
  final bool isSecure;
  final Key? fieldKey;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final String? labelText;
  final ValueChanged<String>? onFieldSubmitted;
  final double height;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? initialValue;

  MyTextFormField({
    this.hintText,
    this.isSecure = false,
    this.validator,
    this.fieldKey,
    this.onTap,
    this.onChange,
    this.labelText,
    this.onFieldSubmitted,
    this.height = 80,
    this.keyboardType,
    this.controller,
    this.initialValue,
  });

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        key: widget.fieldKey,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        maxLines: 1,
        minLines: null,
        initialValue: widget.initialValue,
        controller: widget.controller,
        style: AppTextTheme.getTextTheme.bodyText1,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: AppTextTheme.getTextTheme.headline1,
          hintStyle: AppTextTheme.getTextTheme.headline1,
          contentPadding: const EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.isSecure,
        onChanged: (val) {
          if (widget.onChange != null) {
            widget.onChange!(val);
          }
        },
        validator: widget.validator,
      ),
    );
  }
}
