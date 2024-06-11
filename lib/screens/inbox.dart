import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Inbox extends StatelessWidget {


Future<String>setimage(String id)async{
  var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
  final response2 = await http.get(url2);
  final extractedData2 = json.decode(response2.body) as List;
 return extractedData2.firstWhere((element) => element['cid'].toString()==id.toString())["image"].toString();
}
  @override
  Widget build(BuildContext context) {
    List<Chats> chats=Provider.of<Chat>(context).chats;
   var Images= Provider.of<Chat>(context).Images;
   // String imagerec= Images.firstWhere((e) => e["cid"]==element["receiver"]["id"])["image"].toString();
// print('https://dani2.pythonanywhere.com'+Images.firstWhere((e) => e["cid"]==5));
    print(Images.firstWhere((element) => element["cid"].toString()=='5')["image"].toString());
    return FutureBuilder(
      future: Provider.of<Chat>(context).fetchAndSetChats(),
      builder: (context, snapshot) => ListView.builder(
        itemCount: chats.length,
        itemBuilder:(context, index) =>  Padding(padding: EdgeInsets.all(5),
        child: ListTile(
          onTap:()async {

             Provider.of<Places>(context,listen: false).setNotification2=false;
            await Provider.of<Chat>(context,listen: false).clear().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ChatScreen(id: chats[index].id, initiator: chats[index].name.toString(), receiver: chats[index].reciverName.toString(),imageRec: Images.firstWhere((element) => element["cid"].toString()== chats[index].idReciver.toString())["image"].toString(),imageSen: Images.firstWhere((element) => element["cid"].toString()== chats[index].idSender.toString())["image"].toString(),),)));

          } ,
          trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          title: Text(chats[index].reciverName,style: TextStyle(color: Colors.white),),
          leading:
          // CircleAvatar(child:  Text('s')),
          // CircleAvatar(  backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+Images.firstWhere((e) => e["cid"].toString()==chats[index].idReciver.toString())),),
          // FutureBuilder(
          //   future: setimage(chats[index].idReciver.toString()),
          //     builder:(context, snapshot) =>
          //         snapshot.hasData?
          //         CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+snapshot.data.toString()))
          // :CircleAvatar(child: Text(chats[index].reciverName[0]))
          //
          // ),
          CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+Images.firstWhere((element) => element["cid"].toString()==chats[index].idReciver.toString())["image"].toString()??'')),
          subtitle: Text(chats[index].lastDate),

        ),
        ),
      ),
    );

  }
}
