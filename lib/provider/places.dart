import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Places with ChangeNotifier{

// var placess;
  List<Place>_places=[];
  // type
  String _type='HO';
  set setType(String type)
  {
    _type=type;
    doFilteredPlaces();
    notifyListeners();
  }
  String get type{return _type;}
  //    priceMonthly
  int _priceMonthly=0;
  set setPriceMonthly(int type){
    _priceMonthly=type;
    doFilteredPlaces();
    notifyListeners();
  }
  int get priceMonthly{
    return _priceMonthly;
  }
  //      bedroom
  int _numBedroom=0;
  int get numBedroom{
    return _numBedroom;
  }
  set setNumBedroom(int n){
    _numBedroom=n;
    doFilteredPlaces();
    notifyListeners();
  }
  bool getNumBedroom(int n){
    if(_numBedroom==n){return true;}
    else return false;
  }
  // price range
  int _minPrice=10;                                                         int _maxPrice=1000;
  int get minPrice{return _minPrice;}                                       int get maxPrice{return _maxPrice;}
  set setMinPrice(int n){_minPrice=n;doFilteredPlaces();notifyListeners();} set setMaxPrice(int n){_maxPrice=n;doFilteredPlaces();notifyListeners();}
  // beds
  int _numBeds=0;
  int get numBeds{
    return _numBeds;
  }
  set setNumBeds(int n){
    _numBeds=n;
    doFilteredPlaces();
    notifyListeners();
  }
  bool getNumBeds(int n){
    if(_numBeds==n){return true;}
    else return false;
  }
  // baths
  int _numBaths=0;
  int get numBaths{
    return _numBaths;
  }
  set setNumBaths(int n){
    _numBaths=n;
    doFilteredPlaces();
    notifyListeners();
  }
  bool getNumBaths(int n){
    if(_numBaths==n){return true;}
    else return false;
  }
  // salon
  int _numSalons=0;
  int get numSalons{
    return _numSalons;
  }
  set setNumSalons(int n){
    _numSalons=n;
    doFilteredPlaces();
    notifyListeners();
  }
  bool getNumSalons(int n){
    if(_numSalons==n){return true;}
    else return false;
  }
  // Area
  int _numArea=0;
  int get numArea{
    return _numArea;
  }
  set setNumArea(int n){
    _numArea=n;
    doFilteredPlaces();
    notifyListeners();
  }
  bool getNumArea(int n){
    if(_numArea==n){return true;}
    else return false;
  }
  // ckekats
   bool wifi=false;set setwifi(bool l){wifi=l;doFilteredPlaces();notifyListeners();}
   bool solarPower=false;set setsolar(bool l){solarPower=l;doFilteredPlaces();notifyListeners();}
   bool Parking=false;set setparking(bool l){Parking=l;doFilteredPlaces();notifyListeners();}
   bool swimmingPool=false;set setswim(bool l){swimmingPool=l;doFilteredPlaces();notifyListeners();}
   bool garden=false;set setgarden(bool l){garden=l;doFilteredPlaces();notifyListeners();}
   bool furnished=false;set setfurnished(bool l){furnished=l;doFilteredPlaces();notifyListeners();}
   bool elevator=false;set setelevator(bool l){elevator=l;doFilteredPlaces();notifyListeners();}
  // notification
  bool notification=true;set setNotification(bool l){notification=l;notifyListeners();}
  bool notification2=true;set setNotification2(bool l){notification2=l;notifyListeners();}
// Constructor with auth and Id
  String authToken;
  int userId;
  Places(
      this.authToken,
      this.userId,
      // this.placess
      // this._places
      );
   List<Place> get places{
     return[..._places];
   }
  List<Place>  filteredPlaces=[

  ];
  
  // filteredPlaces=places;
  void doFilteredPlaces() {filteredPlaces= places.where((e) {
   return (
       (e.idt==type)&&
       (e.wifi==wifi||wifi==false)&&
       (e.soloar_system==solarPower||solarPower==false)&&
       (e.pool==swimmingPool||swimmingPool==false)&&
       (e.garden==garden||garden==false)&&
       (e.furntiure==furnished||furnished==false)&&
       (e.elevator==elevator||elevator==false)&&
       (e.parking==Parking||Parking==false)&&
       (e.type_r==priceMonthly||_priceMonthly==0)&&
       e.price>=minPrice&&
       e.price<=maxPrice&&
       (e.n_room==numBedroom||numBedroom==0)&&
       (e.n_bed==numBeds||numBeds==0)&&
       (e.n_bathroom==numBaths||numBaths==0)&&
       (e.area>((numArea-1)*20+80)&&e.area<(((numArea-1)*20+80)+20)||numArea==0)
       

   );
   
  }).toList();
    
print(filteredPlaces.length);
  notifyListeners();
  }
  void unDoFilteresPlaces(){
    _numBedroom=0;
    _numBeds=0;
    _numBaths=0;
    _numSalons=0;
    _minPrice=1;
    _maxPrice=100000;
    _numArea=0;
    _priceMonthly=0;
    wifi=false;
    solarPower=false;
    Parking=false;
    swimmingPool=false;
    garden=false;
    furnished=false;
    elevator=false;
    doFilteredPlaces();
    // notifyListeners();


  }
  // find by id
  Place findById(int id){
    return _places.firstWhere((element) => element.id==id);

  }
  int times=0;
 List<Place> placesFilterByType(String type,String text){

   if (text.isEmpty) {
          return filteredPlaces.where((e) => e.idt == type).toList();
        } else {
          return filteredPlaces.where((element) =>
          element.site.toLowerCase().contains(text.toLowerCase())  && element.idt == type).toList();
        }
  }

  List<CarouselItem>  items(int id,BuildContext context) {
    List<CarouselItem> listee = [];
    Place listImage=findById(id);
    List listeIm=listImage.image;
    for (var j = 0; j < listImage.image.length; j++) {
      // print(placesFilter[i]['image'][j]);
      listee.add(
          CarouselItem(
          image: NetworkImage(listImage.image[j]),
          onImageTap: (x) =>Navigator.of(context).pushNamed('./matrial',arguments: [id,listeIm,false]as List) ,
          )
      )

      ;
    }

    if(listee.isEmpty)return [CarouselItem(image:NetworkImage('https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',), )];
    return listee;
  }
  List<Place> searchPlace (String text){
     if(text.isEmpty) {return places;}
     else{
    return places.where((element) => element.site.toLowerCase().contains(text.toLowerCase())).toList();}
    // notifyListeners();
  }
  // fetch places
  Future<void> fetchAndSetProduct()async{

    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/');
    var url2=Uri.parse('https://dani2.pythonanywhere.com/images');

    // id image
    //id favourite
    // var url=Uri.https('shop-app-1f90e-default-rtdb.firebaseio.com','/products.json?auth=$authToken',);
    // http.MultipartRequest('POST', url);
    try {
      final response = await http.get(url);
      final response2= await http.get(url2);
      final extractedData = json.decode(response.body) as List;
      final extractedData2 = json.decode(response2.body) as List;
      // print(extractedData[1]);
      // print(extractedData2[1]);
      final finalData = extractedData2.map((element) => ({
        element['pid']: element['image'], // Use pid as key, image as value
        // ... add other key-value pairs if needed from element
      })).toList();
      final finalData2 = extractedData2.fold<Map<int, List<String>>>(
        {},
            (previousData, element) {
          final pid = element['pid'];

          previousData[pid] = (previousData[pid] ?? []).toList()..add('https://dani2.pythonanywhere.com/'+element['image'].toString());
          return previousData;
        },
      );
      // print(finalData2[1]);
      final List<Place>loadedProducts = [];
      // if (extractedData == null) {
      //   return;
      // }
      var myData = extractedData; // Example data

      var hasNullValues = myData.contains((item) => item == null);
      print(hasNullValues);
    extractedData.forEach((value) {
      // print('1');
      // print(value);
      // print(value);
      loadedProducts.add(
        Place(
            id: value['id'],
            site: value['site'],
            idt: value['idt'],
            // image:['https://dani2.pythonanywhere.com/media/Screenshot_227_qrdPFji.png','https://dani2.pythonanywhere.com/media/Screenshot_227_qrdPFji.png'], //edite
            image: finalData2[value['id']]==null? ['']:finalData2[value['id']]as List<String>, //edite
            price: value['price'],
            n_bathroom: value['n_bathroom'],
            n_bed: value['n_bed'],
            n_room: value['n_room'],
            elevator: value['elevator'],
            furntiure: value['furntiure'],
            garden: value['garden'],
            parking: true,
            type_r: value['type_r']=='mounth'?1:2,
            soloar_system: value['soloar_system'],
            pool: value['pool'],
            wifi:value['wifi'],
            rating: value['rating']==null?0:value['rating'],
            owner: value['owner'],
            n_salon: value['n_salon'],
            floor: value['floor'].toString(),
            description: value['description'],
            area: double.parse(value['area'].toString()) ,
            counter: value['counter'],
            lan: value['lan'],
            lat: value['lat'],
            ratestate: value['ratestate']
        )
      );
    });
      print(loadedProducts.length);
    _places=loadedProducts;
    filteredPlaces=loadedProducts;
    notifyListeners();
    print('done');
    }catch(e){

      return print(e);}
    // print(json.decode(response.body));
  }

  // add place
  Future<void> addProduct(Map finaldata) async {
    // var url=Uri.parse('https://shop-app-1f90e-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    // var url=Uri.https('shop-app-1f90e-default-rtdb.firebaseio.com','/products.json?auth=$authToken',);
    // try{
    //   final response= await http.post(url,body:json.encode({
    //     // 'title':product.title,
    //     // 'description':product.description,
    //     // 'imageUrl':product.imageUrl,
    //     // 'price':product.price,
    //     // 'creatorId':userId,
    //     // 'isFavorite':product.isFavorite,
    //   }) ,);
    //   print(json.decode(response.body));
      // final newProduct= Place(id: place.id, site: place.site, idt: place.idt, image: place.image, price: place.price, n_bathroom: place.n_bathroom, n_bed: place.n_bed, n_room: place.n_room, elevator: place.elevator, furntiure: place.furntiure, garden: place.garden, parking: place.parking, type_r: place.type_r, soloar_system: place.soloar_system, pool: place.pool, wifi: place.wifi,rating: place.rating);
      // _places.add(newProduct);
 // _places.add(place);
    print(finaldata);

    print("number before"+_places.length.toString());

    try {
      final place = Place(id: finaldata["id"],
          counter: finaldata["counter"],
          owner: finaldata["owner"],
          site: finaldata["site"],
          description: finaldata["description"].toString(),
          floor: finaldata["floor"].toString(),
          idt: finaldata["idt"],
          area: finaldata["area"],
          n_salon: finaldata["n_salon"],
          image: finaldata["image"],
          price: finaldata["price"],
          n_bathroom: finaldata["n_bathroom"],
          n_bed: finaldata["n_bed"],
          n_room: finaldata["n_room"],
          elevator: finaldata["elevator"],
          furntiure: finaldata["furntiure"],
          garden: finaldata["garden"],
          parking: true,
          type_r: finaldata['type_r']=='mounth'?1:2,
          soloar_system: finaldata["soloar_system"],
          pool: finaldata["pool"],
          wifi: finaldata["wifi"],
          rating: 0,
          lan: finaldata["lan"],
          lat: finaldata["lat"],
          ratestate: finaldata["ratestate"]);
      print(place);
_places.add(place);

    }catch(e){print(e);}
      notifyListeners();print("number after"+_places.length.toString());
    // }
    // catch (erorr){
    //   print(erorr);
    //   throw erorr;
    // }
  }

// update place
  Future<void>updatePlace(String idp,String key,String value) async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/singlepro/$idp');
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      String idc=json.decode(prefs.getString('userData')!)["userId"].toString();

      final response = await http.put(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com",
        "Referer":"https://dani2.pythonanywhere.com/properties/singlepro/$idp",
        "X-Csrftoken":cookie.substring(10,42),
      },
          body: {
            key:value
          }

      );
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.body);
      if( key=="ratestate"){_places.firstWhere((element) => element.id.toString()==idp).ratestate=(value=='true');}
      if( key=="description"){_places.firstWhere((element) => element.id.toString()==idp).description=value;}
      if( key=="wifi"){_places.firstWhere((element) => element.id.toString()==idp).wifi=(value=='true');}
      if( key=="pool"){_places.firstWhere((element) => element.id.toString()==idp).pool=(value=='true');}
      if( key=="soloar_system"){_places.firstWhere((element) => element.id.toString()==idp).soloar_system=(value=='true');}
      if( key=="garden"){_places.firstWhere((element) => element.id.toString()==idp).garden=(value=='true');}
      if( key=="furntiure"){_places.firstWhere((element) => element.id.toString()==idp).furntiure=(value=='true');}
      if( key=="elevator"){_places.firstWhere((element) => element.id.toString()==idp).elevator=(value=='true');}
      if( key=="n_room"){_places.firstWhere((element) => element.id.toString()==idp).n_room=int.tryParse(value)!;}
      if( key=="n_bathroom"){_places.firstWhere((element) => element.id.toString()==idp).n_bathroom=int.tryParse(value)!;}
      if( key=="n_salon"){_places.firstWhere((element) => element.id.toString()==idp).n_salon=int.tryParse(value)!;}
      if( key=="n_bed"){_places.firstWhere((element) => element.id.toString()==idp).n_bed=int.tryParse(value)!;}

      // final extractedData = json.decode(response.body) ;
      // comments.add(Comment(id: extractedData["id"], date_time: extractedData["date_time"].toString(), comments: extractedData["comments"], idc: extractedData["idc"], idp: extractedData["idp"]));

      notifyListeners();
    }catch(e){print(e);}
  }

  // delete product
  Future<void>deletePlace(String id) async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/singlepro/$id');
