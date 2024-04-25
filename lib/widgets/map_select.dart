import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class MapSelect extends StatelessWidget {
  const MapSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLocationPicker(
        urlTemplate: 'https://api.mapbox.com/styles/v1/numa-alset/clev5io7700hc01o9ke9igzxg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibnVtYS1hbHNldCIsImEiOiJjbGVjcDd6ZnowMDBpM3hxZzM4OXZvbGJsIn0.QNIfheTCWHbb0K6ZAKIVsw',
          initPosition: LatLong(34.728, 36.711),
          selectLocationButtonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
          selectLocationButtonText: 'Set Current Location',
          selectLocationButtonLeadingIcon: const Icon(Icons.check),
          initZoom: 14,
          minZoomLevel: 5,
          maxZoomLevel: 16,
          trackMyPosition: false,
          onError: (e) => print(e),
          onPicked: (pickedData) async{
            // print(pickedData.latLong.latitude);
            // print(pickedData.latLong.longitude);
            // print(pickedData.address);
            // print(pickedData.addressData['country']);
            final flush =  Flushbar(
              message: 'location add',
              flushbarStyle: FlushbarStyle.FLOATING,
              margin: EdgeInsets.all(8.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              icon: Icon(
                Icons.check_circle_outline_outlined,
                size: 28.0,
                color: Colors.green,
              ),
              duration: Duration(milliseconds: 1400),
              leftBarIndicatorColor: Colors.green,
            );
            await flush.show(context).then((value)  {
            Navigator.of(context).pop([pickedData.latLong.latitude,pickedData.latLong.longitude,pickedData.addressData['city'].toString()]);});

          },
          // onChanged: (pickedData) {
          //   print(pickedData.latLong.latitude);
          //   print(pickedData.latLong.longitude);
          //   print(pickedData.address);
          //   print(pickedData.addressData);
          // }
    ),
    );
  }
}
