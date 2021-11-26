import 'package:flutter/material.dart';


class Alert{
static void showSnackBar(BuildContext context, String title,
      GlobalKey<ScaffoldMessengerState> _globalKey) {
    final _snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
          textColor: Colors.green,
          label: 'Dismiss',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
    );

    _globalKey.currentState!.removeCurrentSnackBar();

    _globalKey.currentState!.showSnackBar(_snackBar);
  }
}

