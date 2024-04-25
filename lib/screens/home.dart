
import 'package:flutter/material.dart';
import 'package:homey/provider/favorite.dart';

import 'package:homey/widgets/home_item.dart';
import 'package:provider/provider.dart';
import '../provider/places.dart';
enum HomeType {
  home,
  shop,
  lounge,
  room,
  chalet,
  villa,
  farm,
}
String  retype(int x){
  if(x==0)return 'home';
  if(x==1)return 'shop';
  if(x==2)return 'lounge';
  if(x==3)return 'room';
  if(x==4)return 'chalet';
  if(x==5)return 'villa';
  if(x==6)return 'farm';
  else return'home';
}
class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> with TickerProviderStateMixin {

bool isLoading=false;
late final TabController _controller;
@override
  void initState() {

  // setState(() {
  //   isLoading=true;
  // });
  // // Provider.of<Favourite>(context,listen: false).fetchAndSetFav();
  //
  // Provider.of<Places>(context,listen: false).fetchAndSetProduct().then((value) {setState(() {
  //   isLoading=false;
  //
  // });});

  // TODO: implement initState
  _controller = TabController(length: 7, vsync: this);
  _controller.addListener(() {
    print("Selected Index: " + _controller.index.toString());
    if(!_controller.indexIsChanging){print('changed');
    Provider.of<Places>(context,listen: false).setType=retype(_controller.index);
    Provider.of<Places>(context,listen: false).unDoFilteresPlaces();
    print(Provider.of<Places>(context,listen: false).type);
    }
  });

  super.initState();
  }
void dispose() {
  _controller.dispose();
  super.dispose();
}
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   Provider.of<Places>(context).fetchAndSetProduct();
  //   super.didChangeDependencies();
  // }
 String textSearch='';
// List<Map> get PlacesFilter{
//   if(textSearch==null||textSearch!.isEmpty)return Places;
//   else return Places.where((element) => element['name']==textSearch).toList();
// }
 final _searchControler=TextEditingController();

 void  _search(String? text)  {
     if(text ==null || text.isEmpty){
       setState(() {
         textSearch='';
       });
     }
     else{
        setState(() {
          textSearch=_searchControler.text;
        });
     }
  }

  void _filter(){
   Provider.of<Places>(context,listen: false).doFilteredPlaces();
    Navigator.of(context).pushNamed('./filters');
  }



  @override
  Widget build(BuildContext context) {


 var providerPlaces=  Provider.of<Places>(context);
    final deviceSize = MediaQuery.of(context).size;
  return DefaultTabController(
    length: 7,
    initialIndex: 0,
    child: Scaffold(

      body: NestedScrollView(
        headerSliverBuilder:(context, innerBoxIsScrolled) {return [ SliverAppBar(
            actions: [ Padding(
            padding:  EdgeInsets.fromLTRB(deviceSize.width*0.05,0,deviceSize.width*0.05,0),
            child: Container(

                                    child: Row(

                                      children: [TextField(
                                        decoration: InputDecoration(constraints: BoxConstraints(maxWidth: deviceSize.width*0.7),
                                          icon: IconButton(icon: Icon(Icons.search),onPressed: () {
                                            _search(_searchControler.text);
                                          },),
                                          hintText: 'where to',

                                          // labelText: 'where to',
                                        ),
                                        // expands: true,
                                        style:TextStyle(color: Colors.black),
                                        controller: _searchControler,
                                        onChanged: (value) {
                                          _search(value);
                                        },
                                      ),
                                        IconButton(onPressed: _filter, icon: Icon(Icons.filter_alt_off_outlined))
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    ),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    // padding: EdgeInsets.only(right: 0),
                                    width: deviceSize.width*0.9,

                                  ),
            ),],
          pinned: true,
          floating: true,
          // elevation: 1,
          bottom: TabBar(
controller: _controller,
            tabs: [
            Tab(icon: Icon(Icons.home),text:'Home',),
                  Tab(icon: Icon(Icons.store),text: 'shop',),
            Tab(icon: Icon(Icons.chair),text: 'loung',),
                  Tab(icon: Icon(Icons.door_sliding),text: 'room',),
            Tab(icon: Icon(Icons.chalet),text: 'chalet',),
                  Tab(icon: Icon(Icons.villa),text: 'villa',),
                  Tab(icon: Icon(Icons.holiday_village),text: 'farm',),
          ],
        unselectedLabelColor: Colors.white,
            labelPadding: EdgeInsets.symmetric(horizontal: 1),
              labelColor: Color.fromRGBO(0, 173, 181, 1),

          ),

        ),
        ];
        },

      body: isLoading?Center(child: CircularProgressIndicator()):TabBarView(
        controller: _controller,
        children: [
        HomeItem(id: 1, name: 'asd', type: 'home',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'shop',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'loung',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'room',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'chalet',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'villa',text:textSearch),
        HomeItem(id: 1, name: 'asd', type: 'farm',text:textSearch),
      ],


      ),
    ),
    ),
  );
  }
}
