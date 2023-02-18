import 'package:escort/main_dementia.dart';
import 'package:escort/onboarding_page.dart';
import 'package:escort/signup.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'SignIn.dart';

void main() {
  runApp(const MaterialApp(home: MainDementia()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController _controller = PageController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              children: const [
                Page1(
                  "Welcome To Escort! ",
                  "Our new platform came to ease you accompanies the elderly with dementia.",
                  "assets/onboarding1.png",
                ),
                Page1(
                  "Wherever You Are",
                  "Our app prevents the disappearance of elderly people with dementia.",
                  "assets/onboarding2.png",
                ),
                Page1(
                  "Sign Up For Escort",
                  "You can also participate and help the elderly with dimentia.",
                  "assets/onboarding3.png",
                ),
              ],
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          spacing: 8.0,
                          radius: 10,
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          strokeWidth: 3,
                          dotColor: Colors.grey,
                          activeDotColor: Color.fromRGBO(16, 64, 59, 10)),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 340,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color.fromRGBO(16, 64, 59, 10),
                          fixedSize: const Size(250.0, 40.0),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 340,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color.fromRGBO(232, 233, 235, 10),
                          fixedSize: const Size(250.0, 40.0),
                        ),
                        child: const Text(
                          "I Aleady Have an Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
