import 'package:flutter/material.dart';

Container buildHeader(
  String title, {
  bool enabledBack = false,
  IconData? icon,
  GestureTapCallback? onClickBack,
  GestureTapCallback? onClickIcon,
  GestureTapCallback? onClickNotification,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          if (enabledBack)
            InkWell(
              onTap: onClickBack,
              child: Ink(
                child: Icon(Icons.arrow_back),
              ),
            )
          else if (icon != null)
            InkWell(
              onTap: onClickIcon,
              child: Ink(
                color: Color(0xFF10403B),
                child: Icon(icon),
              ),
            ),
          if (enabledBack || icon != null)
            SizedBox(
              width: 12,
            ),
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10403B)),
          ),
          Expanded(child: SizedBox()),
          if (onClickNotification != null)
            InkWell(
              onTap: onClickNotification,
              child: Ink(
                color: Color(0xFF10403B),
                child: Icon(Icons.notifications_rounded),
              ),
            ),
        ],
      ),
    ),
  );
}
