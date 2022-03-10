import 'package:flutter/material.dart';
import 'package:upwork_assignment/model/hotel_model.dart';
import 'package:upwork_assignment/view/hotel_location_screen.dart';

class HotelDetailScreen extends StatelessWidget {
  final HotelModel hotel;
  const HotelDetailScreen(this.hotel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details'), centerTitle: true,actions: [
        IconButton(onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HotelLocationScreen(
                  hotelId: '${hotel.id}', name: hotel.title,
                  address: hotel.address, lat: hotel.latitude, lng: hotel.longitude
              ),));
        }, icon: const Icon(Icons.location_on))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Image.network(
              hotel.image.large,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image,size: 120,),);
            },
            loadingBuilder: (context,widget,event){
                return const SizedBox(height:120,child: Center(child: CircularProgressIndicator(),));
            },
          ),
          const SizedBox(height: 8,),
          Text(hotel.title,style: Theme.of(context).textTheme.headline6,),
          const SizedBox(height: 4,),
          Text(hotel.description,style: Theme.of(context).textTheme.bodySmall,),
        ],),
      ),
    );
  }
}
