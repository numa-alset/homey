import 'package:flutter/material.dart';

class LogInAndSecurity extends StatefulWidget {


  @override
  State<LogInAndSecurity> createState() => _LogInAndSecurityState();
}

class _LogInAndSecurityState extends State<LogInAndSecurity> {
  bool read=true;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Login & security',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 30,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            TextFormField(
              initialValue: '******',
              style: TextStyle(
                color: Color(0xFFEEEEEE),
                fontSize: 15,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                label: Text(
                  'Password',
                  style: TextStyle(color: Color(0xFFEEEEEE),
                    fontSize: 15,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,),),

                suffixIcon: TextButton(onPressed: () {
                  setState(() {
                    read=false;
                  });
                },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Color(0xFFEEEEEE),
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      height: 2,
                      decorationColor: Color(0xEEEEEEEE),),),
                ),

              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onFieldSubmitted: (value) {
                // legal = !legal;
                print(value);
                setState(() {
                  read=true;
                  // Widget.canUpdate(oldWidget, newWidget)legal = !legal;
                });
              },
              readOnly: read,

            )
          ],
        ),
      ),
    );
  }
}
