import 'package:flutter/material.dart';

CircleNumber (BuildContext context,String num){


return
  (num=='any')?

        Container(
          width: 265,
          height: 55,
          decoration: ShapeDecoration(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Color(0xFF00ADB5))
          ),

      ),
     child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: 40.22,
          height: 21.74,
          child: Text(
            'Any',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),

)

    :
Container(
width: 60,
height: 60,

decoration: ShapeDecoration(
shape: OvalBorder(
side: BorderSide(width: 1, color: Color(0xFF00ADB5)),
),

),

 child: Padding(
padding: EdgeInsets.all(13),
child: Text(
'$num',
textAlign: TextAlign.center,
style: TextStyle(
color: Color(0xFFEEEEEE),
fontSize: 18,
fontFamily: 'Lato',
fontWeight: FontWeight.w700,
),
),
),


);


}