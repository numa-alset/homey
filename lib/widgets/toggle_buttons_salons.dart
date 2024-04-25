import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/circle_number.dart';
import 'package:provider/provider.dart';
ToggleButtonNumbersSalons (BuildContext context , String type){

  final provider= Provider.of<Places>(context);
  List<bool> isSelectednum=[
    provider.getNumSalons(0),provider.getNumSalons(1),
    provider.getNumSalons(2),provider.getNumSalons(3),
    provider.getNumSalons(4),provider.getNumSalons(5),
  ];
  return
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        children: [
          CircleNumber(context, 'any'),
          CircleNumber(context, '1'),
          CircleNumber(context, '2'),
          CircleNumber(context, '3'),
          CircleNumber(context, '4'),
          CircleNumber(context, '5'),
        ],
        borderRadius: BorderRadius.circular(10),

        fillColor: Color.fromRGBO(0, 173, 181, 1),
        selectedColor: Color.fromRGBO(0, 173, 181, 1),
        constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
        isSelected: isSelectednum,

        onPressed: (index) {
          provider.setNumSalons=index;
        },

      ),
    );

}