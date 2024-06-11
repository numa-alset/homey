import 'package:flutter/material.dart';
import 'package:homey/logo/app_logo.dart';
import 'package:homey/provider/auth.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/provider/favorite.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/screens/filters.dart';
import 'package:homey/screens/home.dart';
import 'package:homey/screens/list_your_place.dart';
import 'package:homey/screens/log_in.dart';
import 'package:homey/screens/login_and_security.dart';
import 'package:homey/screens/map.dart';
import 'package:homey/screens/open_app.dart';
import 'package:homey/screens/place_detail.dart';
import 'package:homey/screens/sign_up.dart';
import 'package:homey/screens/tab_screens.dart';
import 'package:homey/screens/your_places.dart';
import 'package:provider/provider.dart';
import './screens/personal_info.dart';
import './splash/splash.dart';

void main() {
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth(),),
        ChangeNotifierProxyProvider<Auth,Places>(create:(_)=>Places('',0) , update: (_, auth, previous) => Places(auth.token==null?'':auth.token!,auth.userId==null?0:auth.userId!),),
        ChangeNotifierProxyProvider<Auth,Favourite>(create:(_)=>Favourite(0) , update: (_, auth, previous) => Favourite(auth.userId==null?0:auth.userId!),),
        ChangeNotifierProxyProvider<Auth,Chat>(create:(_)=>Chat(0) , update: (_, auth, previous) => Chat(auth.userId==null?0:auth.userId!),),


        // ChangeNotifierProvider(create: (_) => Places()),
      ],
      child: Consumer<Auth>(

        builder: (context, auth, _) =>  MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 173, 181, 1)),
            useMaterial3: true,
            scaffoldBackgroundColor: Color.fromRGBO(34, 40, 49, 1),
            textTheme: Typography.whiteHelsinki,
            primaryTextTheme: Typography.whiteHelsinki,
              appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(34, 40, 49, 1),titleTextStyle: TextStyle(color: Colors.white)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor:Color.fromRGBO(57, 62, 70, 1), ),
          ),
          home:
          // auth.isAuth?TabsScreen()  :FutureBuilder(future: auth.tryAutoLogin(), builder: (context, snapshot) =>snapshot.connectionState==ConnectionState.waiting? SplashWaiting(): OpenApp(),),
          OpenApp(),
            routes: {
            './tabScreen':(context) => TabsScreen(),
            './matrial':(context) => PlaceDetail(),
              './filters':(context) => Filters(),
              './personalInfo':(context) => PersonalInfo(),
              './logInAndSecurity':(context) =>LogInAndSecurity(),
              './listYourPlace':(context) => ListYourPlace(),
              './yourPlaces':(context) => YourPlaces(),
              './logIn':(context) => LogIn(),
              './signUp':(context) => SingUp(),
              './map':(context) => FullMap(),
              './splash':(context) => Splash(),
            },
            ),
      ),
    );



  }
}