print(id);
    _places.removeWhere((element) => element.id.toString()==id);

    // filteredPlaces.removeWhere((element) => element.id==id);
    //
    // yours.removeWhere((element) => element.id==id);
    notifyListeners();
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      String idc=json.decode(prefs.getString('userData')!)["userId"].toString();

      final response = await http.delete(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com",
        "Referer":"https://dani2.pythonanywhere.com/properties/singlepro/$id",
        "X-Csrftoken":cookie.substring(10,42),
      },


      );
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.body);

    //   // final extractedData = json.decode(response.body) ;
    //   // comments.add(Comment(id: extractedData["id"], date_time: extractedData["date_time"].toString(), comments: extractedData["comments"], idc: extractedData["idc"], idp: extractedData["idp"]));
      print('removed');

    }catch(e){print(e);}
  }

  // comment
List<Comment>comments=[];
 List<Comment>  getComments(int id){
   return comments.where((element) => element.idp==id).toList();
 }

  Future<void>fetchAndSetComments() async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/Comments');
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
      final extractedData = json.decode(response.body) ;
      final List<Comment>loadedcomments = [];
      extractedData.forEach((element) {
        loadedcomments.add(Comment(id: element["id"], date_time: element["date_time"], comments: element["comments"], idc: element["idc"], idp: element["idp"]));
      });
      comments=loadedcomments;
      notifyListeners();
    }catch(e){print(e);}
  }
 Future<void>addComment(String idp,String comment) async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/Comments/com/');
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      String idc=json.decode(prefs.getString('userData')!)["userId"].toString();
      print(idc);
      print(idp);
      print(comment);
      final response = await http.post(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com",
        "Referer":"https://dani2.pythonanywhere.com/Comment/com/",
        "X-Csrftoken":cookie.substring(10,42),
      },
      body: {
        "comments":comment,
        "idc":idc,
        "idp":idp,
      }

      );
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.body);
      // final extractedData = json.decode(response.body) ;
      // comments.add(Comment(id: extractedData["id"], date_time: extractedData["date_time"].toString(), comments: extractedData["comments"], idc: extractedData["idc"], idp: extractedData["idp"]));

      notifyListeners();
    }catch(e){print(e);}
  }
  Future<void>deleteComment(String id) async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/Comments/com/$id');
    print(id);
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      String idc=json.decode(prefs.getString('userData')!)["userId"].toString();

      final response = await http.delete(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com",
        "Referer":"https://dani2.pythonanywhere.com/Comment/com/$id",
        "X-Csrftoken":cookie.substring(10,42),
      },


      );
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.body);
      // final extractedData = json.decode(response.body) ;
      // comments.add(Comment(id: extractedData["id"], date_time: extractedData["date_time"].toString(), comments: extractedData["comments"], idc: extractedData["idc"], idp: extractedData["idp"]));

      notifyListeners();
    }catch(e){print(e);}
  }
