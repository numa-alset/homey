import 'package:flutter/material.dart';
import 'package:homey/provider/chat.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
 final int id;
 NewMessage(this.id);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final helper =Provider.of<Chat>(context,listen: false);
    await helper.sendMessage(widget.id, _enteredMessage);
    // final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    // FirebaseFirestore.instance.collection('chat').add({
    //   'text': _enteredMessage,
    //   'createdAt': Timestamp.now(),
    //   'userId': user.uid,
    //   'username': userData.data()['username'],
    //   'userImage': userData.data()['image_url']
    // });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...',fillColor: Colors.white,filled: true,

              ),style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Colors.lightBlue,
            icon: Icon(
              Icons.send,
              color: _enteredMessage.isEmpty|| _enteredMessage==null ? Colors.grey : Colors.white,
            ),
            onPressed: _enteredMessage.isEmpty|| _enteredMessage==null ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
