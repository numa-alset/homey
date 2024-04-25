import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:homey/provider/chat.dart';
import 'package:homey/provider/favorite.dart';
import 'package:homey/widgets/circle_number.dart';
import '../screens/map2.dart'as map2;
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class PlaceDetail extends StatefulWidget {

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {


 List <CarouselItem> crItem(List image){
   List<CarouselItem> listee=[];
    for(int i=0;i<image.length;i++){
     listee.add(CarouselItem(image:NetworkImage(image[i]) ));
   }
    return listee;
   //  return image.forEach((element) {CarouselItem(image: NetworkImage(image[element]));})as List<CarouselItem>;
 }bool isLodaing=false;
 final _controlerTex=TextEditingController();String commentValue='';
  @override
  Widget build(BuildContext context) {


    var args=ModalRoute.of(context)!.settings.arguments as List;
   final int id=args[0];
   final List image=args[1];
   final bool update=true;
   //args[2];


    // print(args);
    final place= Provider.of<Places>(context).findById(id);
    final chat=Provider.of<Chat>(context);
   Future<void> goToChat()async{

    }
    TextEditingController DescriptionController = new TextEditingController();
    int numBedroom=place.n_room;
    bool getNumBedroom(int n){return numBedroom==n;}
    // ...............
    int numBed=place.n_bed;
    bool getNumBed(int n){return numBed==n;}
    // ................
    int numBathroom=place.n_bathroom;
    bool getNumBathroom(int n){return numBathroom==n;}
    // ................
    int numSalon=place.n_salon;
    bool getNumSalon(int n){return numSalon==n;}
    // ................
    return  Scaffold(

      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('\$${place.price} ${place.type_r==2?'Day':'Month'}', style: TextStyle18) ,
           isLodaing? CircularProgressIndicator():ElevatedButton(onPressed: () {
              goToChat();
            },
             child: Text('Send message', textAlign: TextAlign.center, style: TextStyle18),
             style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF00ADB5))),
           )
          ],
        )
      ],

      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                    header: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        Consumer<Favourite>(

                          builder: (context, fav, child) =>  IconButton(icon: fav.isFav(id)? Icon(Icons.favorite_outlined,color: Colors.yellow[400]):Icon(Icons.favorite_outline,color: Colors.yellow[100]),
                            onPressed: () {
                              fav.isFav(id)?fav.deleteFav(id):fav.addFav(id);

                            },
                          ),
                        ),
                      ],),
                    ),
                    child: CustomCarouselSlider(items: crItem(image),autoplay: false,showSubBackground: false,),

                footer: GridTileBar(
                  title: Text(''),
                  leading:Text('') ,
                  trailing:Text('') ,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              place.site, style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 24, fontFamily: 'Lato', fontWeight: FontWeight.w600,),
            ),
            subtitle: Text(place.rating.toString(), style: TextStyle15,),
            trailing: isLodaing?CircularProgressIndicator() :Container(width: MediaQuery.of(context).size.width*0.3,
              child:ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF00ADB5))),
                  onPressed: () async{
                    Location location = new Location();
                    setState(() {
                      isLodaing=true;
                    });
                  var  _locationData = await location.getLocation();
                  setState(() {
                    isLodaing=false;
                  });
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => map2.MyApp(_locationData.latitude,_locationData.longitude,),));
                    // Navigator.of(context).pushNamed('./map', arguments: [34.729,36.713]);
              }, child: Row( children: [Expanded(child: Icon(Icons.map,color: Colors.white,),),Expanded(child: Text('map',style: TextStyle(color: Colors.white),))],)),
            ),
          ),

          // Divider
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Divider(),),

          // Description
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('Description:', style: TextStyle20),),

          // Place Description
          // !update?
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('${place.description}',softWrap: true,maxLines: 2, style: TextStyle15,),),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(controller:DescriptionController ,

              decoration: InputDecoration(

                labelText: 'set the new des',
                enabledBorder: InputBorder.none,
                hintText: 'hint text',
                suffixIcon: Icon(Icons.edit),
              ),
                onSubmitted: (value) => place.description=value,
              ),
              ),

          // Divider
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10), child: Divider(),),

          // what this place offer
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('What this place offers', style: TextStyle20),),

       update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Wifi', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.wifi, onChanged: (value) => setState(() {place.wifi=value as bool;}),)],))
           :place.wifi?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Wifi', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.wifi,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
       update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('SwimPool', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.pool, onChanged: (value) => setState(() {place.pool=value as bool;}),)],))
           :place.pool?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('SwimPool', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.pool,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
          update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('SolarPower', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.soloar_system, onChanged: (value) => setState(() {place.soloar_system=value as bool;}),)],))
              :place.soloar_system?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('SolarPower', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.solar_power,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
          update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Parking', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.parking, onChanged: (value) => setState(() {place.parking=value as bool;}),)],))
          :place.parking?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Parking', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.garage,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
          update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Garden', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.garden, onChanged: (value) => setState(() {place.garden=value as bool;}),)],))
          :place.garden?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Garden', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.park_outlined,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
          update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Furnished', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.furntiure, onChanged: (value) => setState(() {place.furntiure=value as bool;}),)],))
          :place.furntiure?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Furnished', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.chair,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),
          update?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Elevator', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Checkbox(value: place.elevator, onChanged: (value) => setState(() {place.elevator=value as bool;}),)],))
          :place.elevator?Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 9),child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Elevator', style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,),),Icon(Icons.elevator,color: Colors.white,)],)):Padding(padding: EdgeInsets.zero),

          //Divider
          Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10,),child: Divider(),),

         // update isME
          update? Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text('Update my place', style: TextStyle20),):SizedBox(),
          update?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text('rooms', style: TextStyle18),),
      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
      children: [CircleNumber(context, 'any'), CircleNumber(context, '1'), CircleNumber(context, '2'), CircleNumber(context, '3'), CircleNumber(context, '4'), CircleNumber(context, '5'),],
      borderRadius: BorderRadius.circular(10),
      fillColor: Color.fromRGBO(0, 173, 181, 1),
      selectedColor: Color.fromRGBO(0, 173, 181, 1),
      constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
      isSelected: [getNumBedroom(0),getNumBedroom(1),getNumBedroom(2),getNumBedroom(3),getNumBedroom(4),getNumBedroom(5)],
        onPressed: (index) {setState(() {numBedroom=index;place.n_room=index;});},
      ),),
      Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text('Beds', style: TextStyle18),),
      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
      children: [CircleNumber(context, 'any'), CircleNumber(context, '1'), CircleNumber(context, '2'), CircleNumber(context, '3'), CircleNumber(context, '4'), CircleNumber(context, '5'),],
      borderRadius: BorderRadius.circular(10),
      fillColor: Color.fromRGBO(0, 173, 181, 1),
      selectedColor: Color.fromRGBO(0, 173, 181, 1),
      constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
      isSelected: [getNumBed(0),getNumBed(1),getNumBed(2),getNumBed(3),getNumBed(4),getNumBed(5)],
      onPressed: (index) {setState(() {numBed=index;place.n_bed=index;});},
      ),),
      Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text('Bathrooms', style:TextStyle18),),
      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
      children: [CircleNumber(context, 'any'), CircleNumber(context, '1'), CircleNumber(context, '2'), CircleNumber(context, '3'), CircleNumber(context, '4'), CircleNumber(context, '5'),],
      borderRadius: BorderRadius.circular(10),
      fillColor: Color.fromRGBO(0, 173, 181, 1),
      selectedColor: Color.fromRGBO(0, 173, 181, 1),
      constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
      isSelected: [getNumBathroom(0),getNumBathroom(1),getNumBathroom(2),getNumBathroom(3),getNumBathroom(4),getNumBathroom(5)],
      onPressed: (index) {setState(() {numBathroom=index;place.n_bathroom=index;});},),),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text('Salons', style:TextStyle18),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              children: [CircleNumber(context, 'any'), CircleNumber(context, '1'), CircleNumber(context, '2'), CircleNumber(context, '3'), CircleNumber(context, '4'), CircleNumber(context, '5'),],
              borderRadius: BorderRadius.circular(10),
              fillColor: Color.fromRGBO(0, 173, 181, 1),
              selectedColor: Color.fromRGBO(0, 173, 181, 1),
              constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
              isSelected: [getNumSalon(0),getNumSalon(1),getNumSalon(2),getNumSalon(3),getNumSalon(4),getNumSalon(5)],
              onPressed: (index) {setState(() {numBathroom=index;place.n_salon=index;});},),),
        ],
      ),
    )
              : SizedBox(),
          update? Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10,),child: Divider(),):SizedBox(),
         // Rating and reviews
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text('Rating & reviews:', style: TextStyle20),),

         update? SizedBox():ListTile(
          leading: CircleAvatar(child: Text(place.site.substring(0,1)),),
            title: TextField(

              controller: _controlerTex,
              onChanged: (value) => setState(() {
                commentValue=value;
              }),
            ),
            trailing: ElevatedButton(onPressed: () {
              print(commentValue);
              setState(() {
                _controlerTex.clear();
              });
            }, child: Text('comment',style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF00ADB5))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Container(height: 200,
              child: ListView(
                children: [
                  Text('Future Builder for comments'),
                  Text('Future Builder for comments'),
                  Text('Future Builder for comments'),
                  Text('Future Builder for comments'),
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
  static const TextStyle18=TextStyle(color: Color(0xFFEEEEEE), fontSize: 18, fontFamily: 'Lato', fontWeight: FontWeight.w400,);
  static const TextStyle20=TextStyle(color: Color(0xFFEEEEEE), fontSize: 20, fontFamily: 'Lato', fontWeight: FontWeight.w600,);
  static const TextStyle15=TextStyle(color: Color(0xFFEEEEEE), fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w300,);


}
