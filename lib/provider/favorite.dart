import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class Favourite with ChangeNotifier{

final int userId;
Favourite(this.userId);

List fav=[];
get Fav{return [...fav];}
get length {return fav.length;}
Future<void> addFav (int id)async{
  print(userId);
  print(id);
  var url=Uri.parse('https://dani2.pythonanywhere.com/Favorites/$userId/');
  fav.add(id);
  notifyListeners();
  try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token=json.decode(prefs.getString('userData')!)["token"];
    String cookie=json.decode(prefs.getString('userData')!)["cookie"];

    final response= await http.post(url,headers: {'Cookie': cookie,
    "Host":"dani2.pythonanywhere.com",
    "Origin":"https://dani2.pythonanywhere.com",
    "Referer":"https://dani2.pythonanywhere.com/Favorites/$userId/",
    "X-Csrftoken":cookie.substring(10,42),
    },body:{
      "idp":"$id","idc":"$userId"
    } ,);
    print(json.decode(response.body));
  }
  catch (erorr){
    fav.remove(id);
    notifyListeners();
    print(erorr);
    throw erorr;
  }
}
Future<void>deleteFav(int id)async{
  print(id);
  print(userId);

  var url=Uri.parse('https://dani2.pythonanywhere.com/Favorites/$userId/$id/');
  fav.remove(id);
  notifyListeners();
  try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token=json.decode(prefs.getString('userData')!)["token"];
    String cookie=json.decode(prefs.getString('userData')!)["cookie"];

    final response= await http.delete(url,headers: {'Cookie': cookie,
      "Host":"dani2.pythonanywhere.com",
      "Origin":"https://dani2.pythonanywhere.com",
      "Referer":"https://dani2.pythonanywhere.com/Favorites/$userId/$id/",
      "X-Csrftoken":cookie.substring(10,42),
    });
    print(response.statusCode);
    print(response.reasonPhrase);

  }
  catch (erorr){
    fav.add(id);
    notifyListeners();
    print(erorr);
    throw erorr;
  }

}
Future<void>fetchAndSetFav()async{
  print(userId);
  var url=Uri.parse('https://dani2.pythonanywhere.com/Favorites/'+userId.toString());
  final response= await http.get(url);
  final extractedData= json.decode(response.body) as List;

  final List loadedProducts=[];
  if(extractedData==null){
    return;
  }
  extractedData.forEach((value) {
    if(!loadedProducts.contains(value['idp']))
    loadedProducts.add(value['idp']);
  });
  print(loadedProducts);
  fav=loadedProducts;
  notifyListeners();
  // print('done');
}
bool isFav(int id){
  if(fav.contains(id))return true;
  else return false;
}
}