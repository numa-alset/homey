
import 'dart:io';
// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:homey/widgets/map_select.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';
import 'package:ripple_button/ripple_button.dart';
import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:homey/widgets/circle_number.dart';

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
  Map<String, dynamic> _ListData = {
    'type':'',
    'name':'s',
    'price': 0,
    'priceMonthly': true,
    'numBedroom':0,
    'numBed':0,
    'numBathroom':0,
    'area':'',
    'wifi':false,
    'solarPower':false,
    'furnished':false,
    'garden':false,
    'parking':false,
    'swimmingpool':false,
    'elevator':false,
    'describe':'',
    'images':<File>[],
    'lan':0.2,
    'lat':0.4,

  };
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
  void _submit(){
    Navigator.of(context).pop();

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
                    onSelected: (value) {_ListData['type']=value;
                      print(_ListData['type']);
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
              DropdownMenuEntry(value: 'home', label: 'home'),
              DropdownMenuEntry(value: 'shop', label: 'shop'),
              DropdownMenuEntry(value: 'lounge', label: 'lounge'),
              DropdownMenuEntry(value: 'chalet', label: 'chalet'),
              DropdownMenuEntry(value: 'villa', label: 'villa'),
              DropdownMenuEntry(value: 'farm', label: 'farm')
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
                    _ListData['name']=value[2];
                    setState(() {
                      isFinished=true;
                    });
                    print(_ListData['name']);
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
          if (_ListData['name']=='') {
            return 'please add ur location';
          }
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
                      _ListData['price'] = value;
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
                    _ListData['priceMonthly']=mounthly;
                  },
                ),
              ),
          ],
        ),
        validation: () {
          if (_ListData['price']==0) {
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
                      _ListData['numBedroom']=numBedroom;
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
                    _ListData['numSalon']=numSalon;
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
                      _ListData['numBed']=numBed;
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
                      _ListData['numBathroom']=numBathroom;
                    });
                  },

                ),
              ),],),
      ),
      CoolStep(
        title: 'how big is it?',
          subtitle: 'add your place area ',
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    label: Text('the Area of your place',style: TextStyle(color: Colors.white),),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    setState(() {
                      _ListData['area'] = value;
                    });

                  },
                ),
          ),
        validation: () {
          if(_ListData['area']=='')return 'add place';
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
                    _ListData['wifi']=wifi;
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
                    _ListData['solarPower']=solarPower;
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
                    _ListData['parking']=parking;
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
                    _ListData['swimmingpool']=swimmingpool;
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
                    _ListData['garden']=garden;
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
                    _ListData['furnished']=furnished;
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
                    _ListData['elevator']=elevator;
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
                  onSubmitted: (value) {setState(() {
                    _ListData['describe'] = value;
                  });

                  },
                ),
          ),
        validation: () {
          if(_ListData['describe']=='')return 'add desc';
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
      // request.fields["Title"] = title;
      // request.fields["Description"] = description;
      // request.fields["City"] = city;
      // request.fields["Species"] = species;
      // request.fields["Price"] = price;
      // request.fields["Sex"] = sex;
      // request.fields["Years"] = ageYears;
      // request.fields["Months"] = ageMonths;
      // request.fields["Breed"] = breed;
      // request.headers['Content-Type'] = 'multipart/form-data';
      // request.headers['token'] = 'multipart/form-data';
      //
      // var response = await request.send();
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
        duration: Duration(milliseconds: 1400),
        leftBarIndicatorColor: Colors.green,
      );
      await flush.show(context).then((value)  {print(_ListData);
          Navigator.of(context).popAndPushNamed('./yourPlaces');});


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

        finishButton: Container(
          child: RippleButton(
             'Finish',
            type: RippleButtonType.AMBER,
            padding: EdgeInsets.only(right: 16, bottom: 6),
            style: RippleButtonStyle(
              width: 20,

            ),
            onPressed: () => {
               _submit()
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
        nextButton: RippleButton(
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
        },
      );

    }catch(e){print(e);}
  }
}
