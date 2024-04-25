import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart'as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
class Chat with ChangeNotifier {
 final String userId;
  Chat(this.userId);
  File? pic;
  set setPic(File x){pic=x;notifyListeners();print(pic);}

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
