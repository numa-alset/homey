import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Auth with ChangeNotifier{
  String? _token;
  DateTime? _expiryDate;
  int? _userId;
  Timer? _authTimer;
  var coockie;
  //........
  String? _name; get name {return _name;} set setName(String name){_name=name;}
  // String? _gender;get gender {return _gender;} set setGender(String gender){_gender=gender;}
  String? _phone;  get phone {return _phone;} set setPhone(String phone){_phone=phone;}
  String? _email;  get email {return _email;} set setEmail(String email){_email=email;}
  String? _picture;  get picture {return _picture;} set setPicture(String picture){_picture=picture;}
  //........
  bool get isAuth{
    // print('im is auth');
    if(token==null){print('im is auth false nulll');return false;}
    else if(token!.isEmpty){print('im is auth empty false');return false;}
    else{
      print('im is auth true');return true;
    }

    // return token!=null||token!.isNotEmpty;
  }

  String? get token{
    print('im in get atoken');
    print(_token);

    if(_token==null){print('im in get null atoken1'); return '';}
    // if(_expiryDate==DateTime(0)){print('im in get expiray atoken 2');return'';}
    // if(_expiryDate==null && _expiryDate!.isBefore(DateTime.now()) && _token!.isEmpty){print('im long expiry atoken3');return '';}
    // if (_expiryDate!=null && _expiryDate!.isAfter(DateTime.now()) && (_token!=null||_token!.isNotEmpty)){
    else{print('im in ok atoken 4');
      return _token;}

    // }
    // return '';
  }

  Future<void> signup(String username,String email,String password)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // final url=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDszFnoudbTo8zX6JJLhLXR3yHQjiPta9w');
    final url=Uri.parse('http://dani2.pythonanywhere.com/auth/registration/');

    try {
      final response = await http.post(url, body:
      {"username":username,'email': email, 'password': password}
      );
      print(response.headers);
      print(response.headers["set-cookie"]!.split(' ')[0]+' '+response.headers["set-cookie"]!.split(' ')[9].substring(13));
      final responseData=json.decode(response.body);
      if(responseData['error']!=null){
        print("fault in line 91 auth");
        throw Exception(responseData['error']['message']);

      }
      print(responseData);
      // _token=responseData['token'].toString();
      _userId=responseData['user']["id"];
      // print('herre');
      // print(response.headers["set-cookie"]!.split(' '));
      coockie=response.headers["set-cookie"]!.split(' ')[0]+' '+response.headers["set-cookie"]!.split(' ')[9].substring(13);
      // print(coockie);
      // setGender=responseData['gender'];
      setName=responseData['user']["username"].toString();
      setEmail=responseData['user']["email"].toString();
      setPhone=responseData['user']["phone"]==null?'0000':responseData['user']["phone"].toString();
      setPicture=responseData['user']["picture"].toString();
      // _expiryDate=DateTime.now().add(Duration(seconds:int.parse( responseData['expiresIn'])),);
      // _autoLogout();
      // print('i am login 1');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      // print('i am login 2');
      final userData=json.encode({
        'cookie':coockie,
        'token':_token,
        'userId':_userId,
        // 'expiryDate':_expiryDate?.toIso8601String(),
        'name':name,
        'gender':'male',
        'phone':phone,
        'email':email,
        'picture':picture
      });
      prefs.setString('userData', userData);
      // print("fault in line 122 auth");
      print(prefs.get("userData"));
    }catch(error){
      print(error);
      print("fault in line 120 auth");
      throw error;
    }
  }
  int? get userId{
    if(_userId==null){return 0;}
    else
      return _userId;
  }
  Future<void> login(String username,String email,String password)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
   // final url=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDszFnoudbTo8zX6JJLhLXR3yHQjiPta9w');
    final url=Uri.parse('http://dani2.pythonanywhere.com/customer/login/');

    try {
      final response = await http.post(url, body:
          {"username":username,'email': email, 'password': password}
      );
      print(response.headers);
      final responseData=json.decode(response.body);
      if(responseData['error']!=null){
        print("fault in line 91 auth");
        throw Exception(responseData['error']['message']);

      }
      print(responseData);
      _token=responseData['token'].toString();
      _userId=responseData['user']["id"];
      // print('herre');
      // print(response.headers["set-cookie"]!.split(' '));
      coockie=response.headers["set-cookie"]!.split(' ')[0]+' '+response.headers["set-cookie"]!.split(' ')[9].substring(13);
      // print(coockie);
      // setGender=responseData['gender'];
      setName=responseData['user']["username"].toString();
      setEmail=responseData['user']["email"].toString();
      setPhone=responseData['user']["phone"]==null?'0000':responseData['user']["phone"].toString();
      setPicture=responseData['user']["picture"].toString();
      // _expiryDate=DateTime.now().add(Duration(seconds:int.parse( responseData['expiresIn'])),);
      // _autoLogout();
      // print('i am login 1');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      // print('i am login 2');
      final userData=json.encode({
        'cookie':coockie,
        'token':_token,
        'userId':_userId,
        // 'expiryDate':_expiryDate?.toIso8601String(),
        'name':name,
        'gender':'male',
        'phone':phone,
        'email':email,
        'picture':picture
      });
      prefs.setString('userData', userData);
      // print("fault in line 122 auth");
      print(prefs.get("userData"));
    }catch(error){
      print(error);
      print("fault in line 120 auth");
      throw error;
    }
  }
  Future<bool> tryAutoLogin()async{
    print('i am try auto login ');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token=json.decode(prefs.getString('userData')!)["token"].toString();
    _userId=json.decode(prefs.getString('userData')!)["userId"];
    setName=json.decode(prefs.getString('userData')!)["username"].toString();
    setEmail=json.decode(prefs.getString('userData')!)["email"].toString();
    setPhone=json.decode(prefs.getString('userData')!)["phone"];
    setPicture=json.decode(prefs.getString('userData')!)["picture"].toString();
    // _expiryDate=DateTime.parse(json.decode(prefs.getString('userData')!)["expiryDate"]);
    print("token done");
    notifyListeners();
    // _autoLogout();
    sleep(Duration(seconds: 1));
    return true;
    // print(prefs.getString('userData'));
    // print('done');
    // if(!prefs.containsKey('userData')){
    //   print('shared contain key');
    //   return false;
    // }
    // if(prefs.getString('userData')==null)return false;
    // final extractedUserData=json.decode(prefs.getString('userData')!)as Map<String,Object>;
    // final expiryDate=DateTime.parse(extractedUserData['expiryDate']as String);
    // if(expiryDate.isBefore(DateTime.now())){
    //   print("im in expiry");
    //   return false;
    // }

  }

  Future<void> logout()async {
    _token='';
    _userId=0;
    _expiryDate=DateTime(0);
    if(_authTimer!=null){
      _authTimer!.cancel();
      _authTimer=null;
    }
    notifyListeners();
    final prefs=await SharedPreferences.getInstance();
    prefs.clear();
  }
  // void _autoLogout(){
  //   print('i am log out ');
  //   if(_authTimer!=null){_authTimer!.cancel();}
  //   final timeToExpiry= _expiryDate?.difference(DateTime.now()).inSeconds;
  //   _authTimer=Timer(Duration(seconds: timeToExpiry!),() => logout(),);
  // }

Future<void> updateUserInfo()async{
  final prefs = await SharedPreferences.getInstance();
  var  userData = json.decode(prefs.getString('userData')!); // Get existing or create empty map
  // print(userData);
  userData['name'] = name; // Update the 'name' value
  userData['phone'] = phone; // Update the 'name' value
  userData['email'] = email; // Update the 'name' value
  // userData['gender'] = value; // Update the 'name' value
  // print(userData);
  // Save the updated map back to shared preferences
  await prefs.setString('userData', json.encode(userData));
  var url=Uri.parse('https://dani2.pythonanywhere.com/customer/$userId/');

  try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token=json.decode(prefs.getString('userData')!)["token"];
    String cookie=json.decode(prefs.getString('userData')!)["cookie"];

    final response= await http.put(url,headers: {'Cookie': cookie,
      "Host":"dani2.pythonanywhere.com",
      "Origin":"https://dani2.pythonanywhere.com",
      "Referer":"https://dani2.pythonanywhere.com/customer/$userId/",
      "X-Csrftoken":cookie.substring(10,42),
    },body:{
      "username":'$name',"phone":"$phone","email":"$email"
    } ,);
    print(json.decode(response.body));
  }
  catch (erorr){
    print(erorr);
    throw erorr;
  }


}


}