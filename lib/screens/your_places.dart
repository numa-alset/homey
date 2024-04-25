import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/my_place_list.dart';
import 'package:provider/provider.dart';

class YourPlaces extends StatefulWidget {


  @override
  State<YourPlaces> createState() => _YourPlacesState();
}

class _YourPlacesState extends State<YourPlaces> {
  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<Places>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Your places',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 1,vertical: 20),
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) => MyPlaceList(id: index,name: 'asd', price: 1, rate: 1, image: ['./assets/images/product-placeholder.png']),
    ),
      ),
    );
  }
}
