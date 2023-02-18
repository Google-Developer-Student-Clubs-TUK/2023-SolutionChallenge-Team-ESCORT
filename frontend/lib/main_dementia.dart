import 'package:flutter/material.dart';

class MainDementia extends StatelessWidget {
  const MainDementia({super.key});
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
              Padding(
                padding: const EdgeInsets.only(left: 47.0),
                child: IconButton(
                    onPressed: () => {}, icon: Icon(Icons.notifications)),
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          titleSpacing: 20,
          leadingWidth: 20,
          centerTitle: false,
          leading: Transform.translate(
            offset: Offset(10, 0),
            child: Image.asset("assets/logo.png"),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 12, left: 12.0, right: 12.0, bottom: 5),
          child: Column(
            children: [
              Container(
                height: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color.fromRGBO(32, 92, 73, 89),
                ),
                child: Column(
                  children: const [
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: SizedBox(
                          width: 375,
                          height: 190,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50, // Image radius
                            backgroundImage: NetworkImage('imageUrl'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Jenny Kim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "010 2170 9514",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, right: 160, bottom: 30),
                                child: Text(
                                  'Characteristics',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color.fromRGBO(16, 64, 59, 100),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "● A mole under the nose",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                              Text(
                                "● Big ears and smalls lips",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                              Text(
                                "● Reacting to the name 'Frank",
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 64, 59, 100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        child: const Center(
                            child: Text(
                          'Item 2',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.black12,
                        ),
                        child: const Center(
                            child: Text(
                          'Item 3',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.black12),
                        child: const Center(
                            child: Text(
                          'Item 4',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.black12),
                  child: Column(
                    children: const [
                      SizedBox(
                        child: SizedBox(
                          width: 375,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50, // Image radius
                              backgroundImage: NetworkImage('imageUrl'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: Colors.black12),
                width: 350,
                height: 32,
                child: Text("asdasdasd",
                    style: TextStyle(
                      color: Color.fromRGBO(16, 64, 59, 100),
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SizedBox(
                child: Image.asset(
                  "assets/floatbutton.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
