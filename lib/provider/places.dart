import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import '../model/place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Places with ChangeNotifier{

var placess;
  List<Place>_places=[
    // Place(id: 1 , name: 'place1', type: 'home', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 170, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: false, garden: false, parking: false, priceType: true, solarPower: false, swimmingPool: false, wifi: false,rate: 1),
    // Place(id: 2 , name: 'place2', type: 'home', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 110, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: false, garden: false, parking: false, priceType: true, solarPower: true, swimmingPool: true, wifi: false,rate: 1),
    // Place(id: 3 , name: 'place3', type: 'villa', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 11, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: false, garden: false, parking: true, priceType: false, solarPower: false, swimmingPool: false, wifi: true,rate: 1),
    // Place(id: 4 , name: 'place5', type: 'home', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 120, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: false, garden: false, parking: true, priceType: true, solarPower: true, swimmingPool: true, wifi: false,rate: 1),
    // Place(id: 5 , name: 'place5', type: 'shop', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 17, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: true, garden: false, parking: false, priceType: false, solarPower: false, swimmingPool: false, wifi: true,rate: 5),
    // Place(id: 6 , name: 'place6', type: 'home', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 103, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: true, garden: false, parking: false, priceType: true, solarPower: true, swimmingPool: true, wifi: false,rate: 5),
    // Place(id: 7 , name: 'place7', type: 'chalet', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 106, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: true, garden: false, parking: true, priceType: true, solarPower: false, swimmingPool: false, wifi: false,rate: 5),
    // Place(id: 8 , name: 'place8', type: 'shop', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 10, bathrooms:1, beds: 1, bedrooms: 1, elevator: false, furnished: true, garden: false, parking: true, priceType: false, solarPower: true, swimmingPool: true, wifi: true,rate: 3),
    // Place(id: 9 , name: 'place9', type: 'room', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 160, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: false, garden: false, parking: false, priceType: true, solarPower: false, swimmingPool: false, wifi: false,rate: 2),
    // Place(id: 10, name: 'place10', type: 'home', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 130, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: false, garden: false, parking: false, priceType: true, solarPower: true, swimmingPool: true, wifi: true,rate: 4),
    // Place(id: 11, name: 'place11', type: 'room', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 10, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: false, garden: false, parking: true, priceType: false, solarPower: false, swimmingPool: false, wifi: false,rate: 2),
    // Place(id: 12, name: 'place12', type: 'shop', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 134, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: false, garden: false, parking: true, priceType: true, solarPower: true, swimmingPool: true, wifi: true,rate: 4),
    // Place(id: 13, name: 'place13', type: 'loung', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 13, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: true, garden: false, parking: false, priceType: false, solarPower: false, swimmingPool: false, wifi: true,rate: 3),
    // Place(id: 14, name: 'place14', type: 'chalet', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 140, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: true, garden: false, parking: true, priceType: true, solarPower: true, swimmingPool: true, wifi: true,rate: 4),
    // Place(id: 15, name: 'place15', type: 'villa', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 55, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: true, garden: false, parking: true, priceType: false, solarPower: true, swimmingPool: true, wifi: true,rate: 2),
    // Place(id: 16, name: 'place16', type: 'farm', image: ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg','https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'], price: 100, bathrooms:1, beds: 1, bedrooms: 1, elevator: true, furnished: true, garden: false, parking: true, priceType: true, solarPower: true, swimmingPool: true, wifi: true,rate: 3),
   ];
  // type
  String _type='home';
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
  bool notification=false;set setNotification(bool l){notification=l;notifyListeners();}
