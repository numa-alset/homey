
import 'package:flutter/material.dart';

import 'package:homey/provider/chat.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Profile extends StatelessWidget {

  Future<String>setimage()async{
    final prefs = await SharedPreferences.getInstance();
   var id=json.decode(prefs.getString('userData')!)["userId"];
    var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
    final response2 = await http.get(url2);
    final extractedData2 = json.decode(response2.body) as List;
    return extractedData2.firstWhere((element) => element['cid'].toString()==id.toString())["image"].toString();
  }
  Future<String>setname()async{
    final prefs = await SharedPreferences.getInstance();
   return json.decode(prefs.getString('userData')!)["name"].toString();
    // var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
    // final response2 = await http.get(url2);
    // final extractedData2 = json.decode(response2.body) as List;
    // return extractedData2.firstWhere((element) => element['cid'].toString()==id.toString())["image"].toString();
  }
  @override
  Widget build(BuildContext context) {


    return ListView(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./personalInfo'),
          child: ListTile(

            leading:
            FutureBuilder(
                future:setimage(),
                builder:(context, snapshot) =>
                snapshot.hasData?
                CircleAvatar(backgroundImage: NetworkImage('https://dani2.pythonanywhere.com'+snapshot.data.toString()))
                    :CircleAvatar(child: Text('s'))

            ),
            // CircleAvatar(
            //   // foregroundImage: Provider.of<Chat>(context).pic!=null?FileImage(Provider.of<Chat>(context).pic!):FileImage('sda'),
            //   child: Provider.of<Chat>(context).pic!=null?Container(decoration: BoxDecoration(shape: BoxShape.circle),
            //       clipBehavior: Clip.antiAlias, child: Image.file(Provider.of<Chat>(context).pic!,fit: BoxFit.cover,width: double.infinity,)):Text('s'),
            // ),
            title: FutureBuilder(
                future:setname(),
                builder:(context, snapshot) =>
                snapshot.hasData?
    Text(
    snapshot.data.toString(),
    style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w400,),
    )
                    :Text(
    'no name',
    style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w400,),
    ),

            ),


            subtitle: Text('Show profile', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
            trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_sharp,color:Color(0xEEEEEEEE) ,),onTap: () {Navigator.of(context).pushNamed('./personalInfo');},)
            // IconButton(color: Color(0xEEEEEEEE),icon: Icon(Icons.arrow_forward_ios_sharp) , onPressed: () => null,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./listYourPlace'),
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.18,
            decoration: BoxDecoration(color: Color(0xFF393E46),borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text.rich(TextSpan(children: [TextSpan(text: 'List your place on ', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w500,),), TextSpan(text: 'Homey', style: TextStyle(color: Color(0xFF00ADB5), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w500,),),],),),
                      Text(softWrap: true, 'It’s simple to get set up and \nstart earning. ', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 12, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
                    ],
                  ),
                ),
                Image.asset('assets/images/house.png',fit: BoxFit.cover),
              ],
            ),
          ),
        ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 0, 10),
          child: Text(
            'Account Settings',
            style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 18, fontFamily: 'Lato', fontWeight: FontWeight.w500,),
          ),
        ),
        GestureDetector(
          onTap:() =>  Navigator.of(context).pushNamed('./personalInfo'),
          child: ListTile(
            title: Text(
              'Personal information',
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
              trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_sharp,color:Color(0xEEEEEEEE) ,),onTap: () {Navigator.of(context).pushNamed('./personalInfo');},),
              leading: Icon(Icons.manage_accounts_outlined,color:Color(0xFFEEEEEE) ,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        GestureDetector(
          onTap: () =>Navigator.of(context).pushNamed('./logInAndSecurity') ,
          child: ListTile(
            title: Text(
              'Login & security',
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
            trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_sharp,color:Color(0xEEEEEEEE) ,),onTap: () {Navigator.of(context).pushNamed('./logInAndSecurity');},),
            leading: Icon(Icons.shield_outlined,color:Color(0xFFEEEEEE) ,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        Consumer<Places>(builder: (context, valuee, child) => ListTile(
            title: Text(
              'Notifications',
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
            trailing: Switch(value: valuee.notification, onChanged: (value) => valuee.setNotification=value,activeColor: Color(0xFF00ADB5)),
            leading: Icon(Icons.notifications_none,color:Color(0xFFEEEEEE) ,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
    Padding(
    padding: const EdgeInsets.fromLTRB(20, 25, 0, 10),
    child: Text(
    'Hosting',
    style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 18, fontFamily: 'Lato', fontWeight: FontWeight.w500,),
    ),),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./listYourPlace'),
          child: ListTile(
            title: Text(
              'List yor place',
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
            trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_sharp,color:Color(0xEEEEEEEE) ,),onTap: () {Navigator.of(context).pushNamed('./listYourPlace');},),
            leading: Icon(Icons.add_home_outlined,color:Color(0xFFEEEEEE) ,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('./yourPlaces'),
          child: ListTile(
            title: Text(
              'Your places',
              style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),
            trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_sharp,color:Color(0xEEEEEEEE) ,),onTap: () {Navigator.of(context).pushNamed('./yourPlaces');},),
            leading: Icon(Icons.home_outlined,color:Color(0xFFEEEEEE) ,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider( ),
        ),
        Center(child: TextButton(
         child: Text ('Log out',
          style: TextStyle(
            height: 2,
            color: Color(0xFFEEEEEE),
            fontSize: 15,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            decorationColor: Color(0xFFEEEEEE),
          ),

         ),
          onPressed: () { },
        ),
        ),
        SizedBox(height: 10,)
      ],

    );

  }
}
