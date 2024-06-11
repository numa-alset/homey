import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      this.message,
      this.userName,
      this.userImage,
      this.isMe,
      this.time
);


  final String message;
  final String userName;
  final String userImage;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? Colors.lightBlueAccent :Colors.grey[300] ,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                    ),
                  ),
                  width: 140,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  margin: EdgeInsets.fromLTRB(
                    8,16,8,0
                    // vertical: 16,
                    // horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe
                              ? Colors.black
                              : Colors.black45,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Colors.black45,
                        ),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(time),
                )
              ],
            ),


          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundColor: isMe ? Colors.lightBlueAccent :Colors.grey[300]  ,
            backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+userImage.toString()),
            // backgroundImage:
            // NetworkImage(
            //   userImage,
            // ),
          ),
        ),

      ],
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}