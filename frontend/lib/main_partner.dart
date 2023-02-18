import 'package:flutter/material.dart';

class MainPartner extends StatelessWidget {
  const MainPartner({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 220,
                height: 20,
                child: Text(
                  "Escort",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset("assets/logo.png")
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          titleSpacing: 20,
          leadingWidth: 20,
          centerTitle: false,
          leading: Transform.translate(
            offset: Offset(10, 0),
            child: Image.asset("assets/logo.png"),
          ),
        ),
      ),
    );
  }
}
