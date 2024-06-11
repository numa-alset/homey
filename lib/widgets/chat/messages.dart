import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/widgets/chat/message_bubble.dart';
import 'package:provider/provider.dart';

class Messagess extends StatelessWidget {

  final int id;
  String sender;
  String imageRec;
  String imageSen;
   Messagess(this.id,this.sender,this.imageRec,this.imageSen);

  @override
  Widget build(BuildContext context) {
  var chatDocs=Provider.of<Chat>(context).messages;

    return FutureBuilder(
        future: Provider.of<Chat>(context).fetchAndSetMessages(id),
        builder: (context, snapshot) =>
            ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index].text,
                chatDocs[index].sender,
                  chatDocs[index].sender == sender?imageSen:imageRec,
                chatDocs[index].sender == sender,
                chatDocs[index].timestamp
              ),

            ),

    );

  }
}
