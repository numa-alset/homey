import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homey/provider/auth.dart';
import 'package:homey/provider/chat.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class PersonalInfo extends StatefulWidget {


  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}
class _PersonalInfoState extends State<PersonalInfo> {

  @override
  void initState() {
    // TODO: implement initState
    setValues();
    super.initState();
  }
  bool legalnameread=true;
  bool genderRead=true;
  bool phoneRead=true;
  bool emailRead=true;
 late String initialLegalName;
 late String initialGender;
 late String initialPhone;
 late String initialEmail;

 bool isLoading =false;

  // image

  File? _storedImage;
  Future<void> _takeImage()async{
    final picker=ImagePicker();
    final imageFile= await picker.pickImage(source: ImageSource.camera,maxWidth: 600);
    setState(() {
      _storedImage=File(imageFile!.path);
      print(imageFile.path);Provider.of<Chat>(context,listen: false).setPic=_storedImage!;
    });
    final appDir=await syspaths.getApplicationDocumentsDirectory();
    final fileName= path.basename(imageFile!.path);
    final savedImage= await File(imageFile.path).copy('${appDir.path}/$fileName');
    final prefs = await SharedPreferences.getInstance();
       // upload image
    final prefs2 = await SharedPreferences.getInstance();
    var idUser=json.decode(prefs.getString('userData')!)["userId"];
    var cookie=json.decode(prefs.getString('userData')!)["cookie"];
    var formData = FormData.fromMap({
      "cid": idUser.toString(),
      "image": await MultipartFile.fromFile(savedImage.path),
    });

    //dio
    Dio dio = Dio();
    try {
      print(formData);
      var response = await dio.post(
        'https://dani2.pythonanywhere.com/images/profileimg/', data: formData,
        options: Options(headers: {
          "Content-Type": 'multipart/form-data',
          'Cookie': cookie,
          "Host": "dani2.pythonanywhere.com",
          "Origin": "https://dani2.pythonanywhere.com",
          "Referer": "https://dani2.pythonanywhere.com/images/profileimg/",
          "X-Csrftoken": cookie.substring(10, 42),
        }, receiveDataWhenStatusError: true,),
      );
      print(response.data);

      // _finalImages.add('https://dani2.pythonanywhere.com'+response.data["image"].toString());
    } catch (e) {
      print(e);
    }

  }

  Future<String>setimage()async{
    final prefs = await SharedPreferences.getInstance();
    var id=json.decode(prefs.getString('userData')!)["userId"];
    var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
    final response2 = await http.get(url2);
    final extractedData2 = json.decode(response2.body) as List;
    extractedData2.sort((a, b) => b['id'].compareTo(a['id']));
    return extractedData2.firstWhere((element) => element['cid'].toString()==id.toString(),orElse:() =>  {"image":"https://dani2.pythonanywhere.com/media/APP2_2_7OlhWPI.png"})["image"].toString();
  }

  Future<void> editUserName(String value ) async {
    Provider.of<Auth>(context,listen: false).setName=value;
//     final prefs = await SharedPreferences.getInstance();
//     var  userData = json.decode(prefs.getString('userData')!); // Get existing or create empty map
// print(userData);
//     userData['name'] = value; // Update the 'name' value
//     // userData['phone'] = initialPhone; // Update the 'name' value
//     // userData['email'] = initialEmail; // Update the 'name' value
//     //   print(userData);
//     // Save the updated map back to shared preferences
//     await prefs.setString('userData', json.encode(userData));
  }
  Future<void> editUserPhone(String value) async {
    Provider.of<Auth>(context,listen: false).setPhone=value.toString();
//     final prefs = await SharedPreferences.getInstance();
//     var  userData = json.decode(prefs.getString('userData')!); // Get existing or create empty map
// // print(userData);
// //     userData['name'] = initialLegalName; // Update the 'name' value
//     userData['phone'] = value; // Update the 'name' value
//     // userData['email'] = initialEmail; // Update the 'name' value
//     //   print(userData);
//     // // Save the updated map back to shared preferences
//     await prefs.setString('userData', json.encode(userData));
  }
  Future<void> editUserEmail(String value) async {
    Provider.of<Auth>(context).setEmail=value.toString();
//     final prefs = await SharedPreferences.getInstance();
//     var  userData = json.decode(prefs.getString('userData')!); // Get existing or create empty map
// // print(userData);
//     // userData['name'] = initialLegalName; // Update the 'name' value
//     // userData['phone'] = initialPhone; // Update the 'name' value
//     userData['email'] = value; // Update the 'name' value
//       // print(userData);
//     // Save the updated map back to shared preferences
//     await prefs.setString('userData', json.encode(userData));
  }
    Future<void> editUserGender(String value) async {
    final prefs = await SharedPreferences.getInstance();
    var  userData = json.decode(prefs.getString('userData')!); // Get existing or create empty map
print(userData);
    // userData['name'] = initialLegalName; // Update the 'name' value
    // userData['phone'] = initialPhone; // Update the 'name' value
    // userData['email'] = value; // Update the 'name' value
    userData['gender'] = value; // Update the 'name' value
      // print(userData);
    // Save the updated map back to shared preferences
    await prefs.setString('userData', json.encode(userData));
  }

