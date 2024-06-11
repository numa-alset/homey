import 'dart:math';

import 'package:flutter/material.dart';

class AppLogoBg extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(34, 40, 49, 1),
      // AnimatedBuilder(
      //   animation: animationController!
      //   ,
      //   builder: (context, child) => Transform.rotate(
      //
      // angle:
      // rotationTween.evaluate(animationController!)
      //     ,
      child:  Container(

        width: 200,
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Color.fromRGBO(34, 40, 49, 1),

            borderRadius:  BorderRadius.circular(23)
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        spreadRadius: 0,
                        offset: Offset(5, 5),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 125,
                        top: 38,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          clipBehavior: Clip.hardEdge,
                          child: Container(width: 20,height: 48,
                            decoration: BoxDecoration(color: Color.fromRGBO(57, 62, 70, 1),
                              borderRadius: BorderRadius.circular(25),
                              // border: BorderDirectional(bottom: BorderSide(width: 20),end: BorderSide(width: 20))
                            ),
                          ),
                          // Image.asset('assets/images/black_logo.png',
                          //   width: 30,
                          //   height: 48,
                          //   fit: BoxFit.contain,
                          // ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 38,
                        child: Container(
                          width: 20,
                          height: 124,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF00ADB5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 64,
                        top: 41,
                        child: Transform.rotate(
                          angle:  55 * pi / 180,
                          child: Container(
                            width: 18,
                            height: 90,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFF00ADB5),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  spreadRadius: 0,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 126,
                        top: 86,
                        child:  Container(width: 20,height: 76,
                          decoration: BoxDecoration(color: Color(0xFF00ADB5),
                            borderRadius: BorderRadius.circular(25),
                            // border: BorderDirectional(bottom: BorderSide(width: 20),end: BorderSide(width: 20))
                          ),
                        ),
                        // Image.asset(
                        //   'assets/images/blue_logo.png',
                        //    width: 30,
                        //   height: 83,
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                      Positioned(
                        left: 84,
                        top: 99,
                        child: Container(
                          width: 15,
                          height: 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF222831),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4200ADB5),
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 101,
                        top: 99,
                        child: Container(
                          width: 15,
                          height: 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF222831),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4200ADB5),
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 101,
                        top: 115,
                        child: Container(
                          width: 15,
                          height: 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF222831),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4200ADB5),
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 84,
                        top: 115,
                        child: Container(
                          width: 15,
                          height: 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color(0xFF222831),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4200ADB5),
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      // right....................................
                      Positioned(
                        left: 122,
                        top: 41,
                        child: Transform.rotate(
                          angle: 305 * pi / 180,
                          child: Container(

                            width: 18,
                            height: 90,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFF00ADB5),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  spreadRadius: 0,
                                  offset: Offset(5, 5),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // )
    );
  }
}
