import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 28),
          ),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://tistory1.daumcdn.net/tistory/2743554/attach/cb196de69425482b93b43ad7fc207bf6'))),
              width: double.infinity,
              height: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Text(
            "GwangMoo You",
            style: TextStyle(
                color: Color(0xFF808584),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              "+82 10-1234-5678",
              style: TextStyle(
                  color: Color(0xFF808584),
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 34),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                buildNavigateButton(
                  Icons.person,
                  "Personal Information",
                  () {
                    print("TODO: Personal Information");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                buildNavigateButton(
                  Icons.attach_email,
                  "Account Settings",
                  () {
                    print("TODO: Account Settings");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 26),
                  child: Divider(thickness: 1, color: Color(0xFFE8E9EB)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Participate as an Company',
                    style: TextStyle(
                        color: Color(0xFF10403B),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildNavigateButton(
      IconData icon, String text, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Ink(
        color: Color(0xFFEEF0F0),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24,
                  ),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  Text(
                    text,
                    style: TextStyle(color: Color(0xFF808584), fontSize: 14),
                  ),
                ],
              ),
              Image.asset(
                "assets/arrow_next.png",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
