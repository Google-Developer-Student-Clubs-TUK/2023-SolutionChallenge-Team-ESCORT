import 'package:escort/main_home.dart';
import 'package:escort/main_registration.dart';
import 'package:flutter/material.dart';

class MainPartner extends StatefulWidget {
  const MainPartner({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<MainPartner> createState() => _MainPartnerState();
}

class _MainPartnerState extends State<MainPartner> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    MapSample(),
    RegistrationPage(),
    RegistrationPage(),
    RegistrationPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
          ),
          body: SafeArea(
            child: _widgetOptions[_selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // item이 4개 이상일 경우 추가

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.elderly),
                label: 'Registration List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag_outlined),
                label: 'Company',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex, // 지정 인덱스로 이동
            selectedItemColor: Color.fromRGBO(16, 64, 59, 10),
            onTap: _onItemTapped, // 선언했던 onItemTapped ,
            selectedFontSize: 12,
            unselectedFontSize: 12,
          ),
        ));
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
