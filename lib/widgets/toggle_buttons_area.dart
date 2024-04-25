import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/circle_number.dart';
import 'package:provider/provider.dart';
ToggleButtonArea (BuildContext context , String type){

  final provider= Provider.of<Places>(context);
  List<bool> isSelectednum=[
    provider.getNumArea(0),provider.getNumArea(1),
    provider.getNumArea(2),provider.getNumArea(3),
    provider.getNumArea(4),provider.getNumArea(5),
  ];
  return
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        children: [
          CircleNumber(context, 'any'),
          CircleNumber(context, '80'),
          CircleNumber(context, '100'),
          CircleNumber(context, '120'),
          CircleNumber(context, '140'),
          CircleNumber(context, '160'),
        ],
        borderRadius: BorderRadius.circular(10),

        fillColor: Color.fromRGBO(0, 173, 181, 1),
        selectedColor: Color.fromRGBO(0, 173, 181, 1),
        constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
        isSelected: isSelectednum,

        onPressed: (index) {
          provider.setNumArea=index;
        },

      ),
    );

}