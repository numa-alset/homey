import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/circle_number.dart';
import 'package:provider/provider.dart';
ToggleButtonNumbersBaths (BuildContext context , String type){

  final provider= Provider.of<Places>(context);
  List<bool> isSelectednum=[
    provider.getNumBaths(0),provider.getNumBaths(1),
    provider.getNumBaths(2),provider.getNumBaths(3),
    provider.getNumBaths(4),provider.getNumBaths(5),
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
          provider.setNumBaths=index;
        },

      ),
    );

}