import 'package:flutter/material.dart';

Widget buildPartnerCompanyScreen(double mediaQuery) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 200),
    child: Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Center(
            child: Image(
              width: mediaQuery * 0.14,
              image: AssetImage('assets/iphone14_splash.png'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, mediaQuery * 0.104, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you a social enterprise interested in Escort?',
                  style: TextStyle(
                    color: Color(
                      0xFF0D082C,
                    ),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We are looking for social enterprises to help us make supplies or services more affordable or free for older adults with dementia and their caregivers.',
                  style: TextStyle(
                    color: Color(0xFF0D082C),
                    fontSize: 20,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 40),
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFF10403B),
                    ),
                  ),
                  child: Text(
                    "Join us",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 36),
                Row(
                  children: [
                    _buildInfo(
                        'Anything is fine',
                        'It doesn\'t matter if it\'s a supplies or a service, just make it free or cheaper for those in need. Your help will make their lives better.',
                        mediaQuery),
                    SizedBox(width: 30),
                    _buildInfo(
                        'Certificated Badge',
                        'Partner companies registered with Escort will receive an official badge from Escort and will introduce on the site, in the application, and at public events.',
                        mediaQuery)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfo(String title, String description, double mediaQuery) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF0D082C),
            fontSize: 20, //mediaQuery * 0.011,
            fontWeight: FontWeight.w600,
            height: 3,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
              color: Color(0xFF0D082C),
              fontSize: 16, //mediaQuery
              height: 2.4 // * 0.0083,
              ),
        )
      ],
    ),
  );
}
