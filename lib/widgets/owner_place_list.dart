import 'package:flutter/material.dart';

class OwnerPlaceList extends StatelessWidget {
  final int id;
  final List image;
  final String name;
  final int price;
  final String rate;



   OwnerPlaceList({
     required this.id,
     required this.name,
     required this.price,
     required this.rate,


     required this.image,
});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('./matrial',arguments:  [id,image,false] as List),
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Image.network('${image[0]}',width: 60,height: 60,fit: BoxFit.contain,),
          subtitle: Text(
            '/${price} SP ',
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: TextButton.icon(onPressed: null, icon: Icon(Icons.star_border,color:Colors.yellow ,), label: Text('$rate',style: TextStyle(color: Color(0xFFEEEEEE),
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,),)
          ),

        ),
      ),

    );;
  }
}
