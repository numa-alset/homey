import 'package:flutter/material.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';

class DesUpdate extends StatefulWidget {
 final int id;
DesUpdate(this.id);

  @override
  State<DesUpdate> createState() => _DesUpdateState();
}

class _DesUpdateState extends State<DesUpdate> {

 bool isLoadingDes=false;
 final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _descriptionController,
        decoration: InputDecoration(

          labelText: 'set the new des',
          enabledBorder: InputBorder.none,
          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 2)),

          suffixIcon:isLoadingDes?CircularProgressIndicator(): Icon(Icons.edit,color: Colors.white,),
        ),
        onSubmitted: (value) {
          setState(() {
            isLoadingDes=true;
          });
          Provider.of<Places>(context,listen: false).updatePlace(widget.id.toString(), 'description', value).then((value) => setState(() {
            isLoadingDes=false;
            _descriptionController.clear();
          }));
        },
      ),
    );
  }
}
