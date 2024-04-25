import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
    child: ListTile(
      onTap:() {

      } ,
      trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
      title: Text('micheal',style: TextStyle(color: Colors.white),),
      leading: CircleAvatar(child:Text('s') ,),
      subtitle: Text('22/3'),

    ),
    );

  }
}
