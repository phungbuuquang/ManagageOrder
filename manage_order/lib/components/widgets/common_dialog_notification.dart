import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage_order/components/widgets/my_button.dart';
import 'package:manage_order/styles/theme.dart';

class NotificationDialog extends StatelessWidget {
  NotificationDialog(
      {Key? key,
      required this.iconImages,
      required this.title,
      required this.message,
      required this.possitiveButtonName,
      this.negativeButtonName,
      required this.possitiveButtonOnClick,
      this.nagativeButtonOnCLick,
      this.body})
      : super(key: key);
  final Widget iconImages;
  final String title;
  final String message;
  final String possitiveButtonName;
  final String? negativeButtonName;
  final Function() possitiveButtonOnClick;
  final Function()? nagativeButtonOnCLick;
  final Widget? body;

  Function()? get onNagativeButtonClick =>
      nagativeButtonOnCLick != null ? nagativeButtonOnCLick : null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Center(
          child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 8,
        children: [
          iconImages,
          Text(
            title,
            style: AppTextTheme.getTextTheme.bodyText1,
          )
        ],
      )),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          message.isEmpty == true
              ? const SizedBox.shrink()
              : Text(
                  message,
                  style: AppTextTheme.getTextTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
          body != null ? Container(child: body) : const SizedBox.shrink(),
          const SizedBox(height: 16),
          ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 44,
                minWidth: double.infinity,
              ),
              child: Column(
                children: <Widget>[
                  MyButton(
                    title: possitiveButtonName,
                    // ignore: unnecessary_lambdas
                    onPressed: () {
                      possitiveButtonOnClick();
                    },
                  ),
                  negativeButtonName != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: onNagativeButtonClick,
                            child: Text(
                              negativeButtonName ?? '',
                              style: AppTextTheme.getTextTheme.bodyText1,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ))
        ],
      ),
    );
  }
}