// Constructor with auth and Id
  String authToken;
  String userId;
  Places(
      this.authToken,
      this.userId,
      this.placess
      // this._places
      );
   List<Place> get places{
     return[..._places];
   }
  List<Place>  filteredPlaces=[
    // Place(
    //     id: -1,
    //     site: '',
    //     idt: '',
    //     image: [],
    //     price: 0,
    //     n_bathroom: 0,
    //     n_bed: 0,
    //     n_room: 0,
    //     elevator: false,
    //     furntiure: false,
    //     garden: false,
    //     parking: false,
    //     type_r: '',
    //     soloar_system: false,
    //     pool: false,
    //     wifi: false,
    //     rating: 1,
    //     counter: 0,
    //     area: 0,
    //     description: '',
    //     floor: '',
    //     n_salon: 0,
    //     owner: 0,
    // )
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
       (e.n_bathroom==numBaths||numBaths==0)
       // (e.-20&&e.area>area+20)

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
    // if(times==0){fetchAndSetProduct();times++;}
   //  if(
   // !filteredPlaces.contains(Place(id: -1, name: '', type: '', image: [], price: 0, bathrooms: 0, beds: 0, bedrooms: 0, elevator: false, furnished: false, garden: false, parking: false, priceType: false, solarPower: false, swimmingPool: false, wifi: false,rate: 1))
   //  // filteredPlaces.isNotEmpty
   //  ) {
   //    // filteredPlaces=_places;
   //    if (text.isEmpty) {
   //      return filteredPlaces.where((e) => e.type == type).toList();
   //    } else {
   //      return filteredPlaces.where((element) =>
   //      element.name == text && element.type == type).toList();
   //    }
   //  }
   //  else{
   //    if (text.isEmpty) {
   //      return places.where((e) => e.type == type).toList();
   //    } else {
   //      return places.where((element) =>
   //      element.name == text && element.type == type).toList();
   //  }
   // }if (text.isEmpty) {
   //         return filteredPlaces.where((e) => e.type == type).toList();
   //       } else {
   //         return filteredPlaces.where((element) =>
   //         element.name == text && element.type == type).toList();

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

    var url=Uri.parse('https://my.api.mockaroo.com/test.json?key=2a7b2620');
    var url2=Uri.parse('image');

    // id image
    //id favourite
    // var url=Uri.https('shop-app-1f90e-default-rtdb.firebaseio.com','/products.json?auth=$authToken',);
    // http.MultipartRequest('POST', url);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      // print(extractedData[1]['id']);
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
            image: value['image'], //edite
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
            rating: value['rating'],
            owner: value['owner'],
            n_salon: value['n_salon'],
            floor: value['floor'],
            description: value['description'],
            area: double.parse(value['area'].toString()) ,
            counter: value['counter']
        )
      );
    });

    _places=loadedProducts;
    filteredPlaces=loadedProducts;
    notifyListeners();
    print('done');
    }catch(e){

      return print(e);}
    // print(json.decode(response.body));
  }

  // add place
  Future<void> addProduct(Place place) async {
    var url=Uri.parse('https://shop-app-1f90e-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    // var url=Uri.https('shop-app-1f90e-default-rtdb.firebaseio.com','/products.json?auth=$authToken',);
    try{
      final response= await http.post(url,body:json.encode({
        // 'title':product.title,
        // 'description':product.description,
        // 'imageUrl':product.imageUrl,
        // 'price':product.price,
        // 'creatorId':userId,
        // 'isFavorite':product.isFavorite,
      }) ,);
      print(json.decode(response.body));
      // final newProduct= Place(id: place.id, site: place.site, idt: place.idt, image: place.image, price: place.price, n_bathroom: place.n_bathroom, n_bed: place.n_bed, n_room: place.n_room, elevator: place.elevator, furntiure: place.furntiure, garden: place.garden, parking: place.parking, type_r: place.type_r, soloar_system: place.soloar_system, pool: place.pool, wifi: place.wifi,rating: place.rating);
      // _places.add(newProduct);

      notifyListeners();
    }
    catch (erorr){
      print(erorr);
      throw erorr;
    }
  }

// update place
  Future<void> updateProduct(String id,Place newPlace) async{
    final prdIndex= _places.indexWhere((e) => e.id==id);
    if(prdIndex>=0){
      var url=Uri.parse('https://shop-app-1f90e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      // var url=Uri.https('shop-app-1f90e-default-rtdb.firebaseio.com','/products/$id.json');
      await http.patch(url,body: json.encode({
        // 'title':newProduct.title,
        // 'description':newProduct.description,
        // 'imageUrl':newProduct.imageUrl,
        // 'price':newProduct.price,
      }),);
      _places[prdIndex]=newPlace;
      notifyListeners();
    }else{
      print('sdfsafd');
    }

  }

  // delete product
// في مشكلة
  Future<void> deleteProduct(String id)async {
    var url=Uri.parse('https://shop-app-1f90e-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex =_places.indexWhere((element) => element.id==id);
    Place? existingProduct=_places[existingProductIndex];
    _places.removeAt(existingProductIndex);
    notifyListeners();
    // _items.insert(existingProductIndex, existingProduct!);

    // _items.removeWhere((element) => element.id==id);
    // notifyListeners();
    final response=await http.delete(url);
    if (response.statusCode>=400){
      _places.insert(existingProductIndex, existingProduct!);

      // _items.removeWhere((element) => element.id==id);
      notifyListeners();
      throw Exception('could not delete product.');
    }
    existingProduct=null;
  }


}