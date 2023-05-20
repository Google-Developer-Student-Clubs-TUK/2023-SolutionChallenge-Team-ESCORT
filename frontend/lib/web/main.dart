import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'web_page.dart';

void main() => runApp(GetMaterialApp(home: WebPage()));

/*
Container(
                color: Colors.red,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF347E5B),
                        ),
                        width: mediaQuery * 0.3,
                        height: mediaQuery * 0.3,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: mediaQuery * 0.3,
                      child: Image(
                        image: AssetImage('assets/iphone_feat2.png'),
                        width: mediaQuery * 0.165, // 0.1155,
                        height: mediaQuery * 0.33, // 0.0231,
                      ),
                    ),
                    Positioned(
                      left: mediaQuery * 0.3,
                      right: 0,
                      child: Image(
                        image: AssetImage('assets/iphone_feat1.png'),
                        width: mediaQuery * 0.165,
                        height: mediaQuery * 0.33,
                      ),
                    ),
                  ],
                ),
              )
 */