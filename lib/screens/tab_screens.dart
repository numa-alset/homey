import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/screens/home.dart';
import 'package:homey/screens/inbox.dart';
import 'package:homey/screens/liked.dart';
import 'package:homey/screens/profile.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  late List<Map<String,Object>>_page ;
  @override
  void initState() {
    // TODO: implement initState
    _page=[
      {'page':Home(),'title':'home'},
      {'page':Liked(),'title':'Liked'},
      {'page':Inbox(),'title':'Inbox'},
      {'page':Profile(),'title':'Profile'},

    ];
    super.initState();
  }
  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {

    final deviceSize=MediaQuery.of(context).size;
    // return DefaultTabController(length: 2,initialIndex: 0,animationDuration: Duration(seconds: 1), child: Scaffold(
    //   appBar: AppBar(
    //     title: Text('Meals'),
    //     bottom: TabBar(tabs: [
    //       Tab(icon: Icon(Icons.category),text:'categories' ,),
    //       Tab(icon: Icon(Icons.star),text: 'Favourite',),
    //     ]),
    //   ),
    //   body: TabBarView(
    //
    //       children: [
    //     CategoriesScreen(),FavouriteScreen(),
    //   ]),
    // )
    // );
    return Scaffold(
      appBar:(_page[_selectedPageIndex]['title']=='home')?null
    //   AppBar(
    //     actions: [Container(
    //
    //   child: Row(
    //
    //   children: [TextField(
    //   decoration: InputDecoration(constraints: BoxConstraints(maxWidth: deviceSize.width*0.7),
    //   icon: IconButton(icon: Icon(Icons.search),onPressed: null),
    //   hintText: 'where to',
    //   // labelText: 'where to',
    // ),
    // // expands: true,
    // style:TextStyle(color: Colors.black),
    // ),
    // IconButton(onPressed: null, icon: Icon(Icons.filter_alt_off_outlined))
    // ],
    // mainAxisAlignment: MainAxisAlignment.spaceAround,
    // ),decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(10),color: Colors.white),
    // width: deviceSize.width*0.9,
    //
    // ),],
    //     bottom: TabBar(tabs: tabs),
    //
    //   )
          :AppBar(
         title: Text(_page[_selectedPageIndex]['title']as String,style: TextStyle(
           color: Color(0xEEEEEEEE),
           fontSize: 30,
           fontFamily: 'Lato',
           fontWeight: FontWeight.w700,
         ),),

      ),

      body: _page[_selectedPageIndex]['page']as Widget,
      extendBody: true,

      bottomNavigationBar: BottomNavigationBar(

        onTap:_selectPage ,

unselectedItemColor: Colors.white,
        items: [BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Explore',),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'Liked'),
          BottomNavigationBarItem(

              icon: Stack(children: [Icon(Icons.chat_bubble_outline, ),
             Provider.of<Places>(context).notification?

             StreamBuilder(
               stream: Stream.empty(),
               builder: (context, snapshot) {
                 return (snapshot.hasData)?Icon(Icons.circle,color: Colors.redAccent,size: 10,):SizedBox();
               }
             )

                 :SizedBox()
              ]),label: 'Inbox'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: 'Profile'),

        ],selectedItemColor: Color(0xFF00ADB5),
        // backgroundColor: Theme.of(context).primaryColor,
        // unselectedItemColor: Colors.white,
        // selectedItemColor: Colors.yellowAccent,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,


      ),
    );
  }
}
