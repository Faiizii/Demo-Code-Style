import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelLocationScreen extends StatefulWidget {
  final String hotelId, name, address;
  final double lat;
  final double lng;
  const HotelLocationScreen({
    Key? key,
    required this.hotelId,
    required this.name,
    required this.address,
    required this.lat ,
    required this.lng,
  }) : super(key: key);

  @override
  _HotelLocationScreenState createState() => _HotelLocationScreenState();
}

class _HotelLocationScreenState extends State<HotelLocationScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex ;
  late Set<Marker> _marker;

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 16,
    );
    _marker = {
      Marker(
          markerId: MarkerId(widget.hotelId),
          position: LatLng(widget.lat, widget.lng),
          infoWindow: InfoWindow(title: widget.name, snippet: widget.address)
      )
    };
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map'),centerTitle: true),
      body: GoogleMap(
        markers: _marker,
        initialCameraPosition: _kGooglePlex,
        scrollGesturesEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
  Future<void> _goToTheLake() async {
    const CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
