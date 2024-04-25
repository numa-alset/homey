import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

class MyPlaceList extends StatelessWidget {
  final int id;
final List image;
final String name;
final int price;
final double rate;
MyPlaceList(
{
  required this.id,
  required this.name,
  required this.price,
  required this.rate,
  required this.image,
}
    );

  @override
  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.symmetric(vertical: 10),
    child: Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete,color: Colors.white,size: 40,),
        alignment: Alignment.centerRight,
        // padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(57, 62, 70, 1),
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () { print('done');
                      Navigator.of(context).pop(true);},
                    child: const Text("DELETE")
                ),
                TextButton(
                  onPressed: () {print('done');
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },

      // onDismissed: (direction) => print('done'),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('./matrial',arguments:  [id,image,true] as List),
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
          leading: Image.asset(image[0],width: 60,height: 60,fit: BoxFit.contain,),
          subtitle: Text(
            '\$230 USD ',
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Column(
            children: [
              Expanded(child: Switch(value: true, onChanged: (value) => null,)),
              TextButton.icon(onPressed: null, icon: Icon(Icons.star_border,color:Colors.yellow ,), label: Text('$rate',style: TextStyle(color: Color(0xFFEEEEEE),
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,),)
              ),
            ],
          ),

        ),
      ),
    ),

    );
  }
}