List<Your> yours=[];
  Future<void>fetchAndSetYours() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie=json.decode(prefs.getString('userData')!)["cookie"];
    String id=json.decode(prefs.getString('userData')!)["userId"].toString();
    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/$id');
    try{
      // print(findById(15).image);
      final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
      final extractedData = json.decode(response.body) ;
      final List<Your>loadedyours = [];
      extractedData.forEach((element) {

      loadedyours.add(Your(id: element["id"], name: element["site"].toString(), price:element['price'] , rate: element["rate"].toString(), ownerid: element["owner"],ratestate: element["ratestate"],images: findById(element["id"]).image));
      });
      yours=loadedyours;
      print(yours[0].images);

      notifyListeners();
    }catch(e){print(e);}
  }
  List<OwnerPlace>ownerPlaces=[];
  Future<void>fetchAndSetOwnerPlaces(int ownerid) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie=json.decode(prefs.getString('userData')!)["cookie"];
    String id=json.decode(prefs.getString('userData')!)["userId"].toString();
    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/$ownerid');
    try{

      final response = await http.get(url,headers: {'Cookie': cookie,"Host":"dani2.pythonanywhere.com"});
      final extractedData = json.decode(response.body) ;
      final List<OwnerPlace>loadedyours = [];
      extractedData.forEach((element) {

      loadedyours.add(
          OwnerPlace(id: element["id"], name: element["site"], price: element["price"], rate: element["rate"].toString(), ownerid: element["owner"], images: findById(element["id"]).image));
          });
      ownerPlaces=loadedyours;

      notifyListeners();
    }catch(e){print(e);}
  }


}
class Comment{

 final int id;
 final String date_time;
 final String comments;
 final int idc;
 final int idp;
 Comment({
   required this.id,
   required this.date_time,
   required this.comments,
   required this.idc,
   required this.idp,
});

}
class Your{
  int id;
  String name;
  int price;
  String rate;
  int ownerid;
  bool ratestate;
  List images;
  Your(
  {
    required this.id,
    required this.name,
    required this.price,
    required this.rate,
    required this.ownerid,
    required this.ratestate,
    required this.images,
}
      );

}
class OwnerPlace{
  int id;
  String name;
  int price;
  String rate;
  int ownerid;
  List images;
  OwnerPlace(
  {
    required this.id,
    required this.name,
    required this.price,
    required this.rate,
    required this.ownerid,

    required this.images,
}
      );

}