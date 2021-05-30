import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef FuncShowMessageSuccess = void Function(String msg, String subTitle);

mixin WidgetBase<T extends Widget> {
  Widget get loadingWidget => const Center(child: CupertinoActivityIndicator());

  Widget get errorWidget => const Center(
          child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 48,
      ));
  // FuncShowMessageSuccess get showMessageSuccess =>
  //     ToastUtils.showMessageSuccess;

  // void showMessageError(String msg) {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     ToastUtils.showMessageError(msg, ' ');
  //   });
  // }

  Widget titleBase(
    BuildContext context, {
    required String title,
    Color? color,
    EdgeInsets? padding,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 8, top: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: color ?? Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget colorFilter(Widget child, bool gray) {
    const greyscale = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);

    return gray
        ? ColorFiltered(
            colorFilter: greyscale,
            child: child,
          )
        : child;
  }
}
