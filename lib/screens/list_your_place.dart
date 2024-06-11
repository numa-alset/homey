
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:homey/model/place.dart';
import 'package:homey/provider/places.dart';
import 'dart:convert';
import 'package:homey/widgets/map_select.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:location/location.dart';
import 'package:ripple_button/ripple_button.dart';
import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:homey/widgets/circle_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListYourPlace extends StatefulWidget {
  const ListYourPlace({super.key});

  @override
  State<ListYourPlace> createState() => _ListYourPlaceState();
}

class _ListYourPlaceState extends State<ListYourPlace> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole = 'Writer';
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  int idUser=0;
  bool isLoading=false;
  bool isSubmitingImages=false;
  int indexImage=0;
  Map<String, String> _ListData = {
    'idt':'',
    'description':'s',
    'price': '',
    'area': '',
    'site':'Homs',
    'lan':'0.0',
    'lat':'0.0',
    'n_bathroom':'0',
    'n_room':'0',
    'type_r':'monthly',
    'floor':'first',
    'n_bed':'0',
    'n_salon':'0',
    'furntiure':'false',
    'wifi':'false',
    'garden':'false',
    'pool':'false',
    'elevator':'false',
    'soloar_system':'false',
    'owner':'',
      'counter':'0',
    'rate':'0',
    'counters':'0',
    'count':'0'


  };
  List<String> _finalImages=[];
  Map _finaldata={};
  // .............
  bool mounthly=true;
  // ...............
  int numBedroom=0;
  bool getNumBedroom(int n){return numBedroom==n;}
  // ...............
  int numBed=0;
  bool getNumBed(int n){return numBed==n;}
  // ................
  int numBathroom=0;
  bool getNumBathroom(int n){return numBathroom==n;}
  // ................
  int numSalon=0;
  bool getNumSalon(int n){return numSalon==n;}
  //.................
  bool wifi=false;
  bool solarPower=false;
  bool garden=false;
  bool parking=false;
  bool swimmingpool=false;
  bool furnished=false;
  bool elevator=false;
  // ................
  bool isLocating=false;
  bool isFinished=false;
// Future<void> _addLocation()async{
//   setState(() {
//     isLocating=true;
//   });

  // final locData= await Location().getLocation();
  // setState(() {
  //   _ListData['lanlat']=[locData.longitude,locData.latitude];
  //   isLocating=false;isFinished=true;
  // });

//   print(_ListData['lanlat']);
// }


// ............ image
  List<File> selectedImages = [];

