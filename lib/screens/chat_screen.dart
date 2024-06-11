import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homey/logo/app_logo_bg.dart';
import 'package:homey/logo/app_logo_not_move.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/widgets/chat/messages.dart';
import 'package:homey/widgets/chat/new_message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final int id;
  final String initiator;
  final String receiver;
  final String imageSen;
  final String imageRec;

   ChatScreen({
    required this.id,
    required this.initiator,
    required this.receiver,
    required this.imageRec,
    required this.imageSen,
});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+widget.imageRec)),
            ),
            Text(widget.receiver,
              style: TextStyle(
                color: Color(0xFFEEEEEE),
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [

          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
            ),
            items: [
              DropdownMenuItem(
                child: Container(

                  child: Row(

                    children: <Widget>[
                      Icon(Icons.add_call),
                      SizedBox(width: 8),
                      Text('call him',),
                    ],

                  ),

                ),
                value: 'call',

              ),
            ],
            onChanged: (value) {

            },
            iconEnabledColor: Colors.grey,

            focusColor: Colors.grey,
            dropdownColor: Colors.grey,
          ),
        ],

      ),
      body: Stack(
        children:[
          // Padding(padding:EdgeInsets.only(bottom: 65),child: Center(child: AppLogoBg(),)),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),
            child: Center(child: Image.asset('assets/images/Logo-Photoroom.png',fit: BoxFit.cover,)),
          ),
          // Image(image: AssetImage('assets/images/Logo.png')),
          Container(

          child: Column(
            children: <Widget>[
              Expanded(
                child: Messagess(widget.id, widget.initiator.toString(),widget.imageRec.toString(),widget.imageSen.toString()),
              ),
              Provider.of<Chat>(context).allwoSend(widget.initiator)==1 ?Text("sorry u cant send anymore until u been replied"): NewMessage(widget.id),
            ],
          ),
        ),
    ]
      ),

    );
  }
}
