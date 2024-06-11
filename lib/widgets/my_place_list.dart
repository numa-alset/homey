import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

class MyPlaceList extends StatefulWidget {
  final int id;
final List image;
final String name;
final int price;
final String rate;
 bool ratestate;
MyPlaceList(
{
  required this.id,
  required this.name,
  required this.price,
  required this.rate,
  required this.ratestate,

  required this.image,
}
    );

  @override
  State<MyPlaceList> createState() => _MyPlaceListState();
}

class _MyPlaceListState extends State<MyPlaceList> {
  @override
  void initState() {
    // TODO: implement initState
    state=widget.ratestate;
    super.initState();
  }
// Future<void> rateState(){
bool isLoding=false;
late bool state;
Future<void> rateState(bool value)async{
setState(() {
  isLoding=true;
});
await Provider.of<Places>(context,listen: false).updatePlace(widget.id.toString(), 'ratestate', value.toString())
.then((valuee) => setState(() {
  state=value;
  isLoding=false;
}))
;
}

  @override
  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.symmetric(vertical: 10),
    // child: Dismissible(
    //   key: ValueKey(widget.id),
    //   background: Container(
    //     color: Theme.of(context).colorScheme.error,
    //     child: Icon(Icons.delete,color: Colors.white,size: 40,),
    //     alignment: Alignment.centerRight,
    //     // padding: EdgeInsets.only(right: 20),
    //   ),
    //   direction: DismissDirection.endToStart,
    //   onDismissed: (direction) { Provider.of<Places>(context,listen: false).deletePlace(widget.id.toString());setState(() {
    //
    //   }); },
    //   confirmDismiss: (direction) async {
    //     return await showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           backgroundColor: Color.fromRGBO(57, 62, 70, 1),
    //           title: const Text("Confirm"),
    //           content: const Text("Are you sure you wish to delete this item?"),
    //           actions: <Widget>[
    //             TextButton(
    //                 onPressed: () { print('done');
    //
    //                   Navigator.of(context).pop(true);},
    //                 child: const Text("DELETE")
    //             ),
    //             TextButton(
    //               onPressed: () {print('done');
    //                 Navigator.of(context).pop(false);
    //               },
    //               child: const Text("CANCEL"),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   },

      // onDismissed: (direction) => print('done'),
      child: ListTile(
        title: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./matrial',arguments:  [widget.id,widget.image,true] as List),
          child: Text(
            widget.name,
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: GestureDetector(
  onTap:               () => Navigator.of(context).pushNamed('./matrial',arguments:  [widget.id,widget.image,true] as List),
            child: Image.network('${widget.image[0]}',width: 60,height: 60,fit: BoxFit.contain,)),
        subtitle: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./matrial',arguments:  [widget.id,widget.image,true] as List),
          child: Text(
            '/${widget.price} SP ',
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        trailing: Column(
          children: [
           Expanded(child:isLoding?CircularProgressIndicator() :Switch(value: state, onChanged: (value) => rateState(value),)),
            TextButton.icon(onPressed: null, icon: Icon(Icons.star_border,color:Colors.yellow ,), label: Text('${widget.rate}',style: TextStyle(color: Color(0xFFEEEEEE),
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,),)
            ),
          ],
        ),

      ),
    );

    // );
  }
}
