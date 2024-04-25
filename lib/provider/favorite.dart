import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Favourite with ChangeNotifier{

final String userId;
Favourite(this.userId);

List fav=[1,2];
get Fav{return [...fav];}
get length {return fav.length;}
Future<void> addFav (int id)async{
  var url=Uri.parse('');
  // try{
  //   final response= await http.post(url,body:json.encode({
  //     'userId':userId,
  //     'placeid':id
  //   }) ,);
  //   print(json.decode(response.body));
  //   _fav.add(id);
  //   notifyListeners();
  // }
  // catch (erorr){
  //   _fav.add(id);
  //   notifyListeners();
  //   print(erorr);
  //   throw erorr;
  // }
  print(id);
  fav.add(id);
  notifyListeners();
}
Future<void>deleteFav(int id)async{
  var url=Uri.parse('');
  // try{
  //   final response= await http.post(url,body:json.encode({
  //     'userId':userId,
  //     'placeid':id
  //   }) ,);
  //   print(json.decode(response.body));
  //   _fav.remove(id);
  //   notifyListeners();
  // }
  // catch (erorr){
  //   _fav.remove(id);
  //   notifyListeners();
  //   print(erorr);
  //   throw erorr;
  // }
  fav.remove(id);
  notifyListeners();

}
Future<void>fetchAndSetFav()async{
  var url=Uri.parse('https://my.api.mockaroo.com/test.json?key=2a7b2620');
  final response= await http.get(url);
  final extractedData= json.decode(response.body) as List;

  final List loadedProducts=[];
  if(extractedData==null){
    return;
  }
  extractedData.forEach((value) {
    loadedProducts.add(value['id']);
  });
  fav=loadedProducts;
  notifyListeners();
  // print('done');
}
bool isFav(int id){
  if(fav.contains(id))return true;
  else return false;
}
}