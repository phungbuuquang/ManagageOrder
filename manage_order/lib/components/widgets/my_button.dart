import 'package:flutter/material.dart';
import 'package:manage_order/styles/theme.dart';

class MyButton extends StatelessWidget {
  final double height;
  final String title;
  final bool isLoading;
  final Function()? onPressed;
  MyButton(
      {this.height = 50,
      required this.title,
      this.onPressed,
      this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                )
              : Text(
                  title,
                  style: AppTextTheme.getTextTheme.bodyText2,
                ),
        ),
      ),
    );
  }
}
