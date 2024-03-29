import 'package:escort/supports/languages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:escort/scenarios/main/home/onboarding_page.dart';
import 'package:escort/scenarios/intro/sign_out/signup.dart';

import '../intro/sign_in/signIn.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase/firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    name: 'escort',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

// use the returned token to send messages to users from your custom server

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(GetMaterialApp(
    home: MyApp(),
    translations: Languages(),
    locale: Get.deviceLocale,
    fallbackLocale: Locale('en', 'US'),
  ));
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
      theme: ThemeData(fontFamily: 'Urbanist'),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                Page1(
                  "Welcome To Escort!".tr,
                  "Our new platform came to ease you accompanies the elderly with dementia.".tr,
                  "assets/onboarding1.png",
                ),
                Page1(
                  "Wherever You Are".tr,
                  "Our app prevents the disappearance of elderly people with dementia.".tr,
                  "assets/onboarding2.png",
                ),
                Page1(
                  "Sign Up For Escort".tr,
                  "You can also participate and help the elderly with dimentia.".tr,
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
                        child: Text(
                          "Get Started".tr,
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
                        child: Text(
                          "I Already Have an Account".tr,
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