// ................
 Future<void>  _submit()async{
    var url=Uri.parse('https://dani2.pythonanywhere.com/properties/post/');
    try{

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String id=(json.decode(prefs.getString('userData')!)["userId"]).toString();
      print('id'+id.toString());
      _ListData["owner"]=id;
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      // final response =
      print('we r sent');
      print(_ListData);
      final response =await http.post(url,headers: {'Cookie': cookie,
        "Host":"dani2.pythonanywhere.com",
        "Origin":"https://dani2.pythonanywhere.com",
        "Referer":"https://dani2.pythonanywhere.com/properties/post/",
        "X-Csrftoken":cookie.substring(10,42),
      },
          body: _ListData
      );
      print(response.body);
      print('done');
      print(json.decode(response.body));
      _finaldata=json.decode(response.body);
      idUser=json.decode(response.body)["id"];
    }catch(e){print(e);
    print('notdone');
    }
    setState(() {
      isLoading=false;

    });


  }
  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Start with Type and location',
        subtitle: 'Add a meaningful type for your place and provide you location',
        alignment: Alignment.topCenter,
        content:
        Column(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),

                child:
                  DropdownMenu(
                    onSelected: (value) {_ListData['idt']=value.toString();
                      print(_ListData['idt']);
                      },

                    hintText: 'your type',
                    width: MediaQuery.of(context).size.width*0.8,
inputDecorationTheme:

InputDecorationTheme(
  labelStyle: TextStyle(color: Colors.white),
hintStyle: TextStyle(color: Colors.white),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

),
                    dropdownMenuEntries: [
              DropdownMenuEntry(value: 'HO', label: 'Home'),
              DropdownMenuEntry(value: 'SH', label: 'Shop'),
              DropdownMenuEntry(value: 'LO', label: 'Lounge'),
              DropdownMenuEntry(value: 'CH', label: 'Chalet'),
              DropdownMenuEntry(value: 'VI', label: 'Villa'),
              DropdownMenuEntry(value: 'FA', label: 'Farm')
                  ],
                  )
                // TextSelectionToolbar(anchorAbove: Offset.infinite, anchorBelow: Offset.infinite,
                //     children:[
                //       Text('data1'),
                //     ],
                //
                //
                // )
          // TextField(
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          //           label: Text('Your place name',style: TextStyle(color: Colors.white),),
          //
          //         ),
          //         onSubmitted: (value) {setState(() {
          //           _ListData['name'] = value;
          //         });
          //
          //         },
          //
          //       ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                child: ElevatedButton(onPressed: () {
                  // _addLocation();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapSelect(),)).then((value) {
                    _ListData['lat']=value[0];
                    _ListData['lan']=value[1];
                    _ListData['site']=value[2];
                    setState(() {
                      isFinished=true;
                    });
                    print(_ListData['site']);
                  });

                },
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map),Text(
                      'Add location',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEEEEEE),
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 173, 181, 1),),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  ),

                ),
              ),
            isLocating?Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ):Padding(padding: EdgeInsets.all(0)),
            isFinished?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.check_circle,color: Colors.green,),
            ):Padding(padding: EdgeInsets.all(0))
          ],
        ),
        validation: () {
        //   if (_ListData['site']=='') {
        //     return 'please add ur location';
        //   }
          return null;
        },

      ),
      CoolStep(
        title: 'Now to set your own price',
        subtitle: 'input a number for your price and choose if u want it daily or per month',
        alignment: Alignment.topCenter,
        content: Column(
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    label: Text('Your price for the place',style: TextStyle(color: Colors.white),),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    setState(() {
                      _ListData['price'] = value.toString();
                    });

                  },
                ),
          ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ToggleButtons(
                  constraints: BoxConstraints.expand(width:MediaQuery.of(context).size.width*0.3,height: MediaQuery.of(context).size.height*0.1 ,),

                  borderRadius: BorderRadius.circular(10) ,
                  borderColor:Color.fromRGBO(0, 173, 181, 1) ,
                  borderWidth: 2,
                  renderBorder: true,
                  fillColor: Color.fromRGBO(0, 173, 181, 1),
                  selectedColor: Color.fromRGBO(0, 173, 181, 1),
                  selectedBorderColor:Color.fromRGBO(0, 173, 181, 1) ,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(1),
                      child: Text(
                        'Price monthly',
                        style: TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(1),
                      child: Text(
                        'Price daily',
                        style: TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    )
                  ], isSelected: [mounthly,!mounthly],
                  onPressed: (index) {
                    if(index==0){setState(() {
                      mounthly=true;
                    }); }
                    if(index==1){setState(() {
                      mounthly=false;
                    }); }
                    _ListData['type_r']=mounthly?'monthly':'daily';
                  },
                ),
              ),
          ],
        ),
        validation: () {
          if (_ListData['price']=='') {
            return 'add price';
          }
          return null;
        },
        // Container(
        //   child: Row(
        //     children: <Widget>[
        //       _buildSelector(
        //         context: context,
        //         name: 'Writer',
        //       ),
        //       SizedBox(width: 5.0),
        //       _buildSelector(
        //         context: context,
        //         name: 'Editor',
        //       ),
        //     ],
        //   ),
        // ),
      ),
      CoolStep(
        title: 'Now for Basics',
          subtitle: 'add the number of each you have from bedrooms , beds, and baths',
          content: Column(children: [ Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'rooms',
                  style: TextStyle(
                    color: Color(0x99EEEEEE),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  children: [
                    CircleNumber(context, 'any'),
                    CircleNumber(context, '1'),
                    CircleNumber(context, '2'),
                    CircleNumber(context, '3'),
                    CircleNumber(context, '4'),
                    CircleNumber(context, '5'),
                  ],
                  borderRadius: BorderRadius.circular(10),

                  fillColor: Color.fromRGBO(0, 173, 181, 1),
                  selectedColor: Color.fromRGBO(0, 173, 181, 1),
                  constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
                  isSelected: [getNumBedroom(0),getNumBedroom(1),getNumBedroom(2),getNumBedroom(3),getNumBedroom(4),getNumBedroom(5)],

                  onPressed: (index) {
                    setState(() {
                      numBedroom=index;
                      _ListData['n_room']=numBedroom.toString();
                    });
                  },

                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Salons',
                style: TextStyle(
                  color: Color(0x99EEEEEE),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                children: [
                  CircleNumber(context, 'any'),
                  CircleNumber(context, '1'),
                  CircleNumber(context, '2'),
                  CircleNumber(context, '3'),
                  CircleNumber(context, '4'),
                  CircleNumber(context, '5'),
                ],
                borderRadius: BorderRadius.circular(10),

                fillColor: Color.fromRGBO(0, 173, 181, 1),
                selectedColor: Color.fromRGBO(0, 173, 181, 1),
                constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
                isSelected: [getNumSalon(0),getNumSalon(1),getNumSalon(2),getNumSalon(3),getNumSalon(4),getNumSalon(5)],

                onPressed: (index) {
                  setState(() {
                    numSalon=index;
                    _ListData['n_salon']=numSalon.toString();
                  });
                },

              ),
            ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Beds',
                  style: TextStyle(
                    color: Color(0x99EEEEEE),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  children: [
                    CircleNumber(context, 'any'),
                    CircleNumber(context, '1'),
                    CircleNumber(context, '2'),
                    CircleNumber(context, '3'),
                    CircleNumber(context, '4'),
                    CircleNumber(context, '5'),
                  ],
                  borderRadius: BorderRadius.circular(10),

                  fillColor: Color.fromRGBO(0, 173, 181, 1),
                  selectedColor: Color.fromRGBO(0, 173, 181, 1),
                  constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
                  isSelected: [getNumBed(0),getNumBed(1),getNumBed(2),getNumBed(3),getNumBed(4),getNumBed(5)],

                  onPressed: (index) {
                    setState(() {
                      numBed=index;
                      _ListData['n_bed']=numBed.toString();
                    });
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Bathrooms',
                  style: TextStyle(
                    color: Color(0x99EEEEEE),
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ToggleButtons(
                  children: [
                    CircleNumber(context, 'any'),
                    CircleNumber(context, '1'),
                    CircleNumber(context, '2'),
                    CircleNumber(context, '3'),
                    CircleNumber(context, '4'),
                    CircleNumber(context, '5'),
                  ],
                  borderRadius: BorderRadius.circular(10),

                  fillColor: Color.fromRGBO(0, 173, 181, 1),
                  selectedColor: Color.fromRGBO(0, 173, 181, 1),
                  constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width*0.2,),
                  isSelected: [getNumBathroom(0),getNumBathroom(1),getNumBathroom(2),getNumBathroom(3),getNumBathroom(4),getNumBathroom(5)],

                  onPressed: (index) {
                    setState(() {
                      numBathroom=index;
                      _ListData['n_bathroom']=numBathroom.toString();
                    });
                  },

                ),
              ),],),
      ),
      CoolStep(
        title: 'how big is it?',
          subtitle: 'add your place area and in which floor',
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: Text('the Area of your place',style: TextStyle(color: Colors.white),),
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() {
                          _ListData['area'] = value.toString();
                        });

                      },
                    ),
              ),
    Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),

    child:
    DropdownMenu(
    onSelected: (value) {_ListData['floor']=value.toString();
    print(_ListData['floor']);
    },

    hintText: 'The Floor',
    width: MediaQuery.of(context).size.width*0.8,
    inputDecorationTheme:

    InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

    ),
    dropdownMenuEntries: [
    DropdownMenuEntry(value: 'first', label: 'First'),
    DropdownMenuEntry(value: 'second', label: 'Second'),
    DropdownMenuEntry(value: 'third', label: 'Third'),
    DropdownMenuEntry(value: 'fourth', label: 'Fourth'),
    DropdownMenuEntry(value: 'fifth', label: 'Fifth'),
    DropdownMenuEntry(value: 'more than fifth', label: 'in the sky')
    ],
    ),)
            ],
          ),
        validation: () {
          if(_ListData['area']==0)return 'add place';
          return null;
        },
      ),
      CoolStep(
        title: 'Now for aminities',
          subtitle: 'dont know what aminities are!!!?',
          content: Column(
            children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wifi',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: wifi, onChanged: (value) => setState(() {
                    wifi=value!;
                    _ListData['wifi']=wifi.toString();
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Solar Power',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value:solarPower, onChanged: (value) => setState(() {
                    solarPower=value!;
                    _ListData['soloar_system']=solarPower.toString();
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Parking',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: parking, onChanged: (value) => setState(() {
                    parking=value!;
                    // _ListData['parking']=parking;
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Swimming pool',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: swimmingpool, onChanged: (value) => setState(() {
                    swimmingpool=value!;
                    _ListData['pool']=swimmingpool.toString();
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Garden',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: garden, onChanged: (value) => setState(() {
                    garden=value!;
                    _ListData['garden']=garden.toString();
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Furnished',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: furnished, onChanged: (value) => setState(() {
                    furnished=value!;
                    _ListData['furntiure']=furnished.toString();
                  }),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Elevator',
                    style: TextStyle(
                      color: Color(0x99EEEEEE),
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(value: elevator, onChanged: (value) => setState(() {
                    elevator=value!;
                    _ListData['elevator']=elevator.toString();
                  }),),
                ],
              ),
            ],
          ),
      ),
      CoolStep(
        title: 'Now for Description pre last step',
          subtitle: 'be generous on describing your place',
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    label: Text('Describe yor place',style: TextStyle(color: Colors.white),),
                  ),
                  onSubmitted: (value)async {setState(() {
                    _ListData['description'] = value.toString();
                    isLoading=true;
                  });
                   await _submit();
                    // Future.delayed(Duration(seconds: 3),() {
                    //   setState(() {
                    //     isLoading=false;
                    //   });
                    // },);
                  },
                ),
          ),
        validation: () {
          print(idUser);
          print(_ListData);
          if(_ListData['description']=='')return 'add desc';
          // Future.delayed(Duration(seconds: 3)).then((value) => null);
          return null;
        },
      ),
      CoolStep(
        title: 'Now time for image',
          subtitle: 'this is the last step , pls prov ur images',
          content:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text('asd'),
              ElevatedButton(onPressed: getImages, child: Text('add image'),
              style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 173, 181, 1),)
              ),
              ),
           selectedImages.isEmpty
            ? const Center(child: Text('Sorry nothing selected!!'))
                :
    // Text('2')
    //           for(int i=0 ;i<selectedImages.length;i++){
    // Image.file(selectedImages[i],fit: BoxFit.cover,width: 10,height: 10,));
    //           }
           Container(width: MediaQuery.of(context).size.width*0.8,height: MediaQuery.of(context).size.height*0.5,
             child: ListView.builder(

               itemCount: selectedImages.length,
               itemBuilder: (context, index) {
                 return Container(
                   margin: const EdgeInsets.all(5),
                   child: Image.file(
                     selectedImages[index],
                     fit: BoxFit.cover,
                      // Adjust height as needed
                   ),
                 );
               },
             ),
           ),
              ElevatedButton(onPressed: () {
                setState(() {
                  selectedImages.clear();
                });
              }, child: Text('reset'),
                style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(0, 173, 181, 1),)
                ),
              ),

            ],

          )
    ),

    ];

    void _onFinish() async{
      // print(http.MultipartFile.fromPath('image', selectedImages[0].path));
      // print(selectedImages[0].absolute);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token=json.decode(prefs.getString('userData')!)["token"];
      String cookie=json.decode(prefs.getString('userData')!)["cookie"];
      setState(() {
        isSubmitingImages=true;
      });
        // var request = http.MultipartRequest('POST', Uri.parse('https://dani2.pythonanywhere.com/images'));
        // request.headers.addAll({'Cookie': cookie,
        //   "Host":"dani2.pythonanywhere.com",
        //   "Origin":"https://dani2.pythonanywhere.com",
        //   "Referer":"https://dani2.pythonanywhere.com/images/",
        //   "X-Csrftoken":cookie.substring(10,42),
        // });
        // request.fields.addAll({"pid":"$idUser"});
        // request.files.add(await http.MultipartFile.fromPath('image', selectedImages[0].path));
// try{
//         // var response = await request.send();
//   final response=await http.post(Uri.parse('https://dani2.pythonanywhere.com/images'),
//       headers: {'Cookie': cookie,
//         "Host":"dani2.pythonanywhere.com",
//         "Origin":"https://dani2.pythonanywhere.com",
//         "Referer":"https://dani2.pythonanywhere.com/images/",
//         // "X-Csrftoken":cookie.substring(10,42),
//       },
//   body: {
//     "pid":"3",
//     "image":http.MultipartFile.fromPath('image', selectedImages[0].path)
//   }
//   );
//         print(response.body);}catch(e){print(e);}
      // Uri url = Uri.parse('http://a/create_sale_post');
      // var request = http.MultipartRequest('POST', url);
      //
      // for (var i = 0; i < selectedImages.length; i++) {
      //   var image = await http.MultipartFile.fromPath(
      //     'images',
      //     selectedImages[i].path,
      //   );
      //   print(image);
      //   request.files.add(image);
      // }

      //
      // var response = await request.send();
      // dioooo

      for (var i = 0; i < selectedImages.length; i++) {
        setState(() {
          indexImage=i+1;
        });
        var formData = FormData.fromMap({
          "pid": '10',
          "image": await MultipartFile.fromFile(selectedImages[i].path),
        });
        //http
        // var request = http.MultipartRequest('POST', Uri.parse('https://dani2.pythonanywhere.com/images/'));
        //   request.fields["pid"]=idUser.toString();
        //   request.files.add(http.MultipartFile.fromBytes('image', File(selectedImages[i].path).readAsBytesSync(),filename:selectedImages[i].path.split('/').last ));
        // var res = await request.send();
        // print(res.stream.last);
        // print(res.contentLength);
        // print(res.headers);
        // print(res.headersSplitValues);
        // print(res.reasonPhrase);
        // print(res);

        //dio
        Dio dio = Dio();
        try {
          print(formData);
          var response = await dio.post(
            'https://dani2.pythonanywhere.com/images/', data: formData,
            options: Options(headers: {
              "Content-Type": 'multipart/form-data',
              'Cookie': cookie,
              "Host": "dani2.pythonanywhere.com",
              "Origin": "https://dani2.pythonanywhere.com",
              "Referer": "https://dani2.pythonanywhere.com/images/",
              "X-Csrftoken": cookie.substring(10, 42),
            }, receiveDataWhenStatusError: true,),
          );
          print(response.data);
          // print(response.statusCode);

          // filename:
          // print(selectedImages[0].path
          //     .split('/')
          //     .last);
          // print(response.extra);
          // print(response.statusMessage);
          // print(response);
          _finalImages.add('https://dani2.pythonanywhere.com'+response.data["image"].toString());
        } catch (e) {
          print(e);
        }
      }
      // //third
      // var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse('https://dani2.pythonanywhere.com/images/'),
      // );
      // Map<String, String> headers = {"Content-type": "multipart/form-data",'Cookie': cookie,
      //     "Host":"dani2.pythonanywhere.com",
      //     "Origin":"https://dani2.pythonanywhere.com",
      //     "Referer":"https://dani2.pythonanywhere.com/images/",
      //   "X-Csrftoken":cookie.substring(10,42),
      // };
      // request.files.add(
      //   http.MultipartFile(
      //     'image',
      //     selectedImages[0].readAsBytes().asStream(),
      //     selectedImages[0].lengthSync(),
      //     filename: selectedImages[0].path.split('/').last,
      //   ),
      // );
      // request.fields.addAll({"pid":"3"});
      // request.headers.addAll(headers);
      // print("request: " + request.toString());
      // var res = await request.send();
      // print(res.stream);
      // http.Response response = await http.Response.fromStream(res);
      // print(response.body);


      //
      await Provider.of<Places>(context,listen: false).addProduct({..._finaldata,...{"image":_finalImages}});
      // print(_finaldata);
      // final place=Place(id: idUser, counter: _finaldata["counter"], owner: _finaldata["owner"], site: _finaldata["site"], description: _finaldata["description"], floor: _finaldata["floor"], idt: _finaldata["idt"], area: _finaldata["area"], n_salon: _finaldata["n_salon"], image: _finalImages, price: _finaldata["price"], n_bathroom:_finaldata["n_bathroom"] , n_bed: _finaldata["n_bed"], n_room: _finaldata["n_room"], elevator: _finaldata["elevator"], furntiure: _finaldata["furntiure"], garden: _finaldata["garden"], parking: _finaldata["parking"], type_r: _finaldata["type_r"], soloar_system: _finaldata["soloar_system"], pool: _finaldata["pool"], wifi: _finaldata["wifi"], rating: _finaldata["rating"], lan: _finaldata["lan"], lat: _finaldata["lat"], ratestate: _finaldata["ratestate"]);
      // print(place);
      setState(() {
        isSubmitingImages=false;
      });
      final flush =  Flushbar(
        message: 'Steps completed!',
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(milliseconds: 3400),
        leftBarIndicatorColor: Colors.green,
      );
      await flush.show(context).then((value)  {
        print(_ListData);
        // _submit();
          Navigator.of(context).popAndPushNamed('./yourPlaces');
      });


    }

    final stepper = CoolStepper(
      showErrorSnackbar: true,
      hasRoundedCorner: true,
      onCompleted: _onFinish,
      contentPadding: EdgeInsets.only(left: 40, right: 40),
      config: CoolStepperConfig(
        titleTextStyle: TextStyle(color: Colors.white),
        subtitleTextStyle: TextStyle(color: Colors.white70),
        stepColor:Color.fromRGBO(34, 40, 49, 1),
        headerColor: Color.fromRGBO(34, 40, 49, 1),

        finishButton:isSubmitingImages?Expanded(child: Row(
          children: [
            Text('$indexImage/${selectedImages.length}'),
            CircularProgressIndicator()
          ],
        )) :Container(
          child: RippleButton(
             'Finish',
            type: RippleButtonType.AMBER,
            padding: EdgeInsets.only(right: 16, bottom: 6),
            style: RippleButtonStyle(
              width: 20,

            ),
            onPressed: () => {
               // _submit()
            },
          ),
        ),
        backButton: RippleButton(
         'Back',
          color: RippleButtonColor(foreground: Colors.white,background: Color.fromRGBO(34, 40, 49, 1)),
          // type: RippleButtonType.BLUE_TRANSLUCENT,
          border: RippleButtonBorder(radius: BorderRadius.circular(20),side: BorderSide(color:Color.fromRGBO(0, 173, 181, 1) )),
          padding: EdgeInsets.only(left: 16, bottom: 6),
          style: RippleButtonStyle(
            width: 24,
          ),
          onPressed: () => {},
        ),
        nextButton: isLoading?CircularProgressIndicator():RippleButton(
           'Next',
color: RippleButtonColor(background: Color.fromRGBO(0, 173, 181, 1),foreground: Colors.white),
          border: RippleButtonBorder(radius: BorderRadius.circular(20)),
          // type: RippleButtonType.BLUE_TELEGRAM,
          padding: EdgeInsets.only(right: 16, bottom: 6),
          style: RippleButtonStyle(
            width: 20,

          ),
          onPressed: () => {},
        ),
      ),

      steps: steps,
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,

        backgroundColor: Color.fromRGBO(57, 62, 70, 1),
        title: Text(
          'List your place',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,

          ),
        ),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }

  // Widget _buildTextField({
  //   String? labelText,
  //   FormFieldValidator<String>? validator,
  //   TextEditingController? controller,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 20.0),
  //     child: TextFormField(
  //       decoration: InputDecoration(
  //         labelText: labelText,
  //       ),
  //       validator: validator,
  //       controller: controller,
  //     ),
  //   );
  // }

  // Widget _buildSelector({
  //   BuildContext? context,
  //   required String name,
  // }) {
  //   final isActive = name == selectedRole;
  //
  //   return Expanded(
  //     child: AnimatedContainer(
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.easeInOut,
  //       decoration: BoxDecoration(
  //         color: isActive ? Theme.of(context!).primaryColor : null,
  //         border: Border.all(
  //           width: 0,
  //         ),
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       child: RadioListTile(
  //         value: name,
  //         activeColor: Colors.white,
  //         groupValue: selectedRole,
  //         onChanged: (String? v) {
  //           setState(() {
  //             selectedRole = v;
  //           });
  //         },
  //         title: Text(
  //           name,
  //           style: TextStyle(
  //             color: isActive ? Colors.white : null,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Future getImages() async {
    final picker=ImagePicker();
    try {
      final pickedFile = await picker.pickMultiImage(
          maxWidth: 600, maxHeight: 600);

      List<XFile> xfilePick = pickedFile;
      List rowimage = [];
      setState(
            () {
          if (xfilePick.isNotEmpty) {
            for (var i = 0; i < xfilePick.length; i++) {
              selectedImages.add(File(xfilePick[i].path));
              rowimage.add(xfilePick[i]);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nothing is selected')));
          }
          print(selectedImages);
        },
      );

    }catch(e){print(e);}
  }
}
