import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart'as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
// model chat conversation
class Chats {
 final int id;
 final String name;
 final String reciverName;
 final String lastDate;
 final String idSender;
 final String idReciver;

  int lastId;
Chats({required this.name, required this.id, required this.lastDate, required this.lastId, required this.reciverName,required this.idSender,required this.idReciver});
}
// model message between tow person
class Messages{
 final int id;
 final String sender;
 final String text;
 final String timestamp;
 Messages({required this.id,required this.sender,required  this.text,required this.timestamp});
}

class Chat with ChangeNotifier {
 final int userId;
  Chat(this.userId);
  File? pic;
  set setPic(File x){pic=x;notifyListeners();print(pic);}
 // set images
 List Image=[];
 List get Images{
  return[...Image];
 }
  Future<void>setImages ()async{
   var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
   final response2 = await http.get(url2);
   final extractedData2 = json.decode(response2.body) as List;

   Image=extractedData2;
   notifyListeners();
   // print(Images);
  }

 // for conversation
 List<Chats> chat=[];
 List<Chats> get chats{
  return[...chat];
 }
 Future<void>fetchAndSetChats() async{
  var url=Uri.parse('https://dani2.pythonanywhere.com');

  try{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   String cookie=json.decode(prefs.getString('userData')!)["cookie"];
   final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
   final extractedData = json.decode(response.body) as List;
   // var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
   // final response2 = await http.get(url2);
   // final extractedData2 = json.decode(response2.body) as List;
   // Images=extractedData2;
   // print(extractedData[1]);
   extractedData.sort((a, b) => b["last_message"]["timestamp"].toString().substring(0,10).compareTo(a["last_message"]["timestamp"].toString().substring(0,10)) ,);
   final List<Chats>loadedChats = [];
   extractedData.forEach((element) {
   // String imagesen=Images.firstWhere((e) => e["cid"]==element["initiator"]["id"])["image"].toString();
   // String imagerec= Images.firstWhere((e) => e["cid"]==element["receiver"]["id"])["image"].toString();
    loadedChats.add(Chats(name: element["initiator"]["username"], id: element["id"], lastDate: element["last_message"]!=null?element["last_message"]["timestamp"].toString().substring(0,10):'', lastId: element["last_message"]!=null?element["last_message"]["id"]:0, reciverName: element["receiver"]["username"],idReciver:element["receiver"]["id"].toString(),idSender:element["initiator"]["id"].toString() ));
   });
chat=loadedChats;

notifyListeners();
  }catch(e){print(e);}
  // print(chat[2].idReciver);
  // print(chat[2].idSender);
 }

 // for messages
 List<Messages> message=[];
 List<Messages> get messages{
  return[...message];
 }
 Future<void>fetchAndSetMessages(int id) async{
  var url=Uri.parse('https://dani2.pythonanywhere.com/'+id.toString());
  try{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   String cookie=json.decode(prefs.getString('userData')!)["cookie"];
   final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
   final extractedData = json.decode(response.body) ;
   final List<Messages>loadedmessages = [];
   extractedData["message_set"].forEach((element) {
    loadedmessages.add(Messages(id: element["id"], sender: element["sender"]["username"], text:  element["text"] , timestamp: element["timestamp"].toString().substring(0,10)));
       });
message=loadedmessages;
notifyListeners();
  }catch(e){print(e);}
 }

 Future<void>sendMessage(int idSender,String text) async{
  var url=Uri.parse('https://dani2.pythonanywhere.com/start/'+idSender.toString());
  try{
   print(idSender);
   print(text);
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   String token=json.decode(prefs.getString('userData')!)["token"];
   String cookie=json.decode(prefs.getString('userData')!)["cookie"];
   // final response =
    final response =await http.post(url,headers: {'Cookie': cookie,
     "Host":"dani2.pythonanywhere.com",
     "Origin":"https://dani2.pythonanywhere.com",
     "Referer":"https://dani2.pythonanywhere.com/start/$idSender",
     "X-Csrftoken":cookie.substring(10,42),
    },
   body: {"text":text}
   );
    print(response.body);
notifyListeners();
  }catch(e){print(e);}
 }

Future<void> clear ()async{
   message.clear();
   notifyListeners();
}

int allwoSend (String sender){
  int s=0;
  message.forEach((element) { element.sender==sender?s+=1:s+=10; });

  return s;
}

Future<void> startMessage (int idowner)async{
 var url=Uri.parse('https://dani2.pythonanywhere.com/customer/${idowner}');
 var url2 =Uri.parse('https://dani2.pythonanywhere.com/start/');
 try{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String cookie=json.decode(prefs.getString('userData')!)["cookie"];
  final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
  final name = json.decode(response.body)["username"] ;
  if(response.statusCode==200) {
   final response2 = await http.post(
       url2, headers: {'Cookie': cookie, "Host": "dani2.pythonanywhere.com",
    "Origin": "https://dani2.pythonanywhere.com",
    "Referer": "https://dani2.pythonanywhere.com/start/",
    "X-Csrftoken": cookie.substring(10, 42),
   },
       body: {"username":"$name"});
   print(response2.statusCode);
   print(response2.body);
   print(response2.reasonPhrase);
  }else {
   print('Error fetching data from url1: ${response.statusCode}');
  }

 }catch(e){print(e);}


}


// database section sqflite
  static Future<Database>database()async{
   var dpPath =await sql.getDatabasesPath();

   return
    sql.openDatabase(path.join(dpPath,'userChat.db'),onCreate: (db, version) {
     // Execute CREATE TABLE statements within a single transaction
     return db.transaction((txn) async {
      await txn.execute(
          'CREATE TABLE pic (idUser TEXT PRIMARY KEY, name TEXT, image TEXT)');
      await txn.execute(
          'CREATE TABLE chat (idReciver TEXT PRIMARY KEY, name TEXT, image TEXT)');
      await txn.execute(
          'CREATE TABLE massages (idReciver TEXT PRIMARY KEY, isMe BOOLEAN, massage TEXT, time DATETIME)'); // Use DATETIME for time
     });
    },version: 1);}



 static Future<void> insert(String table,Map<String,Object> data,ConflictAlgorithm x)async{

  final db= await Chat.database();
  try {
   db.insert(table, data, conflictAlgorithm: x);
   print('done insert');
  }catch(e){print(e);}
 }
 static Future<List<Map<String,dynamic>>> getData(String table)async {
  final db= await Chat.database();
  return db.query(table);
 }
 void addUser(String userId,String userName,String userImage){
  // final newPlace =Place(id: DateTime.now().toString(), title: pickedTitle, image: pickedImage, location: null);
  // _items.add(newPlace);
  // notifyListeners();
  // print(newPlace.image.path);
  // print('newPlace.image.path');
  Chat.insert('chat', {
   'idReciver':userId,
   'name':userName,
   'image':userImage
  },ConflictAlgorithm.replace);
 }

 // Future<void> fetchAndSetPlaces() async{
 //  final dataList=await DBHelper.getData('user_places');
 //  _items= dataList.map((e) => Place(id: e['id'], title: e['title'], image: File(e['image']), location: null)).toList();
 //  notifyListeners();
 // }




}
