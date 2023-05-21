import 'package:flutter/material.dart';

Widget buildTitleScreen(double mediaQuery, Function() onScrollToFeature) {
  final primaryColor = Color(0xFF10403B);

  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Color(0x0A347E5B), Color(0x0AF2F2F2)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            mediaQuery * 0.104,
            80,
            mediaQuery * 0.104,
            180,
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Image(
                    width: 36,
                    height: 36,
                    image: AssetImage('assets/web_logo.png'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Escort',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   width: 113,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text('Home', style: TextStyle(color: Color(0xFF212121), fontSize: 16, fontWeight: FontWeight.w600),),
                  // ),
                  // SizedBox(
                  //   width: 50,
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text('Submit'),
                  // ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up for the app\nhelp seniors with dementia!',
                          style: TextStyle(
                              fontSize: 56, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Escort allows people who have family members with dementia or who want to help seniors with dementia to sign up as companions on the app, creating a global network of people andits own hotline.',
                          style: TextStyle(fontSize: 18, height: 1.6),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 30),
                        FilledButton(
                          onPressed: onScrollToFeature,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 25,
                              ),
                            ),
                          ),
                          child: Text(
                            'Discover features',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 520),
                  SizedBox(
                    width: mediaQuery * 0.178,
                    child: Image(
                      image: AssetImage('assets/iphone14_splash.png'),
                    ),
                  ),
                  SizedBox(width: 100),
                ],
              ),
            ],
          ),
        ),
      )
    ],
  );
}
