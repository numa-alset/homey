import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Comments extends StatefulWidget {
  final int id;
  final String date_time;
  final String comments;
  final int idc;
  final int idp;
  bool isMe;
  Comments({
    required this.id,
    required this.date_time,
    required this.comments,
    required this.idc,
    required this.idp,
    required this.isMe,
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
 String name='username';
@override
  void initState() {
getName();
    // TODO: implement initState
    super.initState();
  }
 Future<void>getName()async{
   var url=Uri.parse('https://dani2.pythonanywhere.com/customer/${widget.idc}');
   try{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String cookie=json.decode(prefs.getString('userData')!)["cookie"];
     final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
     final extractedData = json.decode(response.body) ;
     setState(() {
       name =extractedData["username"];
     });

     print(extractedData["username"]);

   }catch(e){print(e);}
   print(name);
 }
  @override
  Widget build(BuildContext context) {

    var Images= Provider.of<Chat>(context).Images;
    return ListTile(
      trailing:
      DropdownButton(
        underline: Container(),
        icon: Icon(
          Icons.more_vert,
        ),
        items: [
        widget.isMe?  DropdownMenuItem(
            child: Container(

              child: InkWell(
                onTap: () async{
                  FocusScope.of(context).unfocus();
                  Provider.of<Places>(context,listen: false).deleteComment(widget.id.toString());
                },
                child: Row(

                  children: <Widget>[
                    Icon(Icons.delete,color: Colors.red,),
                    SizedBox(width: 8),
                    Text('delete',style: TextStyle(color: Colors.white),),
                  ],

                ),
              ),

            ),
            value: 'call',

          ):
          DropdownMenuItem(
            child: Container(

              child: Row(

                children: <Widget>[
                  Icon(Icons.flag),
                  SizedBox(width: 8),
                  Text('report',style: TextStyle(color: Colors.white),),
                ],

              ),

            ),
            value: 'call',

          ),
        ],
        onChanged: (value) {

        },
        // iconEnabledColor: Colors.grey,
        //
        // focusColor: Colors.grey,
        dropdownColor: Colors.grey,
      ),
      // Expanded(
      //   child: DropdownButton(items: [
      //   // isMe? DropdownMenuItem(child: TextButton.icon(onPressed: () {
      //   //
      //   // }, label: Text('delete'),icon: Icon(Icons.delete),)):DropdownMenuItem(child:Padding(padding: EdgeInsets.zero) ),
      //   //
      //   DropdownMenuItem(child: TextButton(onPressed: () {
      //
      //    }, child: Text('report')))
      //   ], onChanged:(value) {},),
      // ),

      title:
      // FutureBuilder(
      //     future: getName(),
      //     builder: (context, snapshot) => name.isNotEmpty?Text(name):Text("usernaem"),
      //
      // ),
      Text(name,style: TextStyle(color: Colors.white),),
      leading:
      // CircleAvatar(child:  Text('s')),
      // CircleAvatar(  backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+Images.firstWhere((e) => e["cid"].toString()==chats[index].idReciver.toString())),),
      // FutureBuilder(
      //     future:setimage(chats[index].idReciver.toString()),
      //     builder:(context, snapshot) =>
      //     snapshot.hasData?
      //     CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+snapshot.data.toString()))
      //         :CircleAvatar(child: Text(chats[index].reciverName[0]))
      //
      // ),
      CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+Images.firstWhere((element) => element["cid"].toString()==widget.idc.toString())["image"].toString()??'')),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.comments,style: TextStyle(color: Colors.white,),textAlign: TextAlign.right,),
          Align(alignment:AlignmentDirectional.bottomEnd ,child: Text(widget.date_time,textAlign: TextAlign.end,)),
        ],
      ),



    );
  }
}
