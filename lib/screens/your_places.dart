import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/my_place_list.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class YourPlaces extends StatefulWidget {


  @override
  State<YourPlaces> createState() => _YourPlacesState();
}

class _YourPlacesState extends State<YourPlaces> {
  @override
  void initState() {
    isLoading=true;
 Provider.of<Places>(context,listen: false).fetchAndSetYours().then((value) => setState(() {
   isLoading=false;
 }));
    // TODO: implement initState
    super.initState();
  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<Places>(context).yours;
    // final image= Provider.of<Places>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Your places',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 25,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: isLoading?Center(child: CircularProgressIndicator(),) :Padding(padding: EdgeInsets.symmetric(horizontal: 1,vertical: 20),
      child:provider.isEmpty?Center(child: Text('you didnt post any places yet'),) :ListView.builder(
          itemCount: provider.length,
          itemBuilder: (context, index) {
            final item=provider[index];
           return Dismissible(
                key: Key(provider[index].id.toString()),
                background: Container(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .error,
                  child: Icon(Icons.delete, color: Colors.white, size: 40,),
                  alignment: Alignment.centerRight,
                  // padding: EdgeInsets.only(right: 20),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  Provider.of<Places>(context, listen: false).deletePlace(
                      provider[index].id.toString()).then((value) => setState(() {
                    provider.removeAt(index);

                  }));

                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromRGBO(57, 62, 70, 1),
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you wish to delete this item?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                print('done');
                                // Provider.of<Places>(context,listen: true).deletePlace(provider[index].id.toString());
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("DELETE")
                          ),
                          TextButton(
                            onPressed: () {
                              print('done');
                              Navigator.of(context).pop(false);
                            },
                            child: const Text("CANCEL"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: MyPlaceList(id: provider[index].id,
                    name: provider[index].name,
                    price: provider[index].price,
                    rate: provider[index].rate[0],
                    ratestate: provider[index].ratestate,
                    image: provider[index].images));

          } ),
      ),
    );
  }
}
