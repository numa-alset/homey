import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homey/provider/auth.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class SingUp extends StatefulWidget {




  @override
  State<SingUp> createState() => _SingUpState();
}


class _SingUpState extends State<SingUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _LogInData = {
    'name':'',
    'email': '',
    'password': '',
    'repeatPassword':'',
    'phone':'',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text('an error Ocurred',style: TextStyle(color: Colors.black87),),
          content: Text(message,style: TextStyle(color: Colors.black45),),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        ),);
  }
  void _submite()async{
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try{
      final auth =Provider.of<Auth>(context,listen: false);
      print(_LogInData);
      await auth.signup(_LogInData["name"]!, _LogInData["email"]!, _LogInData["password"]!,_LogInData["phone"]!);


      Navigator.of(context).pushNamedAndRemoveUntil('./splash',(Route<dynamic> route) => false);

      // Navigator.of(context).popAndPushNamed('./tabScreen');

    }catch(e){print(e);_showErrorDialog('pls try again');}
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body:Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(deviceSize.width*0.05, deviceSize.height*0.05,0,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: deviceSize.width*0.03),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sign up to ',
                          style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontSize: 24,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
          
                          ),
                        ),
                        TextSpan(
                          text: 'Homey',
                          style: TextStyle(
                            color: Color(0xFF00ADB5),
                            fontSize: 24,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(top: deviceSize.height*0.08),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Your Full Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),constraints: BoxConstraints(maxWidth: deviceSize.width*0.9)),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value==null||value.isEmpty ) {
                                return 'Invalid name!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _LogInData['name'] = value!;
                            },
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Your Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),constraints: BoxConstraints(maxWidth: deviceSize.width*0.9)),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value==null||value.isEmpty || !value.contains('@')) {
                                return 'Invalid email!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _LogInData['email'] = value!;
                            },
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),constraints: BoxConstraints(maxWidth: deviceSize.width*0.9)),
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value==null||value.isEmpty || value.length < 5) {
                                return 'Password is too short!';
                              }
                            },
                            onSaved: (value) {
                              _LogInData['password'] = value!;
                            },
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Confirm Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),constraints: BoxConstraints(maxWidth: deviceSize.width*0.9)),
                            obscureText: true,
                            validator: (value) {
                                  if (value != _passwordController.text) {
                                      return 'Passwords do not match!';
                                    }
                               },
                            onSaved: (value) {
                              _LogInData['repeatPassword'] = value!;
                            },
                          ),
                          SizedBox(height: 30,),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Your Phone',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),gapPadding: 10),constraints: BoxConstraints(maxWidth: deviceSize.width*0.9)),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value==null||value.isEmpty||value.substring(0,2)!='09' ) {
                                return 'Invalid Phone';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _LogInData['phone'] = value!;
                            },
                          ),
                          SizedBox(height: 30,),
                          if(_isLoading)CircularProgressIndicator()
                          else
                            Container(
                              decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(0, 173, 181, 1)),borderRadius: BorderRadius.all(Radius.circular(20))),
                              width: MediaQuery.of(context).size.width*0.9,
                              child: FloatingActionButton(onPressed: _submite,
                                  backgroundColor: Color.fromRGBO(0, 173, 181, 1),
          
                                  child: Text(
                                    'Sign up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFEEEEEE),
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600,
                                      height: 0.06,
                                      letterSpacing: 0.09,
                                    ),
                                  )
                              ),
                            ),
                        ],
                      ),
                    )
                )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
