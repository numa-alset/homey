import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/circle_number.dart';
import 'package:provider/provider.dart';
ToggleButtonNumbersBeds (BuildContext context , String type){

  final provider= Provider.of<Places>(context);
  List<bool> isSelectednum=[
    provider.getNumBeds(0),provider.getNumBeds(1),
    provider.getNumBeds(2),provider.getNumBeds(3),
    provider.getNumBeds(4),provider.getNumBeds(5),
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
          provider.setNumBeds=index;
        },

      ),
    );

}