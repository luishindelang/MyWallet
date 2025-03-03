import 'package:flutter/material.dart';

void routePush(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
  );
}

void routePushAndRemove(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
    (route) => false,
  );
}

void routePop(BuildContext context) {
  Navigator.of(context).pop();
}
