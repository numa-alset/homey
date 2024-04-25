import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:homey/provider/favorite.dart';
import 'package:homey/provider/places.dart';
import 'package:provider/provider.dart';
import '../screens/place_detail.dart';
import '../model/place.dart';
class HomeItem extends StatelessWidget {
  int id;
  String name;
  String type;
  String text;
  HomeItem({
  required this.id,
  required this.name,
  required this.type,
  required this.text,
});
//   List get placesFilter{
//    return places.where((e) => e['type']==type).toList();
//   }
//   Map<String,dynamic> map={
//       'id':'1',
//
//   };
//  List image=[
//   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
// ];
//
// List<CarouselItem>  items(int i) {
//   // return image.map((e) {return CarouselItem(image: image[e],title: 'title',);})as List<CarouselItem>;
//   List<CarouselItem> listee = [];
//   // =[CarouselItem(image:NetworkImage('https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',) )];
// // for(var i=0;i<placesFilter.length;i++){
// //   print(placesFilter[i]['image']);
//   for (var j = 0; j < (placesFilter[i]['image'] as List).length; j++) {
//     // print(placesFilter[i]['image'][j]);
//     listee.add(CarouselItem(
//         image: NetworkImage(placesFilter[i]['image'][j].toString())));
//   }
// // }
// //   places.map((e) {
// //     if(e['type'=='home']){
// //       for(var i=0;i<e['image'].length;i++){
// //   listee.add(CarouselItem(image: NetworkImage(e['image'][i])));
// // }
// //     }
// //   });
// if(listee.isEmpty)return [CarouselItem(image:NetworkImage('https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',), )];
// // print('here');
// // print(listee);
// return listee;
// // return image
// }


  @override
  Widget build(BuildContext context) {

  // print(placesFilter);
  //  final placesProvider= Provider.of<Places>(context);
   // placesProvider.placesFilterByType(type);
   final places=Provider.of<Places>(context).placesFilterByType(type, text);
   final carosal= Provider.of<Places>(context);
  return RefreshIndicator(
    onRefresh: () => carosal.fetchAndSetProduct(),
    child: Center(
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) =>
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  // padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.1 ,vertical: 10),
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0, MediaQuery.of(context).size.width*0.05, 1),
                  child: Stack(
                    children:[ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(

                                  child: CustomCarouselSlider(items: carosal.items(places[index].id,context),autoplay: false,showSubBackground: false,),
                              // Hero(,
                              //   tag: places[index].id,
                              //   child:
                              //   CustomCarouselSlider(items: carosal.items(places[index].id),autoplay: false,showSubBackground: false,)
                              //   // CarouselSlider(items: image.length, options: options)
                              //   // FadeInImage(
                              //   //   placeholder: AssetImage('assets/images/product-placeholder.png'),
                              //   //   image:NetworkImage('https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg') ,
                              //   //   fit:BoxFit.cover ,
                              //   // ),
                              // ),

                          footer: GridTileBar(
                            title: Text(''),
                            leading:Text('') ,
                            trailing:Text('') ,
                          ),
                        ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<Favourite>(

                        builder: (context, fav, child) =>  IconButton(icon: fav.isFav(places[index].id)? Icon(Icons.favorite_outlined,color: Colors.yellow[100]):Icon(Icons.favorite_outline,color: Colors.yellow[100]),
                        onPressed: () {
                          fav.isFav(places[index].id)?fav.deleteFav(places[index].id):fav.addFav(places[index].id);

                        },
                        ),
                      ),
                    ),
                    ],
                        alignment: Alignment.topRight,
                  ),

                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.05 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(places[index].site,style: TextStyle(
                        color: Color(0xFFEEEEEE),
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: 0.09,
                      ),),
                      TextButton.icon(onPressed: null, icon: Icon(Icons.star_border,color: Colors.yellow,), label: Text('32',style: TextStyle(
                        color: Color(0xFFEEEEEE),
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0.06,
                        letterSpacing: 0.09,
                      ),),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,0,0,MediaQuery.of(context).size.height*0.03),
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '\$230 USD ',
                          style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 0.06,
                            letterSpacing: 0.09,
                          ),
                        ),
                        TextSpan(
                          text: 'night',
                          style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w300,
                            height: 0.06,
                            letterSpacing: 0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

      ),
    ),
  );

}
}
