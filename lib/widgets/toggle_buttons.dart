import'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';
ToggleButtons buildToggleButtons(BuildContext context) {
  final provider= Provider.of<Places>(context);
  List<bool> isSelectedprice=[provider.priceMonthly==1,provider.priceMonthly==2];
  return ToggleButtons(
    constraints: BoxConstraints.expand(width:MediaQuery.of(context).size.width*0.5-25,height: MediaQuery.of(context).size.height*0.1 ,),

    borderRadius: BorderRadius.circular(10) ,
    borderColor:Color.fromRGBO(0, 173, 181, 1) ,
    borderWidth: 2,
    renderBorder: true,
    fillColor: Color.fromRGBO(0, 173, 181, 1),
    selectedColor: Color.fromRGBO(0, 173, 181, 1),
    selectedBorderColor:Color.fromRGBO(0, 173, 181, 1) ,
    children: [
      Padding(
        padding:  EdgeInsets.all(1),
        child: Text(
          'Price monthly',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,

          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.all(1),
        child: Text(
          'Price daily',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,

          ),
        ),
      )
    ], isSelected: isSelectedprice,
    onPressed: (index) {
      if(index==0){provider.setPriceMonthly=1;}
      if(index==1){provider.setPriceMonthly=2;}
    },
  );
}