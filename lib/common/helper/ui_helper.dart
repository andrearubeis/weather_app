import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/common/style/app_theme.dart';

class UIHelper {

  static showFlushBar(BuildContext context,
      {@required message,
      Color backgroundColor,
      EdgeInsets padding,
      Function(Flushbar flushbar) onTap,
      bool isDismissible = true,
      FlushbarStyle flushBarStyle,
      FlushbarPosition flushBarPosition,
      Duration duration}) {
     Flushbar(
      padding: padding ?? const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
      onTap: onTap != null ? (flushBar) => onTap(flushBar) : null,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor ?? WeatherAppTheme.primaryNttAccent(context),
      duration: duration ?? Duration(seconds: 3),
      messageText: Text(
        message ?? "",
        style: TextStyle(
            color: WeatherAppTheme.primaryText(context),
        )
      ),
      animationDuration: Duration(milliseconds: 500),
      flushbarStyle: flushBarStyle ?? FlushbarStyle.GROUNDED,
      flushbarPosition: flushBarPosition ?? FlushbarPosition.TOP,
    )..show(context);
  }


}
