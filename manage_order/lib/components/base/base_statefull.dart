import 'package:flutter/material.dart';

import 'base_widget.dart';

typedef TranslateCallback = String? Function(String? key,
    {List<dynamic>? params});
typedef TimeAgo = String Function(DateTime dateTime);

abstract class StatefulWidgetBase<T extends StatefulWidget> extends State<T>
    with WidgetBase {
  ThemeData get theme => Theme.of(context);
  Size get device => MediaQuery.of(context).size;
  EdgeInsets get padding => MediaQuery.of(context).padding;

  void hideKeyboard() => FocusScope.of(context).requestFocus(FocusNode());
  Widget get emptyWidget => const Center(child: Text('Không có dữ liệu!'));
}

extension StatefulWidgetBaseExt on StatefulWidgetBase {
  void showSnackBar(
    String title, {
    Function? onTap,
    String titleEvent = 'Ok',
  }) {
    final snackBar = SnackBar(
      content: Text('$title'),
      action: SnackBarAction(
        label: '$titleEvent',
        onPressed: () {
          onTap?.call();
        },
      ),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
