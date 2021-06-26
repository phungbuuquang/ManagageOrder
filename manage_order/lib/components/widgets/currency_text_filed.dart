import 'package:flutter/material.dart';
import '../../styles/theme.dart';
import '../../utils/utils.dart';

class CurrencyTextField extends StatefulWidget {
  final String? hintText;
  final bool isSecure;
  final Key? fieldKey;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final String? labelText;
  final ValueChanged<String>? onFieldSubmitted;
  final double height;
  final int? initialValue;

  CurrencyTextField({
    this.hintText,
    this.isSecure = false,
    this.validator,
    this.fieldKey,
    this.onTap,
    this.onChange,
    this.labelText,
    this.onFieldSubmitted,
    this.height = 80,
    this.initialValue,
  });

  @override
  _CurrencyTextFieldState createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = Utils.formatCurrency(widget.initialValue ?? 0);
  }

  String value = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        key: widget.fieldKey,
        onTap: widget.onTap,
        keyboardType: TextInputType.number,
        maxLines: 1,
        minLines: null,
        controller: _controller,
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
          value = val.replaceAll('.', '');
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
          final num = int.parse(value);
          final str = Utils.formatCurrency(num);
          _controller.value = TextEditingValue(
            text: str,
            selection: TextSelection.collapsed(offset: str.length),
          );
        },
        validator: widget.validator,
      ),
    );
  }
}
