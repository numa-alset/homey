import 'package:flutter/material.dart';
import 'package:homey/provider/favorite.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/my_place_liked.dart';
import 'package:provider/provider.dart';

class Liked extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   final place=Provider.of<Places>(context);
   final fav=Provider.of<Favourite>(context);

    return Padding(padding: EdgeInsets.symmetric(horizontal: 1,vertical: 20),
      child: fav.length==0?Center(child: Text('no fav yet'),):ListView.builder(
        itemCount: fav.length,
        itemBuilder: (context, index) => MyPlaceLiked(id: place.findById(fav.Fav[index]).id,name: place.findById(fav.Fav[index]).site, price: place.findById(fav.Fav[index]).price, rate: place.findById(fav.Fav[index]).rating, image: place.findById(fav.Fav[index]).image),
      ),
    );
  }
}
