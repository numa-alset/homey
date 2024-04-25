import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homey/provider/chat.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}
class _PersonalInfoState extends State<PersonalInfo> {

  bool legalnameread=true;
  bool genderRead=true;
  bool phoneRead=true;
  bool emailRead=true;
  String initialLegalName='miechel';
  String initialGender='male';
  String initialPhone='9845234';
  String initialEmail='miechel@gmail.com';

  // image

  File? _storedImage;
  Future<void> _takeImage()async{
    final picker=ImagePicker();
    final imageFile= await picker.pickImage(source: ImageSource.camera,maxWidth: 600);
    setState(() {
      _storedImage=File(imageFile!.path);
      print(imageFile!.path);Provider.of<Chat>(context,listen: false).setPic=_storedImage!;
    });
    final appDir=await syspaths.getApplicationDocumentsDirectory();
    final fileName= path.basename(imageFile!.path);
    final savedImage= await File(imageFile!.path).copy('${appDir.path}/$fileName');

  }

  //...............
  @override
  Widget build(BuildContext context) {
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
            child:  Provider.of<Chat>(context).pic !=null?
            Image.file( Provider.of<Chat>(context).pic!,fit: BoxFit.cover,width: double.infinity,)
                :
                Text('no image yet',)
            // Image.asset('assets/images/product-placeholder.png',fit:  BoxFit.cover, ),
          ),
            TextButton.icon(onPressed: () {
                _takeImage();
            }, label: Text('add pic',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white),),
            icon: Icon(Icons.camera,color: Colors.white,),
            ),
            TextFormFieldBuilder(legalnameread,initialLegalName , TextInputType.text, 'Legal name'),
            TextFormFieldBuilder(genderRead, initialGender, TextInputType.text, 'Gender'),
            TextFormFieldBuilder(phoneRead, initialPhone, TextInputType.number, 'Phone number'),
            TextFormFieldBuilder(emailRead, initialEmail, TextInputType.emailAddress,'Email'),
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
    );
  }
    TextFormFieldBuilder( legal,String inital,TextInputType type,String label) {
    return TextFormField(
      initialValue: inital,
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
        print(value);
        setState(() {
          legalnameread=!legal;
          // Widget.canUpdate(oldWidget, newWidget)legal = !legal;
        });
      },
      readOnly: legalnameread,

    );
    }

}
