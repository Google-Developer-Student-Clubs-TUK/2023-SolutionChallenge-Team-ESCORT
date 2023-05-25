import 'package:flutter/material.dart';

Widget buildBanner(double mediaQuery, String title, String description,
    {String buttonText = '', Function()? onClick}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF0D082C),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              Text(
                description,
                style: TextStyle(
                  color: Color(0xFF0D082C),
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: mediaQuery * 0.3),
        FilledButton(
          onPressed: onClick,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF10403B)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Join now',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}
