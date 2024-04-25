import 'package:flutter/material.dart';
import 'package:homey/logo/app_logo.dart';
import 'package:homey/logo/app_logo_not_move.dart';

class OpenApp extends StatelessWidget {
  static const routName='./open-app';


  @override
  Widget build(BuildContext context) {
    void _LogIn(){
      Navigator.of(context).pushNamed('./logIn');
    }
    void _SingUp(){
      Navigator.of(context).pushNamed('./signUp');
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Container(width: MediaQuery.of(context).size.width*1.0,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(
                              color: Color(0xFFEEEEEE),
                              fontSize: 24,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0.03,
                              letterSpacing: 0.50,
                            ),
                          ),
                          TextSpan(
                            text: 'Homey',
                            style: TextStyle(
                              color: Color(0xFF00ADB5),
                              fontSize: 24,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0.03,
                              letterSpacing: 0.50,
                            ),
                          ),
                          TextSpan(
                            text: ' app',
                            style: TextStyle(
                              color: Color(0xFFEEEEEE),
                              fontSize: 24,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0.03,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ],
                      ),
                    )

                  ),
                  SizedBox(height: 60,),
                  AppLogoNotMove(),
                  Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                  'The best application to find homes for rent or to list your home for rent',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                  color: Color(0xFFEEEEEE),
                  fontSize: 15,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,

                  letterSpacing: 0.07,
                  ),
                  ),
                  )
            , Padding(
                    padding: EdgeInsets.only(top: 70),
        child: Column(children:[
                    Container(

                      width: MediaQuery.of(context).size.width*0.9,
                      child: FloatingActionButton(
                          heroTag: 'btn1',
                          onPressed: () => Navigator.of(context).pushNamed('./logIn'),
                      backgroundColor: Color.fromRGBO(0, 173, 181, 1),
                      child:Text(
                        'Continue to you account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                          letterSpacing: 0.09,
                        ),
                      )
                      ),
                    ),

          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'or',
              style: TextStyle(
                color: Color(0xFFEEEEEE),
                fontSize: 15,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                height: 0.09,
                letterSpacing: 0.07,
              ),
            ),
          ),

                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(0, 173, 181, 1)),borderRadius: BorderRadius.all(Radius.circular(15))),
                      width: MediaQuery.of(context).size.width*0.9,
                      child: FloatingActionButton(
                          heroTag: 'btn2',
                          onPressed:_SingUp,
                      backgroundColor: Color.fromRGBO(34, 40, 49, 1),

                      child: Text(
                        'Create an account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                          letterSpacing: 0.09,
                        ),
                      )
                      ),
                    ),]),
            ),
                ],
              ),
      ),



    );
  }
}
