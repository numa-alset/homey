import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/price_range.dart';
import 'package:homey/widgets/toggle_butons_beds.dart';
import 'package:homey/widgets/toggle_button_numbers.dart';
import 'package:homey/widgets/toggle_buttons.dart';
import 'package:homey/widgets/toggle_buttons_area.dart';
import 'package:homey/widgets/toggle_buttons_salons.dart';
import 'package:homey/widgets/toogle_buttons_baths.dart';
import 'package:provider/provider.dart';

class Filters extends StatefulWidget {


  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {


  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<Places>(context);
    int numOfPlaces=provider.filteredPlaces.length;
    var type=provider.type;
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Filters',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 20,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 20,

      ),
      persistentFooterButtons: [

        Container(
          height: MediaQuery.of(context).size.height*0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {
                  provider.unDoFilteresPlaces();
                  // Navigator.of(context).pop();
                },
                child: Text(
                  'Clear all',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0x99EEEEEE),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    height: 0.06,
                    letterSpacing: 0.09,
                  ),
                ),
                ),
                ElevatedButton(onPressed: () {
                  provider.doFilteredPlaces();
                  Navigator.of(context).pop();
                } ,
                    child: Text('show $numOfPlaces ${
                        provider.type=='HO'?'home':provider.type=='SH'?'shop':provider.type=='LO'?'loung':provider.type=='RO'?'room':provider.type=='CH'?'chalet':provider.type=='VI'?'villa':provider.type=='FA'?'farm':'place'
                    }',style: TextStyle(fontSize: 18),),
                style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 173, 181, 1)),
                  foregroundColor: MaterialStatePropertyAll(Color(0xEEEEEEEE))
                ),
                ),

              ],
            )
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 30), child: Container(child: Text('Price range ', style:hardStyle),),),

            Padding (padding: EdgeInsets.symmetric(vertical: 10), child: buildToggleButtons(context)),
            Padding(padding: EdgeInsets.symmetric(vertical: 10), child: buildRow(context),),

            Padding(padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(),
            ),

            Padding(padding: const EdgeInsets.only(bottom: 20), child: Text('Basics', style: hardStyle),),

            (type=='RO'||type=='SH'||type=='LO')?SizedBox():Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Rooms', style: liteStyle),),
            (type=='RO'||type=='SH'||type=='LO')?SizedBox():ToggleButtonNumbers(context, 'Rooms'),
            (type=='RO'||type=='SH'||type=='LO')?SizedBox():Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Salons', style: liteStyle),),
            (type=='RO'||type=='SH'||type=='LO')?SizedBox():ToggleButtonNumbersBeds(context, 'Salons'),
            (type!='RO')?SizedBox():Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Beds', style: liteStyle),),
            (type!='RO')?SizedBox():ToggleButtonNumbersSalons(context, 'Beds'),
            Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Bathrooms', style:liteStyle),),
            ToggleButtonNumbersBaths(context, 'baths'),
            Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Area', style:liteStyle),),
            ToggleButtonArea(context, 'Area'),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(),
            ),

            Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: Text('Amenities', style: hardStyle),),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Wifi', style: aminitiStyle), Checkbox(value: provider.wifi, onChanged: (value) => provider.setwifi=value!,),],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Solar Power', style: aminitiStyle), Checkbox(value: provider.solarPower, onChanged: (value) => provider.setsolar=value!,),],),
            (type=='RO'||type=='VI'||type=='CH'||type=='FA'||type=='LO')?SizedBox():Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Parking', style: aminitiStyle),Checkbox(value: provider.Parking, onChanged: (value) => provider.setparking=value!,),],),
            (type=='RO'||type=='SH'||type=='LO')?SizedBox():Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Swimming pool', style: aminitiStyle), Checkbox(value: provider.swimmingPool, onChanged: (value) => provider.setswim=value!,),],),
            (type=='RO'||type=='VI'||type=='CH')?SizedBox():Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Garden', style: aminitiStyle), Checkbox(value: provider.garden, onChanged: (value) => provider.setgarden=value!,),],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Furnished', style: aminitiStyle), Checkbox(value: provider.furnished, onChanged: (value) => provider.setfurnished=value!,),],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Elevator', style: aminitiStyle,), Checkbox(value: provider.elevator, onChanged: (value) => provider.setelevator=value!,),],),

             ],
        ),
      ),


    );
  }
 var liteStyle= TextStyle(
  color: Color(0x99EEEEEE),
  fontSize: 18,
  fontFamily: 'Lato',
  fontWeight: FontWeight.w300,
  height: 0.06,
  letterSpacing: 0.09,
  );
 var hardStyle= TextStyle(
  color: Color(0xFFEEEEEE),
  fontSize: 18,
  fontFamily: 'Lato',
  fontWeight: FontWeight.w500,
  height: 0.06,
  letterSpacing: 0.09,
  );
  var aminitiStyle= TextStyle(
  color: Color(0x99EEEEEE),
  fontSize: 18,
  fontFamily: 'Lato',
  fontWeight: FontWeight.w500,
  );

}