  //..........set values
  Future<void>setValues()async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      initialLegalName= json.decode(prefs.getString('userData')!)["name"].toString();
      initialPhone= json.decode(prefs.getString('userData')!)["phone"].toString();
      initialEmail= json.decode(prefs.getString('userData')!)["email"].toString();
      initialGender =json.decode(prefs.getString('userData')!)["gender"].toString();;
    });


    // var url2=Uri.parse('https://dani2.pythonanywhere.com/images/profileimg');
    // final response2 = await http.get(url2);
    // final extractedData2 = json.decode(response2.body) as List;
    // return extractedData2.firstWhere((element) => element['cid'].toString()==id.toString())["image"].toString();
  }

  //..........

  @override
  Widget build(BuildContext context) {
   final provider= Provider.of<Auth>(context);
    return Scaffold(

      appBar: AppBar(
foregroundColor: Colors.white,
        title: Text(
          'Personal info',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Container(height:MediaQuery.of(context).size.height*0.35,
              decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white),color: Colors.white10),
                  clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            child: FutureBuilder(
                future:setimage(),
                builder:(context, snapshot) =>
                snapshot.hasData?
                    Image.network('https://dani2.pythonanywhere.com'+snapshot.data.toString(),fit:BoxFit.cover ,)
                 // NetworkImage('https://dani2.pythonanywhere.com'+snapshot.data.toString())
                    : Text('no image yet')

            ),
            // Provider.of<Chat>(context).pic !=null?
            // Image.file( Provider.of<Chat>(context).pic!,fit: BoxFit.cover,width: double.infinity,)
            //     :
            //     Text('no image yet',)
            // Image.asset('assets/images/product-placeholder.png',fit:  BoxFit.cover, ),
          ),
            TextButton.icon(onPressed: () {
                _takeImage();
            }, label: Text('add pic',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white),),
            icon: Icon(Icons.camera,color: Colors.white,),
            ),
            TextField(

            ),

            TextFormFieldBuilder(legalnameread,provider.name , TextInputType.text, 'Legal name',editUserName),
            TextFormFieldBuilder(genderRead, initialGender, TextInputType.text, 'Gender',editUserGender),
            TextFormFieldBuilder(phoneRead, provider.phone, TextInputType.number, 'Phone number',editUserPhone),
            TextFormFieldBuilder(emailRead, provider.email, TextInputType.emailAddress,'Email',editUserEmail),
             // Padding(
             //   padding: const EdgeInsets.only(top: 20),
             //   child: Row(
             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //     children:[
             //       CircleAvatar(child: Text('s'),),
             //      TextButton(onPressed: () {
             //
             //      }, child: Text(
             //        'add pic',
             //        style: TextStyle(color: Color(0xFFEEEEEE),
             //          decoration: TextDecoration.underline,
             //          decorationColor: Colors.white,
             //          fontSize: 15,
             //          height: 2,
             //          fontFamily: 'Lato',
             //          fontWeight: FontWeight.w400,),),)
             //     ]
             //   ),
             // ),

            
            

          ],
        ),
      ),
      floatingActionButton: isLoading?CircularProgressIndicator():null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
    TextFormFieldBuilder( legal,String inital,TextInputType type,String label,Function setValue) {

    return TextFormField(
      initialValue:inital,
      style: TextStyle(
        color: Color(0xEEEEEEEE),
        fontSize: 15,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(color: Color(0xEEEEEEEE),
            fontSize: 15,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,),),

        // suffix: Text('sad'),
        //     semanticCounterText: 'asd'
        suffixIcon: TextButton(onPressed: () {
          setState(() {
            legalnameread = !legal;

          });
        },
          child: Text(
            'Edit',
            style: TextStyle(color: Color(0xEEEEEEEE),
              fontSize: 15,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              height: 2,
              decorationColor: Color(0xEEEEEEEE),),),
        ),

      ),

      keyboardType: type,
      onFieldSubmitted: (value) {
        // legal = !legal;
        // print(value);
        setState(() {
          isLoading=true;
        });
        setValue(value);
       Provider.of<Auth>(context,listen: false).updateUserInfo();
        setState(() {
          legalnameread=!legal;
          isLoading=false;
          // Widget.canUpdate(oldWidget, newWidget)legal = !legal;
        });
      },
      readOnly: legalnameread,


    );
    }

}
