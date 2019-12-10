import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/place.dart';
import 'dart:io';
import '../helpers/locationHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart' as sql;
import '../helpers/dbHelper.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String name) {
    return _items.firstWhere((place) => place.name == name);
  }

  Future<void> addPlace(
      String pickedName,
      String pickedAddress,
      String pickedNumber,
      String pickedReview,
      File pickedImage,
      PlaceLocation pickedLocation,) async {

    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    String sendAddress = "";

    if (pickedAddress == "" && updatedLocation.address != ""){
      sendAddress = updatedLocation.address;
    }
    else if (updatedLocation.address == "" && pickedAddress != ""){
      sendAddress = pickedAddress;
    }

    final Map<String, dynamic> locationData = {
      'Name': pickedName,
      'Address': sendAddress,
      'Phone': pickedNumber,
      'Review': pickedReview,
    };
    DBHelper.addLocation(locationData);


// NEED TO INSERT DATA INTO A PLACES TABLE IN DB

// NEED A FETCH AND SET PLACES FUNCTION
// VIDEOS 255 & 256 IN UDEMY. IMPLEMENT IN MYSQL
  }
}
