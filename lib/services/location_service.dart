import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getGeoLocationPosition(
  BuildContext context, 
  Function(Position) onPositionReceived) async{
    // geolocator ngambil data dari lokasi device
    // ignore: deprecated_member_use
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // kenapa pake 'low'? lebih cepet, hemat baterai
    onPositionReceived(position);
}

Future<void> getAddressFromLongLat(Position position, Function(String) onAddressReceived) async{
  // geocoding sebagai pelengkap geolocator, memberikan detail yang lebih detail dari posisi device
  // long = horizontal, lat = vertical
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemark[0]; // geolocator & geocoding otomatis ngasih data 
  String address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  onAddressReceived(address);
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off_rounded, 
            color: Colors.white
          ),
          SizedBox(width: 10),
          Text(
            "Location services are disabled. Please enable the services.",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false; // gak execute apa-apa, gak akan jalan
  }
  // return false; untuk nilai true nya ↓↓↓

  // pop-up akan muncul lagi setelah aplikasi di-kill
  // kondisi ketika di deny
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.location_off_rounded,
              color: Colors.white
            ),
            SizedBox(width: 10),
            Text(
              "Location permission denied.",
              style: TextStyle(color: Colors.white),
            )
          ] 
        ),
        backgroundColor: Colors.blueGrey,
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      ));
      return false; // untuk memblokir user, user gak bisa akses aplikasi
    }
  }

  // pop-up gak muncul lagi setelah aplikasi di-kill
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.location_off_rounded,
            color: Colors.white
          ),
          SizedBox(width: 10),
          Text(
            "Location permission forever denied, we can not access.",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }
  return true; // user bisa melanjutkan aktivitasnya di aplikasi, karena udah kasih akses
}