import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homey/logo/app_logo.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Places>(context,listen: false).fetchAndSetProduct().then((value) {
      // Provider.of<Favourite>(context,listen: false).fetchAndSetFav();
     Navigator.of(context).pushReplacementNamed('./tabScreen');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AppLogo(),
          ),
          SizedBox(height: 20,),
          Text('pls wait to insure the best experince you wiil have',softWrap: true,),
        ],
      ),
      floatingActionButton: CircularProgressIndicator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

