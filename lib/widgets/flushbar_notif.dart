import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlusBatNotif {
  dynamic show(String massage, BuildContext context) {
    return Flushbar(
      message: massage,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16.0),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(12),
    )..show(context);
  }
}
