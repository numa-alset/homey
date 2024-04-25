import'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

Row buildRow(BuildContext context) {
  final provider=Provider.of<Places>(context);
  // var minControler=TextEditingController();
  // var maxControler=TextEditingController();
var maxCo=TextEditingController();
var minCo=TextEditingController();
maxCo.text=provider.maxPrice.toString();
minCo.text=provider.minPrice.toString();
// print('${maxCo}');
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextFormField(
        decoration: InputDecoration(labelText: 'Minimum',
            prefixIcon: Icon(Icons.attach_money),
            prefixIconColor:Color(0xFFEEEEEE) ,
            // border: UnderlineInputBorder(borderSide: BorderSide(width: 0)),
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromRGBO(0, 173, 181, 1))
            ),
            // OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(color: )
            // ),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.35)
        ),

        // maxLength: 4,
        keyboardType: TextInputType.numberWithOptions(signed: false),
        // initialValue:provider.minPrice.toString(),
        controller: minCo,
        validator: (value) {
          if (value==null||value.isEmpty ) {
            return 'Invalid name!';
          }
          return null;
        },
        // onSaved: (value) {
        //   if(value==null){return;}else
        //   provider.setMinPrice=int.parse(value);
        //   // _LogInData['name'] = value!;
        // },
        onFieldSubmitted: (value) {
          provider.setMinPrice=int.parse(value);
        },
      ),

      Container(
        width: 22,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color(0xFFEEEEEE),
            ),
          ),
        ),
      ),
      TextFormField(

        decoration: InputDecoration(

            labelText: 'Maximum',
            prefixIcon: Icon(Icons.attach_money),
            prefixIconColor:Color(0xFFEEEEEE) ,
            // border: UnderlineInputBorder(borderSide: BorderSide(width: 0)),
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromRGBO(0, 173, 181, 1))
            ),
            // OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(color: )
            // ),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.35)
        ),

        // maxLength: 4,
        keyboardType: TextInputType.numberWithOptions(signed: false),
        // initialValue:'${provider.maxPrice}',
        controller: maxCo,
        validator: (value) {
          if (value==null||value.isEmpty ) {
            return 'Invalid num!';
          }
          return null;
        },
        onSaved: (value) {

          if(value==null){return;}else
            provider.setMaxPrice=int.parse(value);
          // _LogInData['name'] = value!;
        },
        onFieldSubmitted: (value) {
          provider.setMaxPrice=int.parse(value);
        },
      ),


    ],
  );
}