import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

class PriceUpdate extends StatefulWidget {
  final int id;
  PriceUpdate(this.id);

  @override
  State<PriceUpdate> createState() => _DesUpdateState();
}

class _DesUpdateState extends State<PriceUpdate> {

  bool isLoadingDes=false;
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _descriptionController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
    border: InputBorder.none,
          labelText: 'set the new price',
          //
          // border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),

          suffixIcon:isLoadingDes?CircularProgressIndicator(): Icon(Icons.edit,color: Colors.white,),
        ),
        onSubmitted: (value) {
          setState(() {
            isLoadingDes=true;
          });
          Provider.of<Places>(context,listen: false).updatePlace(widget.id.toString(), 'price', value).then((value) => setState(() {
            isLoadingDes=false;
            _descriptionController.clear();
          }));
        },
      ),
    );
  }
}
