import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:homey/widgets/owner_place_list.dart';
import 'package:provider/provider.dart';

class OwnerPlaces extends StatefulWidget {
final int ownerid;
OwnerPlaces(this.ownerid);

  @override
  State<OwnerPlaces> createState() => _OwnerPlacesState();
}

class _OwnerPlacesState extends State<OwnerPlaces> {
  @override
  void initState() {
    isLoading=true;
    Provider.of<Places>(context,listen: false).fetchAndSetOwnerPlaces(widget.ownerid).then((value) => setState(() {
      isLoading=false;
    }));
    // TODO: implement initState
    super.initState();
  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {



      final provider= Provider.of<Places>(context).ownerPlaces;
      // final image= Provider.of<Places>(context);
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Owner places',
            style: TextStyle(
              color: Color(0xFFEEEEEE),
              fontSize: 25,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: isLoading?Center(child: CircularProgressIndicator(),) :Padding(padding: EdgeInsets.symmetric(horizontal: 1,vertical: 20),
          child: ListView.builder(
            itemCount: provider.length,
            itemBuilder: (context, index) => OwnerPlaceList(id: provider[index].id,name: provider[index].name, price: provider[index].price, rate: provider[index].rate[0], image: provider[index].images),
          ),
        ),
      );

  }
}
